//
//  ORGRemotePedometer.m
//  organismo
//
//  Created by Jon Gabilondo on 11/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemotePedometer.h"

@implementation ORGRemotePedometer

+ (instancetype)sharedInstance
{
    static ORGRemotePedometer * singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ORGRemotePedometer alloc] init];
    });
    return singleton;
}

- (void)addLocalPedometer:(CMPedometer*)pedometer {
    _localPedometer = pedometer;
}

- (void)startPedometerUpdatesFromDate:(NSDate *)start withHandler:(CMPedometerHandler)handler {
    
}
- (void)stopPedometerUpdates {
    
}

@end
