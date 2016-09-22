//
//  MKCoreLocationProvider+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 19/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "MKCoreLocationProvider+ORG.h"
#import "NSObject+ORG.h"

@implementation MKCoreLocationProvider (ORG)

+ (void)load {
    
    //    - (void)_updateUserLocationViewWithLocation:(id)arg1 hadUserLocation:(BOOL)arg2;
    
    if (self == [MKCoreLocationProvider class]) {
        [self hpSwizzleMethod:@selector(locationManager:didUpdateLocations:) withMethod:@selector(ORG_locationManager:didUpdateLocations:)];
    }
}

- (void)ORG_locationManager:(id)arg1 didUpdateLocations:(id)arg2 {
    
}

@end
