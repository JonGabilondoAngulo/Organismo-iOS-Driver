//
//  CMDeviceMotion+ORG.h
//  Organismo
//
//  Created by Jon Gabilondo on 07/06/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

@interface CMDeviceMotion (ORG)

+ (instancetype)ORG_createWithAttitude:(NSDictionary*)attitudeDict andTimeStamp:(double)timestamp;

@end
