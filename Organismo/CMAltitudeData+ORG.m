//
//  CMAltitudeData+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 12/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "CMAltitudeData+ORG.h"
#import <objc/runtime.h>

@interface CMAltitudeData ()

- (id)initWithAltitude:(float)arg1 andTimestamp:(double)arg2 atBaseAltitude:(float)arg3; // https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/CoreMotion.framework/CMAltitudeData.h

@end


@implementation CMAltitudeData (ORG)

+ (instancetype)ORG_createWithAltitude:(NSNumber*)altitude pressure:(NSNumber*)pressure andTimeStamp:(double)timestamp {
    
    CMAltitudeData * altitudeData = [[CMAltitudeData alloc] initWithAltitude:0.f andTimestamp:timestamp atBaseAltitude:0.f];
    
    id internal = [altitudeData valueForKey:@"_internal"]; // https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/CoreMotion.framework/CMAltitudeDataInternal.h
    [internal setValue:altitude forKey:@"fAltitude"];
    [internal setValue:pressure forKey:@"fPressure"];
    [altitudeData setValue:internal forKey:@"_internal"];
    
    return altitudeData;
}

//+ (BOOL)accessInstanceVariablesDirectly {
//    return NO;
//}

@end
