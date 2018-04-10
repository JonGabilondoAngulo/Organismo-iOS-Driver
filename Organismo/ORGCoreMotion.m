//
//  ORGCoreMotion.m
//  HpRecorderForIOS
//
//  Created by Jon Gabilondo on 7/8/15.
//  Copyright (c) 2015 HP Software. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "ORGCoreMotion.h"

@interface ORGCoreMotion()
@property (strong, nonatomic) CMMotionManager *motionManager;
@end


@interface CMAttitude(ORG)
- (NSDictionary*)orgConvertToDictionary;
@end

@implementation CMAttitude(ORG)

- (NSDictionary*)orgConvertToDictionary {
    return @{
             @"q":@{@"x":[NSNumber numberWithDouble:self.quaternion.x],
                    @"y":[NSNumber numberWithDouble:self.quaternion.y],
                    @"z":[NSNumber numberWithDouble:self.quaternion.z],
                    @"w":[NSNumber numberWithDouble:self.quaternion.w]},
             @"rm":@{@"m11":[NSNumber numberWithDouble:self.rotationMatrix.m11],
                     @"m12":[NSNumber numberWithDouble:self.rotationMatrix.m12],
                     @"m13":[NSNumber numberWithDouble:self.rotationMatrix.m13],
                     @"m21":[NSNumber numberWithDouble:self.rotationMatrix.m21],
                     @"m22":[NSNumber numberWithDouble:self.rotationMatrix.m22],
                     @"m23":[NSNumber numberWithDouble:self.rotationMatrix.m23],
                     @"m31":[NSNumber numberWithDouble:self.rotationMatrix.m31],
                     @"m32":[NSNumber numberWithDouble:self.rotationMatrix.m32],
                     @"m33":[NSNumber numberWithDouble:self.rotationMatrix.m33]},
             @"roll":[NSNumber numberWithDouble:self.roll],
             @"pitch":[NSNumber numberWithDouble:self.pitch],
             @"yaw":[NSNumber numberWithDouble:self.yaw]
             };
}

@end


@implementation ORGCoreMotion

+ (instancetype)sharedInstance
{
    static ORGCoreMotion * singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ORGCoreMotion alloc] init];
        singleton.motionManager = [[CMMotionManager alloc] init];
    });
    return singleton;
}

#define ORG_ROUND_DOUBLE(a) round (a * 100.0) / 100.0

- (void)startFeed {
    
    NSTimeInterval updateInterval = 0.2;
    
    if ([self.motionManager isDeviceMotionAvailable] == YES) {
        [self.motionManager setDeviceMotionUpdateInterval:updateInterval];
        
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical
                                                                toQueue:[NSOperationQueue mainQueue]
                                                            withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        //[self.motionmanager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            
            static CMAttitude * lastAttitude;
            BOOL attitudeChanged = YES;
            
            if (lastAttitude) {
                attitudeChanged = (
                                   (ORG_ROUND_DOUBLE(deviceMotion.attitude.roll) != ORG_ROUND_DOUBLE(lastAttitude.roll)) ||
                                   (ORG_ROUND_DOUBLE(deviceMotion.attitude.pitch) != ORG_ROUND_DOUBLE(lastAttitude.pitch)) ||
                                   (ORG_ROUND_DOUBLE(deviceMotion.attitude.yaw) != ORG_ROUND_DOUBLE(lastAttitude.yaw))
                                   );
            }
            
            if (attitudeChanged) {
                NSDictionary * attitudeDict = [deviceMotion.attitude orgConvertToDictionary];
                if (attitudeDict) {
                    // send it to listener
                    
                    NSDictionary * feedData = @{@"command":@"core-motion-feed", @"content":@{@"attitude":attitudeDict}};
                    
                    // send via socket
//                    NSError *error;
//                    NSString *jsonString = [AAMSocketMessageHelper stringFromDictionary:feedData withError:&error];
//                    if (error==nil && jsonString.length) {
//                        [[AAMCommunicationHub sharedInstance] sendStringUsingSocket:jsonString];
//                    }
                }
            }
            lastAttitude = deviceMotion.attitude;
            
        }];
    }
}

- (void)stopFeed {
    [self.motionManager stopDeviceMotionUpdates];
}

- (void)virtualFeedUpdate:(NSDictionary*)updateInfo {
    
}


@end
