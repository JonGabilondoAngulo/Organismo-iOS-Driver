//
//  ORGRemoteMotionManager.m
//  organismo
//
//  Created by Jon Gabilondo on 08/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteMotionManager.h"
#import "ORGMessageBuilder.h"
#import "ORGMessage.h"
#import "ORGOutboundMessageQueue.h"
#import "ORGCoreMotion.h"

@implementation ORGRemoteMotionManager


+ (instancetype)sharedInstance {
    static ORGRemoteMotionManager * singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ORGRemoteMotionManager alloc] init];
    });
    return singleton;
}

// accelerometer
- (void)startAccelerometerUpdates {
    _accelerometerActive = YES;
    _accelerometerHandler = nil;
    _accelerometerQueue = nil;
    [[ORGCoreMotion sharedInstance].webSocket.outboundQueue postMessage:[ORGMessageBuilder buildRequest:@"startAccelerometerUpdates"]];
    //[[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"startAccelerometerUpdates"]];
}

- (void)startAccelerometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAccelerometerHandler)handler {
    _accelerometerActive = YES;
    _accelerometerHandler = handler;
    _accelerometerQueue = queue;
    [[ORGCoreMotion sharedInstance].webSocket.outboundQueue postMessage:[ORGMessageBuilder buildRequest:@"startAccelerometerUpdates"]];
    //[[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"startAccelerometerUpdates"]];
}

- (void)stopAccelerometerUpdates {
    _accelerometerActive = NO;
    _accelerometerHandler = nil;
    _accelerometerQueue = nil;
    [[ORGCoreMotion sharedInstance].webSocket.outboundQueue postMessage:[ORGMessageBuilder buildRequest:@"stopAccelerometerUpdates"]];
    //[[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"stopAccelerometerUpdates"]];
}


#pragma mark Device Motion
- (void)startDeviceMotionUpdates {
    _deviceMotionQueue = nil;
    _deviceMotionHandler = nil;
    _deviceMotionActive = YES;
}

- (void)startDeviceMotionUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMDeviceMotionHandler)handler {
    _deviceMotionQueue = queue;
    _deviceMotionHandler = handler;
    _deviceMotionActive = YES;
}

- (void)startDeviceMotionUpdatesUsingReferenceFrame:(CMAttitudeReferenceFrame)referenceFrame toQueue:(NSOperationQueue *)queue withHandler:(CMDeviceMotionHandler)handler {
    _deviceMotionQueue = queue;
    _deviceMotionHandler = handler;
    _attitudeReferenceFrame = referenceFrame;
    _deviceMotionActive = YES;
}

- (void)stopDeviceMotionUpdates {
    _deviceMotionQueue = nil;
    _deviceMotionHandler = nil;
    _deviceMotionActive = NO;
}

- (void)broadcastDeviceMotion:(CMDeviceMotion*)motion {
    
    if (motion && _deviceMotionQueue && _deviceMotionHandler) {
        [_deviceMotionQueue addOperationWithBlock:^{
            if (_deviceMotionHandler) {
                NSError * error;
                _deviceMotionHandler(motion, error);
            }
        }];
    }
}

#pragma mark Gyro
- (void)startGyroUpdates {
    _gyroActive = YES;
    _gyroQueue = nil;
    _gyroHandler = nil;
}

- (void)startGyroUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMGyroHandler)handler {
    _gyroActive = YES;
    _gyroQueue = queue;
    _gyroHandler = handler;
}

- (void)stopGyroUpdates {
    _gyroActive = NO;
    _gyroQueue = nil;
    _gyroHandler = nil;
}


#pragma mark Magnetometer
- (void)startMagnetometerUpdates {
    _magnetometerActive = YES;
    _magnetometerQueue = nil;
    _magnetometerHandler = nil;
}

- (void)startMagnetometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMMagnetometerHandler)handler {
    _magnetometerActive = YES;
    _magnetometerQueue = queue;
    _magnetometerHandler = nil;
}

- (void)stopMagnetometerUpdates {
    _magnetometerActive = NO;
    _magnetometerQueue = nil;
    _magnetometerHandler = nil;
}

@end
