//
//  ORGNSViewHierarchy
//

#import "ORGNSViewHierarchy.h"
//#import "ORGScreenshot.h"
//#import "NSDictionary+ORG.h"
//#import "NSString+ORG.h"
//#import "UIView+ORG.h"



#pragma mark -

@implementation ORGNSViewHierarchy

+ (NSArray*)windowsElementTree:(NSDictionary*)properties skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots {
    
    NSMutableArray * tree = [NSMutableArray array];
    for (NSWindow * window in [NSApplication sharedApplication].windows) {
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
    
    NSWindow * mainWindow = [ORGNSViewHierarchy mainWindow:[NSApplication sharedApplication]];
    NSDictionary * node = [self viewElementTree:mainWindow skipPrivateClasses:skipPrivate viewScreenshots:viewScreenshots];
    return @[node];
}

+ (void)childNodes:(ORGUITreeNode*)node skipPrivateClasses:(BOOL)skipPrivate screenshots:(BOOL)takeScreenshots recursive:(BOOL)deep {

    NSView *startView;
    if ([node.view isKindOfClass:[NSWindow class]]) {
        NSWindow *window = node.view;
        startView = window.contentView;
    } else {
        startView = node.view;
    }
    
    for (NSView *subView in startView.subviews) {
        ORGUITreeNode *childNode = [[ORGUITreeNode alloc] initWithView:subView];
        [node.subviews addObject:childNode];
        if (deep) {
            [self childNodes:childNode skipPrivateClasses:skipPrivate screenshots:takeScreenshots recursive:deep];
        }
    }
}

+ (NSDictionary*)viewElementTree:(NSView*)view skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots {
    NSMutableDictionary * node = [NSMutableDictionary dictionary];

    if (!view) {
        return nil;
    }
    
//    [node addEntriesFromDictionary:[view ORG_viewProperties]];
    
//    if (![view ORG_isApplePrivateClass]) {
//        if (viewScreenshots && [view ORG_needsScreenshot]) {
//            NSData *imageData = [ORGScreenshot viewScreenshotPNG:view];
//            if (imageData) {
//                node[@"screenshot"] = [NSString ORG_base64StringFromData:imageData length:imageData.length];
//            }
//        }
//    }
    
    // Run subviews. Unless is some kind of control that there is no need to dive in.
//    if ([view ORG_ignoreSubviews]) {
//        return node;
//    }
    
    NSMutableArray * children = [NSMutableArray array];
    for (NSView *subView in view.subviews) {
        NSDictionary * child = [self viewElementTree:subView skipPrivateClasses:skipPrivate viewScreenshots:viewScreenshots];
        if (child) {
            [children addObject:child];
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

#pragma mark Windows

+ (BOOL)mustReportTreeOfWindow:(NSWindow*)window properties:(NSDictionary*)properties {
    BOOL result = true;
    return result;
}

+ (NSArray<NSWindow*>*)appWindows:(NSApplication*)app {
    NSMutableArray * windows = [NSMutableArray array];
    for (NSWindow * window in app.windows) {
        if ([window.identifier isEqualToString:@"ORG"] == NO) {
            [windows addObject:window];
        }
    }
    return windows;
}

+ (NSWindow*)keyWindow:(NSApplication*)app {
    return [app keyWindow];
}

+ (NSWindow*)mainWindow:(NSApplication*)app {
    return [app mainWindow];
}


@end
