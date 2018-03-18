//
//  ORGRequestFactory.m
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestFactory.h"
#import "NSString+ORG.h"
#import "ORGMessage.h"
#import "ORGRequest.h"
#import "ORGRequestElementTree.h"
#import "ORGRequestScreenshot.h"
#import "ORGRequestDeviceInfo.h"
#import "ORGRequestSystemInfo.h"
#import "ORGRequestAppInfo.h"
#import "ORGRequestElementInfo.h"
#import "ORGRequestTap.h"
#import "ORGRequestLongPress.h"
#import "ORGRequestSwipe.h"
#import "ORGRequestClassHierarchy.h"
#import "ORGRequestDeviceOrientationFeed.h"
#import "ORGRequestCoreMotionFeed.h"

@implementation ORGRequestFactory

+ (ORGRequest*)createRequestWith:(NSDictionary*)message andWebSocket:(ORGMainWebSocket*)webSocket {

    ORGRequest * request = [[ORGRequest alloc] initWith:message andWebSocket:webSocket];
    
    NSString *requestName = [request name];
    if ([requestName ORG_isEqualToStringIgnoreCase:@"element-tree"]) {
        request = [[ORGRequestElementTree alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"screenshot"]) {
        request = [[ORGRequestScreenshot alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"system-info"]) {
        request = [[ORGRequestSystemInfo alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"device-info"]) {
        request = [[ORGRequestDeviceInfo alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"app-info"]) {
        request = [[ORGRequestAppInfo alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"element-info"]) {
        request = [[ORGRequestElementInfo alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"tap"]) {
        request = [[ORGRequestTap alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"long-press"]) {
        request = [[ORGRequestLongPress alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"swipe-left"] ||
               [requestName ORG_isEqualToStringIgnoreCase:@"swipe-right"] ||
               [requestName ORG_isEqualToStringIgnoreCase:@"swipe-up"] ||
               [requestName ORG_isEqualToStringIgnoreCase:@"swipe-down"]) {
        request = [[ORGRequestSwipe alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"class-hierarchy"]) {
        request = [[ORGRequestClassHierarchy alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"device-orientation-feed"]) {
        request = [[ORGRequestDeviceOrientationFeed alloc] initWith:message andWebSocket:webSocket];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"core-motion-feed"]) {
        request = [[ORGRequestCoreMotionFeed alloc] initWith:message andWebSocket:webSocket];
    }
    return request;
}

@end
