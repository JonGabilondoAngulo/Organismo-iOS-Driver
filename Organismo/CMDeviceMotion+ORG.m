//
//  CMDeviceMotion+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 07/06/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "CMDeviceMotion+ORG.h"

// https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/CoreMotion.framework/CMDeviceMotion.h
// https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/CoreMotion.framework/CMDeviceMotionInternal.h

typedef struct _deviceMotionType {
    struct { double x_1_1_1; double x_1_1_2; double x_1_1_3; double x_1_1_4; } x1;
    struct { float x_2_1_1; float x_2_1_2; float x_2_1_3; } x2;
    struct { float x_3_1_1; float x_3_1_2; float x_3_1_3; } x3;
    struct { float x_4_1_1; float x_4_1_2; float x_4_1_3; } x4;
    int x5; bool x6; bool x7; bool x8; } ORGDeviceMotionInitializationData;


@interface CMDeviceMotion ()

- (id)initWithDeviceMotion:(ORGDeviceMotionInitializationData)arg1 andTimestamp:(double)arg2;

@end


@implementation CMDeviceMotion (ORG)

+ (instancetype)ORG_createWithAttitude:(NSDictionary*)attitudeDict andTimeStamp:(double)timestamp {
    
    ORGDeviceMotionInitializationData deviceMotionData = {{[attitudeDict[@"qx"] doubleValue], [attitudeDict[@"qy"] doubleValue], [attitudeDict[@"qz"] doubleValue], [attitudeDict[@"qw"] doubleValue]}};
    
    CMDeviceMotion * deviceMotion = [[CMDeviceMotion alloc] initWithDeviceMotion:deviceMotionData andTimestamp:timestamp];
//    
//    id internal = [deviceMotion valueForKey:@"_internal"];
//    [internal setValue:altitude forKey:@"fAltitude"];
//    [internal setValue:pressure forKey:@"fPressure"];
//    [deviceMotion setValue:internal forKey:@"_internal"];
    
    return deviceMotion;
}

@end
