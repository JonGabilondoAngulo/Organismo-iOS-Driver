//
//  ORGRemoteAltimeter.h
//  organismo
//
//  Created by Jon Gabilondo on 11/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteController.h"

@class ORGMainWebSocket;


@interface ORGRemoteAltimeter : ORGRemoteController

@property (nonatomic) ORGMainWebSocket * webSocket;

+ (instancetype)sharedInstance;

- (void)startRelativeAltitudeUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAltitudeHandler)handler altimeter:(CMAltimeter*)altimeter;
- (void)stopRelativeAltitudeUpdates:(CMAltimeter*)altimeter;
- (void)broadcast:(CMAltitudeData*)altitudeData;

@end
