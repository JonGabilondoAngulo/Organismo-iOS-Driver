//
//  ORGRequestTakeScreenshot.m
//  organismo
//
//  Created by Jon Gabilondo on 30/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestScreenshot.h"
#import "ORGScreenshot.h"
#import "NSString+ORG.h"

@implementation ORGRequestScreenshot

- (void)execute {
    
    // working on UI better done on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* screenshotData = [ORGScreenshot screenshotJPEG];
        if (screenshotData) {
            
            // Send the screenshot in secondary thread
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *base64StringOfImage = [NSString ORG_base64StringFromData:screenshotData length:(int)screenshotData.length];
                if (base64StringOfImage) {
                    [self respondSuccessWithResult:@{@"screenshot":base64StringOfImage}];
                }
            });
        } else {
            [self respondWithError:111 description:@""];
        }
    });
}

@end
