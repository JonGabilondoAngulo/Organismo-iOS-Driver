//
//  ORGRemoteLocationProviderProxy.h
//  organismo
//
//  Created by Jon Gabilondo on 09/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteController.h"

@class CLRegion;
@class CLBeaconRegion;

typedef NS_ENUM(NSUInteger, ORGRegionEventType) {
    kEnter,
    kExit
};

@interface ORGRemoteLocationProviderProxy : ORGRemoteController

@property(readonly, nonatomic, copy, nullable) CLLocation *location;
@property(readonly, nonatomic, copy, nullable) CLHeading *heading;

+ (instancetype _Nonnull )sharedInstance;

- (void)addLocalManager:(CLLocationManager*_Nonnull)manager;
- (void)removeLocalManager:(CLLocationManager*_Nonnull)manager;

- (void)requestLocation;
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (void)startUpdatingHeading;
- (void)stopUpdatingHeading;
- (void)startMonitoringSignificantLocationChanges;
- (void)stopMonitoringSignificantLocationChanges;
- (void)startMonitoringForRegion:(CLRegion *)region desiredAccuracy:(CLLocationAccuracy)accuracy;
- (void)stopMonitoringForRegion:(CLRegion *)region;
- (void)startMonitoringForRegion:(CLRegion *)region;
- (void)requestStateForRegion:(CLRegion *)region locationManager:(CLLocationManager*)locationManager;
- (void)startRangingBeaconsInRegion:(CLBeaconRegion *)region;
- (void)stopRangingBeaconsInRegion:(CLBeaconRegion *)region;
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager;
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager;

- (void)broadcastLocation:(CLLocation*)location;
- (void)broadcastHeading:(CLHeading*)heading;
- (void)broadcastRegion:(CLRegion*)region event:(enum ORGRegionEventType)eventEnterExit;

@end
