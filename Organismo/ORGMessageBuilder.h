//
//  ORGMessageBuilder.h
//  organismo
//
//  Created by Jon Gabilondo on 10/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ORGMessage;

@interface ORGMessageBuilder : NSObject

+ (ORGMessage*)buildRequest:(NSString*)request;
+ (ORGMessage*)buildRequest:(NSString*)request withParameters:(NSDictionary*)parameters;

+ (ORGMessage*)buildNotification:(NSString*)request withParameters:(NSDictionary*)parameters;

@end
