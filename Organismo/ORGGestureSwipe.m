//
//  ORGGestureSwipe.m
//  Organismo
//
//  Created by Jon Gabilondo on 04/04/2017.
//  Copyright © 2017 organismo-mobile. All rights reserved.
//

#import "ORGGestureSwipe.h"
#import "NSDictionary+ORG.h"
#import <KIF.h>

@implementation ORGGestureSwipe

- (void)execute {
    
    NSDictionary * location = self.parameters[@"location"];
    NSString * direction = self.parameters[@"direaction"];
    if (location && direction) {
        KIFUITestActor * kifTestActor = [[KIFUITestActor alloc] init]; // Unorthodox usage of KIF !
        
        KIFSwipeDirection kDirection;
        if ([direction isEqualToString:@"left"]) {
            kDirection = KIFSwipeDirectionLeft;
        } else if ([direction isEqualToString:@"right"]) {
            kDirection = KIFSwipeDirectionRight;
        } else if ([direction isEqualToString:@"up"]) {
            kDirection = KIFSwipeDirectionUp;
        }else if ([direction isEqualToString:@"down"]) {
            kDirection = KIFSwipeDirectionDown;
        }
        
        [kifTestActor swipeScreenAtPoint:[location ORG_CGPoint] direction:kDirection];
    }
}

@end
