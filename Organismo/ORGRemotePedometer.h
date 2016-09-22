//
//  ORGRemotePedometer.h
//  organismo
//
//  Created by Jon Gabilondo on 11/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteController.h"

@interface ORGRemotePedometer : ORGRemoteController

@property (nonatomic, weak) CMPedometer * localPedometer;

+ (instancetype)sharedInstance;

- (void)addLocalPedometer:(CMPedometer*)pedometer;

- (void)startPedometerUpdatesFromDate:(NSDate *)start withHandler:(CMPedometerHandler)handler;
- (void)stopPedometerUpdates;

@end
