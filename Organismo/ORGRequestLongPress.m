//
//  ORGRequestLongPress.m
//  Organismo
//
//  Created by Jon Gabilondo on 04/04/2017.
//  Copyright © 2017 organismo-mobile. All rights reserved.
//

#import "ORGRequestLongPress.h"
#import "ORGGestureLongPress.h"

@implementation ORGRequestLongPress

- (void)execute {
    
    // working on UI better done on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[[ORGGestureLongPress alloc] initWithParameters:self.parameters] execute];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self respondSuccessWithResult:nil];
        });
    });
}

@end
