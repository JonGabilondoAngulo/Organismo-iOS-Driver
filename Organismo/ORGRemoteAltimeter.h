//
//  ORGRemoteAltimeter.h
//  organismo
//
//  Created by Jon Gabilondo on 11/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteController.h"

@interface ORGRemoteAltimeter : ORGRemoteController

+ (instancetype)sharedInstance;

- (void)startRelativeAltitudeUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAltitudeHandler)handler altimeter:(CMAltimeter*)altimeter;
- (void)stopRelativeAltitudeUpdates:(CMAltimeter*)altimeter;

- (void)broadcast:(CMAltitudeData*)altitudeData;

@end
