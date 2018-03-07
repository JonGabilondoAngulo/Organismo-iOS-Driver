//
//  ORGOutboundMessageQueue.m
//  organismo
//
//  Created by Jon Gabilondo on 09/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGOutboundMessageQueue.h"
#import "ORGMessage.h"

@interface ORGOutboundMessageQueue ()
@property (nonatomic) NSOperationQueue * queue;
@property (nonatomic) ORGMainWebSocket * webSocket;
- (void)send:(ORGMessage*)message;
- (void)suspend:(BOOL)value;
@end

@implementation ORGOutboundMessageQueue

+ (instancetype)sharedInstance {
    static ORGOutboundMessageQueue * singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ORGOutboundMessageQueue alloc] init];
        singleton.queue = [[NSOperationQueue alloc] init];
        [singleton.queue setMaxConcurrentOperationCount:1];
        singleton.queue.suspended = YES;
    });
    return singleton;
}

- (void)postMessage:(ORGMessage*)message {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(send:)
                                                                              object:message];
    [self.queue addOperation:operation];
}


#pragma mark Private

- (void)send:(ORGMessage*)message {
    NSString * messageStr = [message serialize];
    [_webSocket sendMessage:messageStr];
}
- (void)suspend:(BOOL)value {
    _queue.suspended = value;
}

#pragma mark @protocol WebSocketDelegate

- (void)webSocketDidOpen:(WebSocket *)ws {
    _webSocket = ws;
    [self suspend:NO];
}
- (void)webSocketDidClose:(WebSocket *)ws {
    _webSocket = nil;
    [self suspend:YES];
}

@end
