//
//  CLHeading+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 13/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "CLHeading+ORG.h"

typedef struct {
    double x;
    double y;
    double z;
    double magneticHeading;
    double trueHeading;
    double accuracy;
    double timestamp;
    double temperature;
    double magnitude;
    double inclination;
    int calibration;
} ORGHeadingStruct;


@interface CLHeading()

// https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/CoreLocation.framework/CLHeading.h
// https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/CoreLocation.framework/CLHeadingInternal.h

- (id)initWithClientHeading:(ORGHeadingStruct)arg1;
- (CLHeading*)initWithHeading:(double)arg1 accuracy:(double)arg2;

@end

@implementation CLHeading (ORG)

+ (instancetype)ORG_createWithHeading:(NSNumber*)headingValue accuracy:(NSNumber*)accuracy {
    
    //CLHeading * heading = [[CLHeading alloc] initWithHeading:headingValue.floatValue accuracy:accuracy.floatValue];
    ORGHeadingStruct values = {
        0.0,0.0,0.0,headingValue.doubleValue,headingValue.doubleValue, 1.0, [[NSDate date] timeIntervalSinceNow], 30.0, 0.0, 0.0, 0.0
    };
    CLHeading * heading = [[CLHeading alloc] initWithClientHeading:values];
    return heading;
}

@end
