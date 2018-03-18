//
//  ORGMessage.m
//  organismo
//
//  Created by Jon Gabilondo on 26/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessage.h"
#import "ORGRequest.h"
#import "ORGRequestFactory.h"
#import "ORGMainWebSocket.h"
#import "NSDictionary+ORG.h"
#import "NSString+ORG.h"
#import "ORGMessageUpdate.h"
#import <objc/runtime.h>


@implementation ORGMessage

- (instancetype)initWith:(NSDictionary*)message andWebSocket:(ORGMainWebSocket*)webSocket {
    self = [super init];
    _messageDict = message;
    _webSocket = webSocket;
    return self;
}

- (NSString*)type {
    return _messageDict[@"type"];
}
- (NSString*)messageId {
    return _messageDict[@"id"];
}
- (NSString*)version {
    return _messageDict[@"version"];
}
- (NSString*)timestamp {
    return _messageDict[@"timestamp"];
}
- (NSString*)data {
    return _messageDict[@"data"];
}

- (NSString*)serialize {
    return [_messageDict ORG_JSONString];
}

@end



@implementation ORGMessage (Process)

- (void)process {
    
    if ([self.type ORG_isEqualToStringIgnoreCase:@"update"]) {
        ORGMessageUpdate *update = [[ORGMessageUpdate alloc] initWith:self.messageDict andWebSocket:self.webSocket];
        [update execute];
    } else if ([self.type ORG_isEqualToStringIgnoreCase:@"request"]) {
        ORGRequest * request = [ORGRequestFactory createRequestWith:self.messageDict andWebSocket:self.webSocket];
//            request.webSocket = self.webSocket;
            [request execute];
    } else {
        [self respondWithError:1000 description:@"unknown message"];
    }
}

@end


@implementation ORGMessage (Responder)

- (void)respondSuccessWithResult:(id)result {
    
    if (!self.webSocket) {
        return;
    }
    
    NSString * messageId = [self messageId];
    NSString * originalRequest = [self data][@"request"];
    
    NSDictionary * response = @{
                                @"type": @"response",
                                @"id" : (messageId ?messageId :@""),
                                @"status":@"success",
                                @"request":(originalRequest ?originalRequest :[NSNull null]),
                                @"data":(result ?result :[NSNull null])
                                };
    
    [self.webSocket sendMessage:[response ORG_JSONString]];
}


- (void)respondWithError:(NSInteger)errorNum description:(NSString*)description {
    if (!self.webSocket) {
        return;
    }
    
    NSDictionary * response = @{
                                @"type": @"response",
                                @"id" : [self messageId],
                                @"status":@"error",
                                @"error":@{
                                        @"num":[NSNumber numberWithInteger:errorNum],
                                        @"description":description
                                        }
                                };
    
    [self.webSocket sendMessage:[response ORG_JSONString]];
}



@end


