//
//  ORGRequestCoreMotionFeed.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/03/2018.
//  Copyright © 2018 organismo-mobile. All rights reserved.
//

#import "ORGRequestCoreMotionFeed.h"
#import "ORGCoreMotion.h"

@implementation ORGRequestCoreMotionFeed

- (void)execute {
    if (self.parameters[@"enable"]) {
        [ORGCoreMotion sharedInstance].webSocket = self.webSocket;
    } else {
        [ORGCoreMotion sharedInstance].webSocket = nil;
    }
}

@end
