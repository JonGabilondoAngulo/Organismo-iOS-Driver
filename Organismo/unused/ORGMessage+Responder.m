//
//  ORGMessage+Responder.m
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessage.h"
#import "ORGMessage+Responder.h"
#import "ORGMainWebSocket.h"
#import "NSDictionary+ORG.h"
#import <objc/runtime.h>

static NSString * const ORGAssociatedKey_WebSocket = @"ORGWebSocket";

@implementation ORGMessage (Responder)

- (instancetype)initWith:(NSDictionary*)message webSocket:(ORGMainWebSocket*)webSocket {
    self = [self initWith:message];
    self.webSocket = webSocket;
    return self;
}

- (void)respondSuccessWithResult:(NSDictionary*)result {
    
    if (!self.webSocket) {
        return;
    }
    
    NSDictionary * response = @{
                                @"type": @"response",
                                @"id" : [self messageId],
                                @"status":@"success",
                                @"data":result
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


#pragma mark Associative properties

- (ORGMainWebSocket*)webSocket {
    
    ORGMainWebSocket* socket = objc_getAssociatedObject(self, (__bridge const void *)(ORGAssociatedKey_WebSocket));
    return socket;
}

- (void)setWebSocket:(ORGMainWebSocket*)socket {
    objc_setAssociatedObject(self, (__bridge const void *)(ORGAssociatedKey_WebSocket), socket, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
