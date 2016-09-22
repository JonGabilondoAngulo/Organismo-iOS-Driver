//
//  CMAltitudeData+ORG.h
//  Organismo
//
//  Created by Jon Gabilondo on 12/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

@interface CMAltitudeData (ORG)

+ (instancetype)ORG_createWithAltitude:(NSNumber*)altitude pressure:(NSNumber*)pressure andTimeStamp:(double)timestamp;


@end
