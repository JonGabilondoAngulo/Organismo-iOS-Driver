//
//  ORGRemoteLocationManager.m
//  organismo
//
//  Created by Jon Gabilondo on 09/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteLocationManager.h"
#import "ORGOutboundMessageQueue.h"
#import "ORGMessageBuilder.h"
#import "CLBeaconRegion+ORG.h"

@interface ORGRemoteLocationManager()
@property (nonatomic) NSMutableArray *locationManagers;
@property (nonatomic) CLLocation *location;
@property (nonatomic) NSMapTable * regions; // Key is weak and is a CLRegion object. The value is a Boolean = YES if region contains location.

- (void)broadcastLocation:(CLLocation*)location toLocationManager:(CLLocationManager*)manager;
- (void)broadcastHeading:(CLHeading *)heading toLocationManager:(CLLocationManager*)manager;
- (void)broadcastEnterRegion:(CLRegion*)region toLocationManager:(CLLocationManager*)manager;
- (void)broadcastExitRegion:(CLRegion*)region toLocationManager:(CLLocationManager*)manager;
@end

@implementation ORGRemoteLocationManager

+ (instancetype)sharedInstance
{
    static ORGRemoteLocationManager * singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ORGRemoteLocationManager alloc] init];
        singleton.locationManagers = [NSMutableArray array];
        singleton.regions = [NSMapTable weakToStrongObjectsMapTable];
    });
    return singleton;
}

- (void)addLocalManager:(CLLocationManager*)manager {
    [_locationManagers addObject:[NSValue valueWithNonretainedObject:manager]];
}

- (void)requestLocation {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"requestLocation"]];
}
- (void)startUpdatingLocation {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"startUpdatingLocation"]];
}
- (void)stopUpdatingLocation {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"stopUpdatingLocation"]];
}
- (void)startUpdatingHeading {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"startUpdatingHeading"]];
}
- (void)stopUpdatingHeading {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"stopUpdatingHeading"]];
}
- (void)startMonitoringSignificantLocationChanges {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"startMonitoringSignificantLocationChanges"]];
}
- (void)stopMonitoringSignificantLocationChanges {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"stopMonitoringSignificantLocationChanges"]];
}
- (void)startMonitoringForRegion:(CLRegion *)region desiredAccuracy:(CLLocationAccuracy)accuracy {
    [_regions setObject:@NO forKey:region];
}
- (void)stopMonitoringForRegion:(CLRegion *)region {
    [_regions removeObjectForKey:region];
}
- (void)startMonitoringForRegion:(CLRegion *)region {
    [_regions setObject:@NO forKey:region];
}

- (void)requestStateForRegion:(CLRegion *)region locationManager:(CLLocationManager*)locationManager {
    
    NSNumber * inside = [_regions objectForKey:region];
    CLRegionState regionState = inside.boolValue ?CLRegionStateInside :CLRegionStateOutside;
    
    if (locationManager.delegate) {
        if ([locationManager.delegate respondsToSelector:@selector(locationManager:didDetermineState:forRegion:)]) {
            [locationManager.delegate locationManager:locationManager didDetermineState:regionState forRegion:region];
        }
    }
}
- (void)startRangingBeaconsInRegion:(CLBeaconRegion *)region {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"startRangingBeaconsInRegion" withParameters:[region ORG_parameters]]];
}
- (void)stopRangingBeaconsInRegion:(CLBeaconRegion *)region {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"stopRangingBeaconsInRegion" withParameters:[region ORG_parameters]]];
}
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager;{
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"pauseLocationUpdates"]];
}
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    [[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"resumeLocationUpdates"]];
}


#pragma mark Broadcast

- (void)broadcastLocation:(CLLocation*)location {
    
    // Broadcast the new location
    for (NSValue * locationManagerValue in _locationManagers) {
        __weak CLLocationManager * locationManager = [locationManagerValue nonretainedObjectValue];
        if (locationManager.delegate) {
            [self broadcastLocation:location toLocationManager:locationManager];
        }
    }
    
    // Broadcast changes in regions
    for (CLCircularRegion * region in _regions) {
        
        NSNumber * inside = [_regions objectForKey:region];
        if ([inside boolValue]) {
            if (![region containsCoordinate:location.coordinate]) {
                [self broadcastRegion:region event:kExit];
                [_regions setObject:@NO forKey:region];
            }
            
        } else {
            if ([region containsCoordinate:location.coordinate]) {
                [self broadcastRegion:region event:kEnter];
                [_regions setObject:@YES forKey:region];
            }
        }
    }
}

- (void)broadcastHeading:(CLHeading*)heading {
    
    /*
     ATTENTION WE HAVE TO CONSIDER THIS !
     headingFilter
     Property
     The minimum angular change (measured in degrees) required to generate new heading events.
     */
    for (NSValue * locationManagerValue in _locationManagers) {
        __weak CLLocationManager * locationManager = [locationManagerValue nonretainedObjectValue];
        if (locationManager.delegate) {
            [self broadcastHeading:heading toLocationManager:locationManager];
        }
    }
}

- (void)broadcastRegion:(CLRegion*)region event:(enum ORGRegionEventType)regionEventType {
    
    for (NSValue * locationManagerValue in _locationManagers) {
        __weak CLLocationManager * locationManager = [locationManagerValue nonretainedObjectValue];
        if (locationManager.delegate) {
            switch (regionEventType) {
                case kEnter:
                    [self broadcastEnterRegion:region toLocationManager:locationManager];
                    break;
                case kExit:
                    [self broadcastExitRegion:region toLocationManager:locationManager];
                    break;
                default:
                    break;
            }
        }
    }
}


#pragma mark Private

- (void)broadcastEnterRegion:(CLRegion*)region toLocationManager:(CLLocationManager*)manager {
    
    if (manager.delegate && region) {
        if ([manager.delegate respondsToSelector:@selector(locationManager:didEnterRegion:)]) {
            [manager.delegate locationManager:manager didEnterRegion:region];
        }
    }
}

- (void)broadcastExitRegion:(CLRegion*)region toLocationManager:(CLLocationManager*)manager {
    
    if (manager.delegate && region) {
        if ([manager.delegate respondsToSelector:@selector(locationManager:didExitRegion:)]) {
            [manager.delegate locationManager:manager didExitRegion:region];
        }
    }
}

- (void)broadcastLocation:(CLLocation*)location toLocationManager:(CLLocationManager*)manager {
    
    if (manager.delegate && location) {
        if ([manager.delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
            [manager.delegate locationManager:manager didUpdateLocations:@[location]];
        } else if ([manager.delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:fromLocation:)]) {
            [manager.delegate locationManager:manager didUpdateToLocation:location fromLocation:nil];
        }
    }
}

- (void)broadcastHeading:(CLHeading*)heading toLocationManager:(CLLocationManager*)manager {
    
    if (manager.delegate && heading) {
        if ([manager.delegate respondsToSelector:@selector(locationManager:didUpdateHeading:)]) {
            [manager.delegate locationManager:manager didUpdateHeading:heading];
        }
    }
}


@end
