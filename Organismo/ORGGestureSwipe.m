//
//  ORGGestureSwipe.m
//  Organismo
//
//  Created by Jon Gabilondo on 04/04/2017.
//  Copyright © 2017 organismo-mobile. All rights reserved.
//

#import "ORGGestureSwipe.h"
#import "NSDictionary+ORG.h"

@implementation ORGGestureSwipe

- (void)execute {
#if ORG_USER_GESTURES_ENABLED
    NSDictionary * location = self.parameters[@"location"];
    NSString * direction = self.parameters[@"direction"];
    if (location && direction) {
        KIFUITestActor * kifTestActor = [[KIFUITestActor alloc] init]; // Unorthodox usage of KIF !
        
        KIFSwipeDirection kDirection = KIFSwipeDirectionRight;
        if ([direction isEqualToString:@"left"]) {
            kDirection = KIFSwipeDirectionLeft;
        } else if ([direction isEqualToString:@"right"]) {
            kDirection = KIFSwipeDirectionRight;
        } else if ([direction isEqualToString:@"up"]) {
            kDirection = KIFSwipeDirectionUp;
        } else if ([direction isEqualToString:@"down"]) {
            kDirection = KIFSwipeDirectionDown;
        }
        
        //[kifTestActor swipeScreenAtPoint:[location ORG_CGPoint] direction:kDirection];
    }
#endif
}

@end
