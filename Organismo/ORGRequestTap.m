//
//  ORGRequestTap.m
//  Organismo
//
//  Created by Jon Gabilondo on 18/09/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestTap.h"
#import "ORGGestureTap.h"

@implementation ORGRequestTap

- (void)execute {
    
    // working on UI better done on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[[ORGGestureTap alloc] initWithParameters:self.parameters] execute];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self respondSuccessWithResult:nil];
        });
    });
}

@end
