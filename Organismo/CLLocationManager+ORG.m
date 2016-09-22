//
//  CLLocationManager+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 05/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <dlfcn.h>
#import "CLLocationManager+ORG.h"
#import "NSObject+ORG.h"
#import "ORGRemoteLocationManager.h"

@interface CLLocationManager()
- (void)requestLocation;
//- (void)onClientEventLocation:(id)arg1;
//- (void)onClientEvent:(int)arg1 supportInfo:(id)arg2;
@end

@implementation CLLocationManager (ORG)

+ (void)load {
    
    // https://github.com/JaviSoto/iOS9-Runtime-Headers/blob/master/Frameworks/CoreLocation.framework/CLLocationManager.h
    if (self == [CLLocationManager class]) {
        [self ORG_swizzleMethod:@selector(init) withMethod:@selector(ORG_init)];
        [self ORG_swizzleMethod:@selector(setDelegate:) withMethod:@selector(ORG_setDelegate:)];
        [self ORG_swizzleMethod:@selector(location) withMethod:@selector(ORG_location)];
        [self ORG_swizzleMethod:@selector(heading) withMethod:@selector(ORG_heading)];
        [self ORG_swizzleMethod:@selector(requestLocation) withMethod:@selector(ORG_requestLocation)];
        
        [self ORG_swizzleMethod:@selector(startUpdatingLocation) withMethod:@selector(ORG_startUpdatingLocation)];
        [self ORG_swizzleMethod:@selector(stopUpdatingLocation) withMethod:@selector(ORG_stopUpdatingLocation)];
        [self ORG_swizzleMethod:@selector(startUpdatingHeading) withMethod:@selector(ORG_startUpdatingHeading)];
        [self ORG_swizzleMethod:@selector(stopUpdatingHeading) withMethod:@selector(ORG_stopUpdatingHeading)];
        [self ORG_swizzleMethod:@selector(startMonitoringSignificantLocationChanges) withMethod:@selector(ORG_startMonitoringSignificantLocationChanges)];
        [self ORG_swizzleMethod:@selector(stopMonitoringSignificantLocationChanges) withMethod:@selector(ORG_stopMonitoringSignificantLocationChanges)];
        [self ORG_swizzleMethod:@selector(startMonitoringForRegion:desiredAccuracy:) withMethod:@selector(ORG_startMonitoringForRegion:desiredAccuracy:)];
        [self ORG_swizzleMethod:@selector(stopMonitoringForRegion:) withMethod:@selector(ORG_stopMonitoringForRegion:)];
        [self ORG_swizzleMethod:@selector(startMonitoringForRegion:) withMethod:@selector(ORG_startMonitoringForRegion:)];
        [self ORG_swizzleMethod:@selector(requestStateForRegion:) withMethod:@selector(ORG_requestStateForRegion:)];
        [self ORG_swizzleMethod:@selector(startRangingBeaconsInRegion:) withMethod:@selector(ORG_startRangingBeaconsInRegion:)];
        [self ORG_swizzleMethod:@selector(stopRangingBeaconsInRegion:) withMethod:@selector(ORG_stopRangingBeaconsInRegion:)];
        
        [self ORG_swizzleMethod:@selector(locationManagerDidPauseLocationUpdates:) withMethod:@selector(ORG_locationManagerDidPauseLocationUpdates:)];
        [self ORG_swizzleMethod:@selector(locationManagerDidResumeLocationUpdates:) withMethod:@selector(ORG_locationManagerDidResumeLocationUpdates:)];
//      [self ORG_swizzleMethod:@selector(onClientEvent:supportInfo:) withMethod:@selector(ORG_onClientEvent:supportInfo:)];
//      [self ORG_swizzleMethod:@selector(onClientEventLocation:) withMethod:@selector(ORG_onClientEventLocation:)];
    }
}

- (instancetype)ORG_init {
    
    CLLocationManager * newManager = [self ORG_init];
    [[ORGRemoteLocationManager sharedInstance] addLocalManager:newManager];
    return newManager;
}

- (void)ORG_setDelegate:(NSObject<CLLocationManagerDelegate>*)delegate {
    [self ORG_setDelegate:delegate];
}

- (CLLocation*)ORG_location {
    return [[ORGRemoteLocationManager sharedInstance] location];
}
- (CLHeading*)ORG_heading {
    return [[ORGRemoteLocationManager sharedInstance] heading];
}
- (void)ORG_requestLocation {
    [[ORGRemoteLocationManager sharedInstance] requestLocation];
}
- (void)ORG_startUpdatingLocation {
    [[ORGRemoteLocationManager sharedInstance] startUpdatingLocation];
    //[self ORG_startUpdatingLocation];
}
- (void)ORG_stopUpdatingLocation {
    [[ORGRemoteLocationManager sharedInstance] stopUpdatingLocation];
    //[self ORG_stopUpdatingLocation];
}
- (void)ORG_startUpdatingHeading {
    [[ORGRemoteLocationManager sharedInstance] startUpdatingHeading];
}
- (void)ORG_stopUpdatingHeading {
    [[ORGRemoteLocationManager sharedInstance] stopUpdatingHeading];
}
- (void)ORG_startMonitoringSignificantLocationChanges {
    [[ORGRemoteLocationManager sharedInstance] startMonitoringSignificantLocationChanges];
}
- (void)ORG_stopMonitoringSignificantLocationChanges {
    [[ORGRemoteLocationManager sharedInstance] stopMonitoringSignificantLocationChanges];
}
- (void)ORG_startMonitoringForRegion:(CLRegion *)region desiredAccuracy:(CLLocationAccuracy)accuracy {
    [[ORGRemoteLocationManager sharedInstance] startMonitoringForRegion:region desiredAccuracy:accuracy];
}
- (void)ORG_stopMonitoringForRegion:(CLRegion *)region {
    [[ORGRemoteLocationManager sharedInstance] stopMonitoringForRegion:region];
}
- (void)ORG_startMonitoringForRegion:(CLRegion *)region {
    [[ORGRemoteLocationManager sharedInstance] startMonitoringForRegion:region];
}
- (void)ORG_requestStateForRegion:(CLRegion *)region {
    [[ORGRemoteLocationManager sharedInstance] requestStateForRegion:region locationManager:self];
}
- (void)ORG_startRangingBeaconsInRegion:(CLBeaconRegion *)region {
    [[ORGRemoteLocationManager sharedInstance] startRangingBeaconsInRegion:region];
}
- (void)ORG_stopRangingBeaconsInRegion:(CLBeaconRegion *)region {
    [[ORGRemoteLocationManager sharedInstance] stopRangingBeaconsInRegion:region];
}
- (void)ORG_locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    [[ORGRemoteLocationManager sharedInstance] locationManagerDidPauseLocationUpdates:manager];
}
- (void)ORG_locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    [[ORGRemoteLocationManager sharedInstance] locationManagerDidResumeLocationUpdates:manager];
}

/*
- (void)ORG_onClientEvent:(int)arg1 supportInfo:(id)arg2 {
    
    typedef struct {
        double latitude;
        double longitude;
    } SCD_Struct_CL1;
    
    typedef struct {
        int suitability;
        int pad1;
        SCD_Struct_CL1 coordinate;
        double horizontalAccuracy;
        double altitude;
        double verticalAccuracy;
        double speed;
        double speedAccuracy;
        double course;
        double courseAccuracy;
        double timestamp;
        int confidence;
        double lifespan;
        int type;
        SCD_Struct_CL1 rawCoordinate;
        double rawCourse;
        int floor;
        unsigned integrity;
    } SCD_Struct_CL2;
 
    if (arg1==0) {
        //NSData * data = arg2[@"Locations"];
        //NSLog(@"DATA:%@", data);
    } else {
        [self ORG_onClientEvent:arg1 supportInfo:arg2];
    }
}
- (void)ORG_onClientEventLocation:(id)arg1 {
    [self ORG_onClientEventLocation:arg1];
}
- (void)ORG_requestLocation {
    [self ORG_requestLocation];
}

+ (void)ORG_broadcastLocation:(CLLocation*)location {

    CLLocationCoordinate2D c2d = {32.0,34.8};
    CLLocation * newLoc = [[CLLocation alloc] initWithCoordinate:c2d altitude:100.0 horizontalAccuracy:10.0 verticalAccuracy:10.0 course:0.0 speed:0.0 timestamp:[NSDate date]];

    for (NSValue * locationManagerValue in ORG_locationManagers) {
        __weak CLLocationManager * locationManager = [locationManagerValue nonretainedObjectValue];
        if (locationManager.delegate) {
            [self ORG_broadcastLocation:newLoc toDelegate:locationManager.delegate];
        }
    }
//    if (m1.delegate) {
//        [self ORG_broadcastLocation:newLoc toDelegate:m1.delegate];
//    }
//    if (m2.delegate) {
//        [self ORG_broadcastLocation:newLoc toDelegate:m2.delegate];
//    }
    
    NSDictionary * d = @{
                         @"kCLClientEventKey":@"kCLConnectionMessageLocation",
                         @"ForceMapMatching":@0,
                         @"LocationCount":@1,
                         @"IsFitnessMatch":@1,
                         @"Location":[NSData dataWithBytes:"123" length:3]
                         };

    if (m1.delegate) {
        //if ([m1.delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
            
//            <ffff0000 12e86eb3 a2034040 ecfce78c d3724140 00000000 00405040 000000a0 e6454440 00000000 00002440 00000000 0000f0bf 00000000 0000f0bf 00000000 0000f0bf 00000000 0000f0bf 09c6498f 1ab5bc41 42000000 000050b8 1e8b7b40 04000000 12e86eb3 a2034040 ecfce78c d3724140 00000000 0000f0bf ffffff7f 19000000>
            
            [m1 ORG_onClientEvent:0 supportInfo:d];
        //}
    }
    if (m2.delegate) {
        [m2 ORG_onClientEvent:0 supportInfo:d];
    }
}

+ (void)ORG_broadcastLocation:(CLLocation*)location toDelegate:(id)delegate {
    
    if (delegate && location) {
        if ([delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
            [delegate performSelector:@selector(locationManager:didUpdateLocations:) withObject:@[location]];
        }
    }
}
*/


@end
