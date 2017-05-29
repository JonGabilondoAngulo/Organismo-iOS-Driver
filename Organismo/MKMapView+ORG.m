//
//  MKMapView+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 17/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "MKMapView+ORG.h"
#import "NSObject+ORG.h"
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>

@interface FORCELOAD_MKMapView : NSObject
@end
@implementation FORCELOAD_MKMapView
@end

@interface MKMapView()
- (void)_updateUserLocation:(id)arg1 routeMatch:(id)arg2;
@end

@interface MKCoreLocationProvider : NSObject
- (void)ORG_locationManager:(id)arg1 didUpdateLocations:(id)arg2;
@end

@interface CLSimulationManager : NSObject
- (void)appendSimulatedLocation:(id)arg1;
@end


@implementation MKMapView (ORG)

+ (void)load {
    
//    - (void)_updateUserLocationViewWithLocation:(id)arg1 hadUserLocation:(BOOL)arg2;

    // iOS 9 has this method
//    if (self == [MKMapView class]) {
//        [self hpSwizzleMethod:@selector(_updateUserLocation:routeMatch:) withMethod:@selector(org_updateUserLocation:routeMatch:)];
//    }
    
    // iOS8
    // https://github.com/MP0w/iOS-Headers/blob/master/iOS8.0/Frameworks/MapKit/MKCoreLocationProvider.h
    Class MKCoreLocationProviderClass = NSClassFromString(@"MKCoreLocationProvider");
    if (MKCoreLocationProviderClass) {
        
        SEL origSelector = @selector(locationManager:didUpdateLocations:);
        SEL newSelector = @selector(ORG_locationManager:didUpdateLocations:);
        
        Method origMethod = class_getInstanceMethod(MKCoreLocationProviderClass, origSelector);
        Method newMethod = class_getInstanceMethod(self, newSelector);
        
        if (class_addMethod(MKCoreLocationProviderClass, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) {
            class_replaceMethod(MKCoreLocationProviderClass, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        }
    }
/*
    // https://github.com/MP0w/iOS-Headers/blob/master/iOS8.0/Frameworks/CoreLocation/CLSimulationManager.h
    Class CLSimulationManagerClass = NSClassFromString(@"CLSimulationManager");
    if (CLSimulationManagerClass) {
        
        SEL origSelector = @selector(appendSimulatedLocation:);
        SEL newSelector = @selector(ORG_appendSimulatedLocation:);
        
        Method origMethod = class_getInstanceMethod(CLSimulationManagerClass, origSelector);
        Method newMethod = class_getInstanceMethod(self, newSelector);
        
//        if (class_addMethod(CLSimulationManagerClass, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) {
//            class_replaceMethod(CLSimulationManagerClass, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
//        }
    }*/
    
    // others
    // https://github.com/MP0w/iOS-Headers/blob/master/iOS8.0/Frameworks/MapKit/MKLocationManager.h
    // https://github.com/MP0w/iOS-Headers/blob/master/iOS8.0/Frameworks/MapKit/MKLocationManagerSingleUpdater.h
}

//- (void)org_updateUserLocation:(id)arg1 routeMatch:(id)arg2 {
//    
//    [self org_updateUserLocation:arg1 routeMatch:arg2];
//}

// https://github.com/ichitaso/iOS-iphoneheaders/blob/master/iOS8.3/System/Library/Frameworks/CoreLocation.framework/CoreLocation-Structs.h

typedef struct {
    double latitude;
    double longitude;
} SCD_Struct_CL1;

typedef struct {
    int suitability;
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

- (void)ORG_locationManager:(id)arg1 didUpdateLocations:(id)arg2 {
/*
    CLLocationDegrees step = 0.05;
    static CLLocationDegrees lng = 34;
    NSLog(@"LOC:%@", arg2[0]);
    / *
    (lldb) po arg1
    <CLLocationManager: 0x170216fb0>
    
    (lldb) po arg2
    <__NSArrayM 0x170441140>(
                             <+32.06158228,+34.76877071> +/- 10.00m (speed 0.00 mps / course -1.00) @ 3/19/16, 20:56:25 Israel Standard Time
                             )
     * /
    lng += step;
    //CLLocation * newLoc = [[CLLocation alloc] initWithLatitude:32 longitude:lng];
    CLLocationCoordinate2D c2d = {32.0,34.0};
    CLLocation * newLoc = [[CLLocation alloc] initWithCoordinate:c2d altitude:100.0 horizontalAccuracy:10.0 verticalAccuracy:10.0 course:0.0 speed:0.0 timestamp:[NSDate date]];
    
    id internal = [arg2[0] valueForKey:@"_internal"];
    NSValue * internalSt = [internal valueForKey:@"fLocation"];
    SCD_Struct_CL2 st2;
    [internalSt getValue:&st2];
    
    //NSLog(@"%@",internalSt);
    //SCD_Struct_CL2 x = (SCD_Struct_CL2)internalSt;
    
    [newLoc setValue:internal forKey:@"_internal"];

    //[self ORG_locationManager:arg1 didUpdateLocations:@[newLoc]];
    */
    [self ORG_locationManager:arg1 didUpdateLocations:arg2];
}

- (void)ORG_appendSimulatedLocation:(id)arg1 {
    
}


@end
