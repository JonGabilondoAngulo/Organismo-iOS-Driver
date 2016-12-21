//
//  ORGUIViewHierarchy
//

#import "ORGUIViewHierarchy.h"
#import "ORGScreenshot.h"
#import "NSDictionary+ORG.h"
#import "NSString+ORG.h"
#import "UIView+ORG.h"



#pragma mark -

@implementation ORGUIViewHierarchy

+ (NSArray*)windowsElementTree:(NSDictionary*)properties skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots {
    
    NSMutableArray * tree = [NSMutableArray array];
    for (UIWindow * window in [UIApplication sharedApplication].windows) {
        if ([self mustReportTreeOfWindow:window properties:properties]) {
            NSDictionary * node = [self viewElementTree:window skipPrivateClasses:skipPrivate viewScreenshots:viewScreenshots];
            if (node) {
                [tree addObject:node];
            }
        }
    }
    return tree;
}

+ (NSArray*)mainWindowElementTree:(NSDictionary*)properties skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots {
    
    UIWindow * mainWindow = [ORGUIViewHierarchy rootWindow:[UIApplication sharedApplication]];
    NSDictionary * node = [self viewElementTree:mainWindow skipPrivateClasses:skipPrivate viewScreenshots:viewScreenshots];
    return @[node];
}

+ (NSDictionary*)viewElementTree:(UIView*)view skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots {
    NSMutableDictionary * node = [NSMutableDictionary dictionary];

    if (!view) {
        return nil;
    }
    
//    if ([view ORG_isApplePrivateClass]) {
//        node[@"class"] = NSStringFromClass([view class]);
//        node[@"private"] = @YES;
//        node[@"ignore"] = @YES;
//    }
    [node addEntriesFromDictionary:[view ORG_viewProperties]];
    
    if (![view ORG_isApplePrivateClass]) {
        if (viewScreenshots && [view ORG_needsScreenshot]) {
            NSData *imageData = [ORGScreenshot viewScreenshotPNG:view];
            if (imageData) {
                node[@"screenshot"] = [NSString ORG_base64StringFromData:imageData length:imageData.length];
            }
        }
    }
    
    // Run subviews. Unless is some kind of control that there is no need to dive in.
    if ([view ORG_ignoreSubviews]) {
        return node;
    }
    
    NSMutableArray * children = [NSMutableArray array];
    for (UIView *subView in view.subviews) {
        NSDictionary * child = [self viewElementTree:subView skipPrivateClasses:skipPrivate viewScreenshots:viewScreenshots];
        if (child) {
            [children addObject:child];
        }
    }
    
    // Attention. Handle the case of "_UIRemoteKeyboardPlaceholderView" where the "subview" is actually in "placeheldView"
    // http://developer.limneos.net/?ios=8.0&framework=UIKit.framework&header=_UIRemoteKeyboardPlaceholderView.h
    if ([view respondsToSelector:@selector(placeheldView)]) {
        UIView * subView = [view performSelector:@selector(placeheldView)];
        if (subView) {
            NSDictionary * child = [self viewElementTree:subView skipPrivateClasses:skipPrivate viewScreenshots:viewScreenshots];
            if (child) {
                [children addObject:child];
            }
        }
    }
    
    if (children.count) {
        node[@"subviews"] = children;
    }

    return node;
}

+ (NSDictionary*)elementInfoAtLocation:(CGPoint)location {
    NSDictionary * elementInfo;
    return elementInfo;
}

- (UIView*)findViewAtPoint:(CGPoint)pt rootView:(UIView*)rootView
{
    //-
    // Isn't better to use hitTest ? NO ! hitTest ignores if user labels etc.
    //-
    
    UIView * view = rootView; // we assume that if no subviews hit the hit is in the rootview
    
    for (UIView * runningView in [rootView.subviews reverseObjectEnumerator]) {
        
        if ([runningView isHidden]) {
            continue;
        }
        if (runningView.alpha==0) {
            continue; // attention found Apps that have views on top(most) that are transparent. If not ignored Spy does not work. We used to check here also userInteractionEnabled is false, but we took it off as checking the alpha is enought to understand that we need to ignore the view.
        }
        
        CGPoint ptInLocalView = [runningView convertPoint:pt fromView:nil];
        if ([runningView pointInside:ptInLocalView withEvent:nil]) {
            UIView * innerView = [self findViewAtPoint:pt rootView:runningView];
            if (innerView) {
                view = innerView;
            }
            break;
        }
    }
    return view;
}


#pragma mark Windows


+ (BOOL)mustReportTreeOfWindow:(UIWindow*)window properties:(NSDictionary*)properties {
    BOOL result = false;
    if (window.windowLevel == UIWindowLevelAlert) {
        return [properties[@"alert"] boolValue];
    }
    if (window.windowLevel == UIWindowLevelStatusBar) {
        return [properties[@"status-bar"] boolValue];
    }
    if ([NSStringFromClass([window class]) isEqual:@"UITextEffectsWindow"]) {
        return [properties[@"keyboard"] boolValue];
    }
    if (window.windowLevel == UIWindowLevelNormal) {
        return [properties[@"normal"] boolValue];
    }
    return result;
}

+ (NSArray*)appWindows:(UIApplication*)app ignoreKeyboards:(BOOL)ignoreKeyboards {
    NSMutableArray * windows = [NSMutableArray array];
    for (UIWindow * window in [app.windows reverseObjectEnumerator]) {
        if (ignoreKeyboards && [NSStringFromClass([window class]) isEqual:@"UITextEffectsWindow"]) {
            // ignore keyboard
        } else {
            [windows addObject:window];
        }
    }
    return windows;
}

+ (UIWindow*)rootWindow:(UIApplication*)app {
    // Attention, should we not check the Level of the window ? We want the main window
    //    const UIWindowLevel UIWindowLevelNormal;
    //    const UIWindowLevel UIWindowLevelAlert;
    //    const UIWindowLevel UIWindowLevelStatusBar;
    
    UIWindow *theWindow;
    UIWindow *keyWindow = [app keyWindow];
    if (keyWindow && keyWindow.windowLevel!=UIWindowLevelAlert && keyWindow.windowLevel!=UIWindowLevelStatusBar) {
        theWindow = keyWindow;
    } else for (UIWindow * window in app.windows) {
        if (window.windowLevel!=UIWindowLevelAlert && window.windowLevel!=UIWindowLevelStatusBar) {
            theWindow = window;
            break;
        }
    }
    return theWindow;
}


@end
