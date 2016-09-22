//
//  ORGMessageBuilder.m
//  organismo
//
//  Created by Jon Gabilondo on 10/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessageBuilder.h"
#import "ORGMessage.h"

@implementation ORGMessageBuilder

+ (ORGMessage*)buildRequest:(NSString*)request {
    return [[ORGMessage alloc] initWith:@{
                                          @"type" : @"request",
                                          @"body": @{
                                                  @"request":request
                                                  }
                                           
                                          }];
}

+ (ORGMessage*)buildRequest:(NSString*)request withParameters:(NSDictionary*)parameters {
    return [[ORGMessage alloc] initWith:@{
                                          @"type" : @"request",
                                          @"body": @{
                                                  @"request":request,
                                                  @"parameters":parameters
                                                  }
                                          
                                          }];
}


+ (ORGMessage*)buildNotification:(NSString*)request withParameters:(NSDictionary*)parameters {
    return [[ORGMessage alloc] initWith:@{
                                          @"type" : @"notification",
                                          @"body": @{
                                                  @"notification":request,
                                                  @"parameters":parameters
                                                  }
                                          
                                          }];
}

@end
