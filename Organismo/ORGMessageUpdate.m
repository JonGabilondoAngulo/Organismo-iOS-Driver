//
//  ORGUpdate.m
//  organismo
//
//  Created by Jon Gabilondo on 05/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessageUpdate.h"
#import "ORGRemoteAltimeter.h"
#import "ORGRemoteLocationManager.h"
#import "ORGRemoteMotionManager.h"
#import "CMAltitudeData+ORG.h"
#import "CLLocationManager+ORG.h"
#import "NSString+ORG.h"
#import "CLHeading+ORG.h"
#import "NSDate+ORG.h"
#import "CMDeviceMotion+ORG.h"

@interface ORGMessageUpdate()
- (NSDictionary*)location;
- (NSDictionary*)heading;
- (NSDictionary*)altimeter;
- (NSDictionary*)startDate;
- (NSDictionary*)deviceAttitude;
- (NSArray*)regionEvents;
- (void)processLocationUpdate:(NSDictionary*)location;
- (void)processHeadingUpdate:(NSDictionary*)location;
- (void)processAltimeterUpdate:(NSDictionary*)altimeter;
- (void)processStartDate:(NSDictionary*)startDate;
- (void)processDeviceMotion:(NSDictionary*)deviceMotion;
- (void)processRegionUpdates:(NSArray*)regionEvents;
@end

@implementation ORGMessageUpdate

- (void)execute {
    
    dispatch_sync( dispatch_get_main_queue(), ^{
        [self processLocationUpdate:[self location]];
        [self processHeadingUpdate:[self heading]];
        [self processAltimeterUpdate:[self altimeter]];
        [self processRegionUpdates:[self regionEvents]];
        [self processStartDate:[self startDate]];
        [self processDeviceMotion:[self deviceAttitude]];
    });
}

#pragma mark Private

- (NSDictionary*)startDate {
    return [self data][@"startDate"];
}

- (NSDictionary*)location {
    return [self data][@"location"];
}

- (NSDictionary*)heading {
    return [self data][@"heading"];
}

- (NSDictionary*)deviceAttitude {
    return [self data][@"deviceAttitude"];
}

- (NSDictionary*)altimeter {
    return [self data][@"altimeter"];
}

- (NSArray*)regionEvents {
    return [self data][@"regionEvents"];
}

- (void)processRegionUpdates:(NSArray*)regionEvents {
    
    if (!regionEvents) {
        return;
    }
    
    for (NSDictionary * regionEvent in regionEvents) {
        
        ORGRegionEventType regionEventType;
        if ([regionEvent[@"type"] ORG_isEqualToStringIgnoreCase:@"enter"]) {
            regionEventType = kEnter;
        } else {
            regionEventType = kExit;
        }
        
        NSNumber * lat = regionEvent[@"lat"];
        NSNumber * lng = regionEvent[@"lng"];
        NSNumber * radius = regionEvent[@"radius"];
        NSString * identifier = regionEvent[@"identifier"];
        CLLocationCoordinate2D loc = {lat.floatValue, lng.floatValue};
        CLRegion * region = [[CLRegion alloc] initCircularRegionWithCenter:loc radius:radius.floatValue identifier:identifier];

        [[ORGRemoteLocationManager sharedInstance] broadcastRegion:region event:regionEventType]; // broadcast to local listeners
    }
}

- (void)processLocationUpdate:(NSDictionary*)location {

    if (!location) {
        return;
    }

    NSNumber * lat = location[@"lat"];
    NSNumber * lng = location[@"lng"];
    NSNumber * altitude = location[@"altitude"];
    NSNumber * course = location[@"course"];
    NSNumber * speed = location[@"speed"];
    
    CLLocationCoordinate2D loc = {lat.floatValue, lng.floatValue};
    CLLocation *newLocation = [[CLLocation alloc] initWithCoordinate:loc altitude:altitude.floatValue horizontalAccuracy:10.0 verticalAccuracy:10.0 course:course.floatValue speed:speed.floatValue timestamp:[NSDate date]];
    
    [[ORGRemoteLocationManager sharedInstance] broadcastLocation:newLocation]; // broadcast to local listeners
}

- (void)processHeadingUpdate:(NSDictionary*)heading {
    
    if (!heading) {
        return;
    }
    
    NSNumber * magneticHeading = heading[@"magneticHeading"];
    NSNumber * trueHeading = heading[@"trueHeading"];
//    NSNumber * componentX = location[@"x"];
//    NSNumber * componentY = location[@"y"];
//    NSNumber * omponentZ = location[@"z"];
    
    CLHeading *newHeading = [CLHeading ORG_createWithHeading:trueHeading accuracy:@1.0];
    [[ORGRemoteLocationManager sharedInstance] broadcastHeading:newHeading]; // broadcast to local listeners
}


- (void)processAltimeterUpdate:(NSDictionary*)altimeter {
    
    if (!altimeter) {
        return;
    }
    
    NSNumber * altitude = altimeter[@"altitude"];
    NSNumber * pressure = altimeter[@"pressure"];
    NSNumber * timestampNumber = altimeter[@"timestamp"];
    double timestamp;
    if (timestampNumber) {
        timestamp = [timestampNumber doubleValue];
    } else {
        timestamp = [[NSDate date] timeIntervalSince1970];
    }
    
    CMAltitudeData * altitudeData = [CMAltitudeData ORG_createWithAltitude:altitude pressure:pressure andTimeStamp:timestamp];
    
    [[ORGRemoteAltimeter sharedInstance] broadcast:altitudeData]; // broadcast to local listeners
}

- (void)processStartDate:(NSDictionary*)startDateDict {
    
    if (!startDateDict) {
        return;
    }
    
    [NSDate ORG_setDateOffset:0]; // very important to reset

    NSDate * systemDate = [NSDate date];
    NSCalendar * currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:systemDate];

    NSString * yearStr = startDateDict[@"year"];
    NSString * monthStr = startDateDict[@"month"];
    NSString * dayStr = startDateDict[@"day"];
    NSString * hourStr = startDateDict[@"hour"];
    NSString * minuteStr = startDateDict[@"minute"];
    NSString * secondStr = startDateDict[@"second"];
    
    NSDateComponents * startDateComponents = [[NSDateComponents alloc] init];
    startDateComponents.calendar = currentCalendar;
    startDateComponents.timeZone = currentCalendar.timeZone;
    startDateComponents.year = (yearStr ?[yearStr integerValue] :[components year]);
    startDateComponents.month = (monthStr ?[monthStr integerValue] :[components month]);
    startDateComponents.day = (dayStr ?[dayStr integerValue] :[components day]);
    startDateComponents.hour = (hourStr ?[hourStr integerValue] :[components hour]);
    startDateComponents.minute = (minuteStr ?[minuteStr integerValue] :[components hour]);
    startDateComponents.second = (secondStr ?[secondStr integerValue] :[components hour]);
    
    NSDate * startDate = [currentCalendar dateFromComponents:startDateComponents]; 
    
    [NSDate ORG_setDateOffset:[startDate timeIntervalSinceDate:systemDate]];
}

- (void)processDeviceMotion:(NSDictionary*)attitude {
    
    if (!attitude) {
        return;
    }

//    attitude[@"qx"];
//    attitude[@"qy"];
//    attitude[@"qz"];
//    attitude[@"qw"];
    
    // Create a propper CMDeviceMotion object
    CMDeviceMotion * deviceMotion = [CMDeviceMotion ORG_createWithAttitude:attitude andTimeStamp:[[NSDate date] timeIntervalSince1970]];
    
    // broadcast to local listeners
    [[ORGRemoteMotionManager sharedInstance] broadcastDeviceMotion:deviceMotion];
    
    // keep it in our proxy for those direct calls to self.motionManager.deviceMotion that a programmer can do any time
    [ORGRemoteMotionManager sharedInstance].deviceMotion = deviceMotion;
}


@end
