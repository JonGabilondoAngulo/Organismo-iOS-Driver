//
//  ORGScreenshot.m
//  organismo
//
//  Created by Jon Gabilondo on 30/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGScreenshot.h"
#import "UIView+ORG.h"

#define ORG_SCREENSHOT_JPEG_QUALITY 0.75

@implementation ORGScreenshot

+ (UIImage *)screenshot
{
    CGSize imageSize = CGSizeZero;
    imageSize = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 1.0); // scale 1.0 because w don't want the retina resolutions ! if 0 uses screen.scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO]; // YES was the original Jon changed to NO hoping for faster results
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSData*)screenshotPNG {
    return UIImagePNGRepresentation([self screenshot]);
}

+ (NSData*)screenshotJPEG {
    return UIImageJPEGRepresentation( [self screenshot], ORG_SCREENSHOT_JPEG_QUALITY); // 0 is lowest quality
}

+ (UIImage*)viewScreenshot:(UIView*)view {
    const NSUInteger kImageAreaLimit = 1000000;  // Avoid unreasonable sized images that can gobble the memory.
    CGRect viewBounds = view.bounds;
    if (CGRectGetWidth(viewBounds) * CGRectGetHeight(viewBounds) > kImageAreaLimit) {
        return nil;
    }
    if (CGRectGetWidth(viewBounds)==0 || CGRectGetHeight(viewBounds)==0) {
        return nil;
    }
    
    // hide subviews. Unless is some control that we are not diving in, (e.g. Pickers).
    NSMutableArray * hiddenSubviews = [NSMutableArray array];
    if (![view ORG_ignoreSubviews]) {
        for (UIView *subview in view.subviews) {
            if (![subview isHidden]) {
                [subview setHidden:YES];
                [hiddenSubviews addObject:subview];
            }
        }
        if (hiddenSubviews.count) {
            [view setNeedsDisplay];
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(viewBounds.size, NO, 1.0); // scale 1.0 because w don't want the retina resolutions !
    [view drawViewHierarchyInRect:viewBounds afterScreenUpdates:YES];
    //[view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (hiddenSubviews.count) {
        for (UIView *subview in hiddenSubviews) {
            [subview setHidden:NO];
        }
        [view setNeedsDisplay];
    }
    return image;
}

+ (NSData*)viewScreenshotPNG:(UIView*)view {
    return UIImagePNGRepresentation([self viewScreenshot:view]);
}

+ (NSData*)viewScreenshotJPEG:(UIView*)view {
    return UIImageJPEGRepresentation([self viewScreenshot:view], ORG_SCREENSHOT_JPEG_QUALITY); // 0 is lowest quality
}


@end
