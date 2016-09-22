//
//  CMPedometer+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 11/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "CMPedometer+ORG.h"
#import "NSObject+ORG.h"
#import "ORGRemotePedometer.h"

@implementation CMPedometer (ORG)

+ (void)load {
    
    if (self == [CMPedometer class]) {
        
        [self ORG_swizzleMethod:@selector(init) withMethod:@selector(ORG_init)];
        [self ORG_swizzleMethod:@selector(startPedometerUpdatesFromDate:withHandler:) withMethod:@selector(ORG_startPedometerUpdatesFromDate:withHandler:)];
        [self ORG_swizzleMethod:@selector(stopPedometerUpdates) withMethod:@selector(ORG_stopPedometerUpdates)];
    }
}

- (instancetype)ORG_init {
    
    CMPedometer * pedometer = [self ORG_init];
    [[ORGRemotePedometer sharedInstance] addLocalPedometer:pedometer];
    return pedometer;
}

- (void)ORG_startPedometerUpdatesFromDate:(NSDate *)start withHandler:(CMPedometerHandler)handler {
    [[ORGRemotePedometer sharedInstance] startPedometerUpdatesFromDate:start withHandler:handler];
}

- (void)ORG_stopPedometerUpdates {
    [[ORGRemotePedometer sharedInstance] stopPedometerUpdates];
}

@end
