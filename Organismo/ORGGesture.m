//
//  ORGGesture.m
//  Organismo
//
//  Created by Jon Gabilondo on 18/09/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGGesture.h"

@implementation ORGGesture

- (instancetype)initWithParameters:(NSDictionary*)parameters {
    
    if (self = [super init]) {
        _parameters = parameters;
    }
    return self;
}

- (void)execute {
    NSLog(@"Execute called in base class. Should not happen.");
}

@end
