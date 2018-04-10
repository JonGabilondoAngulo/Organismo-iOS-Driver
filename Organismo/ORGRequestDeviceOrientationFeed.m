//
//  ORGRequestDeviceOrientationFeed.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/03/2018.
//  Copyright © 2018 organismo-mobile. All rights reserved.
//

#import "ORGRequestDeviceOrientationFeed.h"
#import "UIApplication+ORG.h"
#import "ORGMainWebSocket.h"

@implementation ORGRequestDeviceOrientationFeed

- (void)execute {
    if (self.parameters[@"enable"]) {
        [UIApplication org_setEnableOrientationFeed:YES];
        [UIApplication org_setWebSocket:self.webSocket];
    } else {
        [UIApplication org_setEnableOrientationFeed:NO];
        [UIApplication org_setWebSocket:nil];
    }
}

@end
