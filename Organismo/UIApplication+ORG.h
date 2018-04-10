//
//  UIApplication+ORG.h
//  organismo
//
//  Created by Jon Gabilondo on 25/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ORGMainWebSocket;

@interface UIApplication (ORG)

//@property (nonatomic) BOOL org_enableOrientationFeed;
//@property (nonatomic) ORGMainWebSocket * org_webSocket;

+ (BOOL)org_enableOrientationFeed;
+ (void)org_setEnableOrientationFeed:(BOOL)enable;

+ (ORGMainWebSocket*)org_webSocket;
+ (void)org_setWebSocket:(ORGMainWebSocket*)webSocket;

@end
