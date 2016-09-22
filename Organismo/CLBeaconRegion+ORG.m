//
//  CLBeaconRegion+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 23/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "CLBeaconRegion+ORG.h"

@implementation CLBeaconRegion (ORG)

- (NSDictionary*)ORG_parameters {
    return @{
             @"proximityUUID" : self.proximityUUID,
             @"minor" : self.minor,
             @"major" : self.major
              };
}

@end
