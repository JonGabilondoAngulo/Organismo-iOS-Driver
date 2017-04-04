//
//  ORGRequestFactory.m
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestFactory.h"
#import "NSString+ORG.h"
#import "ORGRequest.h"
#import "ORGRequestElementTree.h"
#import "ORGRequestScreenshot.h"
#import "ORGRequestDeviceInfo.h"
#import "ORGRequestAppInfo.h"
#import "ORGRequestElementInfo.h"
#import "ORGRequestTap.h"
#import "ORGRequestLongPress.h"
#import "ORGRequestSwipe.h"

@implementation ORGRequestFactory

+ (ORGRequest*)createRequestWith:(NSDictionary*)message {

    ORGRequest * request = [[ORGRequest alloc] initWith:message];
    
    NSString *requestName = [request name];
    if ([requestName ORG_isEqualToStringIgnoreCase:@"element-tree"]) {
        request = [[ORGRequestElementTree alloc] initWith:message];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"screenshot"]) {
        request = [[ORGRequestScreenshot alloc] initWith:message];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"device-info"]) {
        request = [[ORGRequestDeviceInfo alloc] initWith:message];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"app-info"]) {
        request = [[ORGRequestAppInfo alloc] initWith:message];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"element-info"]) {
        request = [[ORGRequestElementInfo alloc] initWith:message];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"tap"]) {
        request = [[ORGRequestTap alloc] initWith:message];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"long-press"]) {
        request = [[ORGRequestLongPress alloc] initWith:message];
    } else if ([requestName ORG_isEqualToStringIgnoreCase:@"swipe-left"] || [requestName ORG_isEqualToStringIgnoreCase:@"swipe-right"] || [requestName ORG_isEqualToStringIgnoreCase:@"swipe-up"] || [requestName ORG_isEqualToStringIgnoreCase:@"swipe-down"]) {
        request = [[ORGRequestSwipe alloc] initWith:message];
    }
    return request;
}

@end
