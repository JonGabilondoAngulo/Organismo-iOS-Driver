//
//  CLLocationManager+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 05/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <dlfcn.h>
#import <objc/runtime.h>
#import "CLLocationManager+ORG.h"
#import "NSObject+ORG.h"
#import "ORGRemoteLocationProviderProxy.h"

#define ORG_IMPLEMENT_BYPASSING_DELEGATES 1

@interface CLLocationManager()
- (void)requestLocation;
//- (void)onClientEventLocation:(id)arg1;
//- (void)onClientEvent:(int)arg1 supportInfo:(id)arg2;
@end

#if ORG_IMPLEMENT_BYPASSING_DELEGATES
static BOOL ORG_bypass = NO;
#else
static BOOL ORG_bypass = YES;
#endif

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
        
        [self ORG_swizzleMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(ORG_dealloc)]; // @selector(dealloc) -> compile error !
    }
}

+ (void)ORG_enableBypass {
    ORG_bypass = YES;
}
+ (void)ORG_disableBypass {
    ORG_bypass = NO;
}

- (instancetype)ORG_init {
    CLLocationManager * newManager = [self ORG_init];
    [[ORGRemoteLocationProviderProxy sharedInstance] addLocalManager:newManager];
    return newManager;
}

/**
 Our lucky strike to know when the instance is disposed. We must remove the remote provider object from our list.
 */
-(void)ORG_dealloc {
    
    [[ORGRemoteLocationProviderProxy sharedInstance] removeLocalManager:self];

    // remove the manager from our list.
//    for (NSDictionary<NSString*, NSValue*> * locationManagerDict in ORG_locationManagers) {
//        
//        // We could not use the value in "object", iOS would know that the object is in process on deallocation and would throw exception.
//        // Therefore we need to use the something that will not touch the object but will tell us if its the object we want to eliminate. "pointer" does the job.
//        NSValue * locationManagerPointerValue = locationManagerDict[@"pointer"];
//        if ( self == locationManagerPointerValue.pointerValue) {
//            [ORG_locationManagers removeObject:locationManagerDict];
//            break;
//        }
//    }
    [self ORG_dealloc];
}


- (void)ORG_setDelegate:(NSObject<CLLocationManagerDelegate>*)delegate {
    
#if ORG_IMPLEMENT_BYPASSING_DELEGATES
    if ([delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)] &&
        ![delegate respondsToSelector:@selector(ORG_swizzle_locationManager:didUpdateLocations:)]) {
        
        [delegate.class ORG_swizzleMethod:@selector(locationManager:didUpdateLocations:)
                               withMethod:@selector(ORG_swizzle_locationManager:didUpdateLocations:)
                                  ofClass:self.class];
    }

    if ([delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:fromLocation:)] &&
        ![delegate respondsToSelector:@selector(ORG_swizzle_locationManager:didUpdateToLocation:fromLocation:)]) {
        [delegate.class ORG_swizzleMethod:@selector(locationManager:didUpdateToLocation:fromLocation:)
                               withMethod:@selector(ORG_swizzle_locationManager:didUpdateToLocation:fromLocation:)
                                  ofClass:self.class];
    }
#endif
    
    [self ORG_setDelegate:delegate];
}

- (CLLocation*)ORG_location {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] location];
    } else {
        return [self ORG_location];
    }
}
- (CLHeading*)ORG_heading {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] heading];
    } else {
        return [self ORG_heading];
    }
}
- (void)ORG_requestLocation {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] requestLocation];
    } else {
        return [self ORG_requestLocation];
    }
}
- (void)ORG_startUpdatingLocation {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] startUpdatingLocation];
    } else {
        return [self ORG_startUpdatingLocation];
    }
}
- (void)ORG_stopUpdatingLocation {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] stopUpdatingLocation];
    } else {
        return [self ORG_stopUpdatingLocation];
    }
}
- (void)ORG_startUpdatingHeading {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] startUpdatingHeading];
    } else {
        return [self ORG_startUpdatingHeading];
    }
}
- (void)ORG_stopUpdatingHeading {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] stopUpdatingHeading];
    } else {
        return [self ORG_stopUpdatingHeading];
    }
}
- (void)ORG_startMonitoringSignificantLocationChanges {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] startMonitoringSignificantLocationChanges];
    } else {
        return [self ORG_startMonitoringSignificantLocationChanges];
    }
}
- (void)ORG_stopMonitoringSignificantLocationChanges {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] stopMonitoringSignificantLocationChanges];
    } else {
        return [self ORG_stopMonitoringSignificantLocationChanges];
    }
}
- (void)ORG_startMonitoringForRegion:(CLRegion *)region desiredAccuracy:(CLLocationAccuracy)accuracy {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] startMonitoringForRegion:region desiredAccuracy:accuracy];
    } else {
        return [self ORG_startMonitoringForRegion:region desiredAccuracy:accuracy];
    }
}
- (void)ORG_stopMonitoringForRegion:(CLRegion *)region {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] stopMonitoringForRegion:region];
    } else {
        return [self ORG_stopMonitoringForRegion:region];
    }
}
- (void)ORG_startMonitoringForRegion:(CLRegion *)region {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] startMonitoringForRegion:region];
    } else {
        return [self ORG_startMonitoringForRegion:region];
    }
}
- (void)ORG_requestStateForRegion:(CLRegion *)region {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] requestStateForRegion:region locationManager:self];
    } else {
        return [self ORG_requestStateForRegion:region];
    }
}
- (void)ORG_startRangingBeaconsInRegion:(CLBeaconRegion *)region {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] startRangingBeaconsInRegion:region];
    } else {
        return [self ORG_startRangingBeaconsInRegion:region];
    }
}
- (void)ORG_stopRangingBeaconsInRegion:(CLBeaconRegion *)region {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] stopRangingBeaconsInRegion:region];
    } else {
        return [self ORG_stopRangingBeaconsInRegion:region];
    }
}
- (void)ORG_locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] locationManagerDidPauseLocationUpdates:manager];
    } else {
        return [self ORG_locationManagerDidPauseLocationUpdates:manager];
    }
}
- (void)ORG_locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    if (ORG_bypass) {
        return [[ORGRemoteLocationProviderProxy sharedInstance] locationManagerDidResumeLocationUpdates:manager];
    } else {
        return [self ORG_locationManagerDidResumeLocationUpdates:manager];
    }
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
*/


#pragma mark Swizzle

#if ORG_IMPLEMENT_BYPASSING_DELEGATES

- (void)ORG_swizzle_locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self ORG_swizzle_locationManager:manager didUpdateToLocation:newLocation fromLocation:oldLocation];
}

- (void)ORG_swizzle_locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if (ORG_bypass) {
        [self ORG_swizzle_locationManager:manager didUpdateLocations:@[[[ORGRemoteLocationProviderProxy sharedInstance] location]]];
    } else {
        [self ORG_swizzle_locationManager:manager didUpdateLocations:locations];
    }
}
#endif

@end
