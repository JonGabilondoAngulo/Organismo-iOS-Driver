//
//  CMAttitude+ORG.m
//  HpRecorderForIOS
//
//  Created by Jon Gabilondo on 7/22/15.
//  Copyright (c) 2015 HP Software. All rights reserved.
//

#import "CMAttitude+ORG.h"
#import "NSObject+ORG.h"
#import "ORGCoreMotion.h"

@implementation CMAttitude (ORG)

//+ (void)load {
//    
//    if (self == [CMAttitude class]) {
//        [self ORG_swizzleMethod:@selector(quaternion) withMethod:@selector(ORG_quaternion)];
//    }
//}
//
//- (CMQuaternion)ORG_quaternion {
//    
//    NSNumber * x = [ORGCoreMotion sharedInstance].externalFeedData[@"content"][@"q"][@"x"];
//    NSNumber * y = [ORGCoreMotion sharedInstance].externalFeedData[@"content"][@"q"][@"y"];
//    NSNumber * z = [ORGCoreMotion sharedInstance].externalFeedData[@"content"][@"q"][@"z"];
//    NSNumber * w = [ORGCoreMotion sharedInstance].externalFeedData[@"content"][@"q"][@"w"];
//    
//    CMQuaternion q = { x.doubleValue, y.doubleValue, z.doubleValue, w.doubleValue};
//    return q;
//}

@end
