//
//  ORGRemoteMotionManager.h
//  organismo
//
//  Created by Jon Gabilondo on 08/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteController.h"

@interface ORGRemoteMotionManager : ORGRemoteController

@property (nonatomic) BOOL remoteControllerEnabled;

@property(readonly, nonatomic, getter=isAccelerometerActive) BOOL accelerometerActive;
@property(readonly, nullable) CMAccelerometerData *accelerometerData;
@property (nonatomic, weak) NSOperationQueue * accelerometerQueue;
@property (nonatomic, weak) CMAccelerometerHandler accelerometerHandler;

@property (nonatomic, nullable) CMDeviceMotion * deviceMotion;
@property (nonatomic, weak) NSOperationQueue * deviceMotionQueue;
@property (nonatomic, weak) CMDeviceMotionHandler deviceMotionHandler;
@property(nonatomic, getter=isDeviceMotionActive) BOOL deviceMotionActive;
@property (nonatomic) CMAttitudeReferenceFrame attitudeReferenceFrame;

@property (nonatomic, nullable) CMMagnetometerData * magnetometerData;
@property(readonly, nonatomic, getter=isMagnetometerActive) BOOL magnetometerActive;
@property (nonatomic, weak) NSOperationQueue * magnetometerQueue;
@property (nonatomic, weak) CMMagnetometerHandler magnetometerHandler;

@property(readonly, nullable) CMGyroData *gyroData;
@property(readonly, nonatomic, getter=isGyroActive) BOOL gyroActive;
@property (nonatomic, weak) NSOperationQueue * gyroQueue;
@property (nonatomic, weak) CMGyroHandler gyroHandler;

+ (nonnull instancetype)sharedInstance;

// accelerometer
- (void)startAccelerometerUpdates;
- (void)startAccelerometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAccelerometerHandler)handler;
- (void)stopAccelerometerUpdates;

// device motion
- (void)broadcastDeviceMotion:(nonnull CMDeviceMotion*)motion;
- (void)startDeviceMotionUpdates;
- (void)startDeviceMotionUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMDeviceMotionHandler)handler;
- (void)startDeviceMotionUpdatesUsingReferenceFrame:(CMAttitudeReferenceFrame)referenceFrame toQueue:(NSOperationQueue *)queue withHandler:(CMDeviceMotionHandler)handler;
- (void)stopDeviceMotionUpdates;

// gyro
- (void)startGyroUpdates;
- (void)startGyroUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMGyroHandler)handler;
- (void)stopGyroUpdates;

// magnetometer
- (void)startMagnetometerUpdates;
- (void)startMagnetometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMMagnetometerHandler)handler;
- (void)stopMagnetometerUpdates;


@end
