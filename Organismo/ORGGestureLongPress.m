//
//  ORGGestureLongPress.m
//  Organismo
//
//  Created by Jon Gabilondo on 04/04/2017.
//  Copyright © 2017 organismo-mobile. All rights reserved.
//

#import "ORGGestureLongPress.h"
#import "NSDictionary+ORG.h"
#import <KIF.h>

@implementation ORGGestureLongPress

- (void)execute {
#if ORG_USER_GESTURES_ENABLED
    NSDictionary * location = self.parameters[@"location"];
    NSNumber * durationNumber = self.parameters[@"duration"];
    if (location) {
        NSTimeInterval duration = (duration ?durationNumber.doubleValue :0.5);
        KIFUITestActor * kifTestActor = [[KIFUITestActor alloc] init]; // Unorthodox usage of KIF !
        [kifTestActor longPressScreenAtPoint:[location ORG_CGPoint] duration:duration];
    }
#endif
}

@end
