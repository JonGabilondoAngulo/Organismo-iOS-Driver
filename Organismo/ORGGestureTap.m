//
//  ORGGestureTap.m
//  Organismo
//
//  Created by Jon Gabilondo on 18/09/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGGestureTap.h"
#import "NSDictionary+ORG.h"
#import <KIF.h>

@implementation ORGGestureTap


- (void)execute {
#if ORG_USER_GESTURES_ENABLED
    NSDictionary * location = self.parameters[@"location"];
    if (location) {
        KIFUITestActor * kifTestActor = [[KIFUITestActor alloc] init]; // Unorthodox usage of KIF !
        [kifTestActor tapScreenAtPoint:[location ORG_CGPoint]];
    }
#endif
}


@end
