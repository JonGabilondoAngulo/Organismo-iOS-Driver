//
//  CMMotionManager+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 08/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "CMMotionManager+ORG.h"
#import "NSObject+ORG.h"
#import "ORGRemoteMotionManager.h"

// https://github.com/MP0w/iOS-Headers/blob/master/iOS8.1/Frameworks/CoreMotion/CMMotionManager.h

@implementation CMMotionManager (ORG)

+ (void)load {
    
    if (self == [CMMotionManager class]) {
        
        // accelerometer
        [self ORG_swizzleMethod:@selector(accelerometerData) withMethod:@selector(ORG_accelerometerData)];
        [self ORG_swizzleMethod:@selector(startAccelerometerUpdates) withMethod:@selector(ORG_startAccelerometerUpdates)];
        [self ORG_swizzleMethod:@selector(startAccelerometerUpdatesToQueue:withHandler:) withMethod:@selector(ORG_startAccelerometerUpdatesToQueue: withHandler:)];
        [self ORG_swizzleMethod:@selector(stopAccelerometerUpdates) withMethod:@selector(ORG_stopAccelerometerUpdates)];

        // gyro
        [self ORG_swizzleMethod:@selector(gyroData) withMethod:@selector(ORG_gyroData)];
        [self ORG_swizzleMethod:@selector(startGyroUpdates) withMethod:@selector(ORG_startGyroUpdates)];
        [self ORG_swizzleMethod:@selector(startGyroUpdatesToQueue:withHandler:) withMethod:@selector(ORG_startGyroUpdatesToQueue: withHandler:)];
        [self ORG_swizzleMethod:@selector(stopGyroUpdates) withMethod:@selector(ORG_stopGyroUpdates)];

        // device motion
        [self ORG_swizzleMethod:@selector(deviceMotion) withMethod:@selector(ORG_deviceMotion)];
        [self ORG_swizzleMethod:@selector(startDeviceMotionUpdates) withMethod:@selector(ORG_startDeviceMotionUpdates)];
        [self ORG_swizzleMethod:@selector(startDeviceMotionUpdatesToQueue:withHandler:) withMethod:@selector(ORG_startDeviceMotionUpdatesToQueue:withHandler:)];
        [self ORG_swizzleMethod:@selector(startDeviceMotionUpdatesUsingReferenceFrame:toQueue:withHandler:) withMethod:@selector(ORG_startDeviceMotionUpdatesToQueue:withHandler:)];
        [self ORG_swizzleMethod:@selector(stopDeviceMotionUpdates) withMethod:@selector(ORG_stopDeviceMotionUpdates)];
        
        // magnetometer
        [self ORG_swizzleMethod:@selector(magnetometerData) withMethod:@selector(ORG_magnetometerData)];
        [self ORG_swizzleMethod:@selector(startMagnetometerUpdates) withMethod:@selector(ORG_startMagnetometerUpdates)];
        [self ORG_swizzleMethod:@selector(startMagnetometerUpdatesToQueue:withHandler:) withMethod:@selector(ORG_startMagnetometerUpdatesToQueue: withHandler:)];
        [self ORG_swizzleMethod:@selector(stopMagnetometerUpdates) withMethod:@selector(ORG_stopMagnetometerUpdates)];
    }
}

#pragma mark Accelerometer
- (CMAccelerometerData *)ORG_accelerometerData {
    return [ORGRemoteMotionManager sharedInstance].accelerometerData;
}

- (void)ORG_startAccelerometerUpdates {
    [[ORGRemoteMotionManager sharedInstance] startAccelerometerUpdates];
}

- (void)ORG_stopAccelerometerUpdates {
    [[ORGRemoteMotionManager sharedInstance] stopAccelerometerUpdates];
}

- (void)ORG_startAccelerometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAccelerometerHandler)handler {
    [[ORGRemoteMotionManager sharedInstance] startAccelerometerUpdatesToQueue:queue withHandler:handler];
}

#pragma mark Gyro
- (CMGyroData *)ORG_gyroData {
    return [ORGRemoteMotionManager sharedInstance].gyroData;
}

- (void)ORG_startGyroUpdates {
    [[ORGRemoteMotionManager sharedInstance] startGyroUpdates];
}

- (void)ORG_stopGyroUpdates {
    [[ORGRemoteMotionManager sharedInstance] stopGyroUpdates];
}

- (void)ORG_startGyroUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMGyroHandler)handler {
    [[ORGRemoteMotionManager sharedInstance] startGyroUpdatesToQueue:queue withHandler:handler];
}

#pragma mark Device Motion

- (CMDeviceMotion *)ORG_deviceMotion {

    // return our CMDeviceMotion, it has the latest update
    return [ORGRemoteMotionManager sharedInstance].deviceMotion;

//    if (YES) {
//        return [ORGRemoteMotionManager sharedInstance].deviceMotion;
//    } else {
//        return [self ORG_deviceMotion];
//    }
}

- (void)ORG_startDeviceMotionUpdates {
    [[ORGRemoteMotionManager sharedInstance] startDeviceMotionUpdates];
}

- (void)ORG_startDeviceMotionUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMDeviceMotionHandler)handler {
    [[ORGRemoteMotionManager sharedInstance] startDeviceMotionUpdatesToQueue:queue withHandler:handler];
}

- (void)ORG_startDeviceMotionUpdatesUsingReferenceFrame:(CMAttitudeReferenceFrame)referenceFrame toQueue:(NSOperationQueue *)queue withHandler:(CMDeviceMotionHandler)handler {
    [[ORGRemoteMotionManager sharedInstance] startDeviceMotionUpdatesUsingReferenceFrame:referenceFrame toQueue:queue withHandler:handler];
}

- (void)ORG_stopDeviceMotionUpdates {
    [[ORGRemoteMotionManager sharedInstance] stopDeviceMotionUpdates];
}

#pragma mark Magnotometer

- (CMMagnetometerData *)ORG_magnetometerData {
    return [ORGRemoteMotionManager sharedInstance].magnetometerData;
}

- (void)ORG_startMagnetometerUpdates {
    [[ORGRemoteMotionManager sharedInstance] startMagnetometerUpdates];
}

- (void)ORG_stopMagnetometerUpdates {
    [[ORGRemoteMotionManager sharedInstance] stopMagnetometerUpdates];
}

- (void)ORG_startMagnetometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMMagnetometerHandler)handler {
    [[ORGRemoteMotionManager sharedInstance] startMagnetometerUpdatesToQueue:queue withHandler:handler];
}


@end
