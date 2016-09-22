//
//  CMAltimeter+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 11/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "CMAltimeter+ORG.h"
#import "NSObject+ORG.h"
#import "ORGRemoteAltimeter.h"

@implementation CMAltimeter (ORG)

+ (void)load {
    
    if (self == [CMAltimeter class]) {
        [self ORG_swizzleMethod:@selector(startRelativeAltitudeUpdatesToQueue:withHandler:) withMethod:@selector(ORG_startRelativeAltitudeUpdatesToQueue:withHandler:)];
        [self ORG_swizzleMethod:@selector(stopRelativeAltitudeUpdates) withMethod:@selector(ORG_stopRelativeAltitudeUpdates)];
    }
}

- (void)ORG_startRelativeAltitudeUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAltitudeHandler)handler {
    [[ORGRemoteAltimeter sharedInstance] startRelativeAltitudeUpdatesToQueue:queue withHandler:handler altimeter:self];
}

- (void)ORG_stopRelativeAltitudeUpdates {
    [[ORGRemoteAltimeter sharedInstance] stopRelativeAltitudeUpdates:self];
}

@end
