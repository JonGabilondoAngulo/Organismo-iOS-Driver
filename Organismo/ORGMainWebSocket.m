//
//  ORGMainWebSocket.m
//

#import "ORGMainWebSocket.h"
#import "ORGMessage.h"
#import "ORGInBoundMessageProcessor.h"
#import "ORGOutboundMessageQueue.h"

@interface ORGMainWebSocket()
@end


@implementation ORGMainWebSocket

//- (id)initWithRequest:(HTTPMessage *)aRequest socket:(GCDAsyncSocket *)socket outboundQueue:(ORGOutboundMessageQueue*)queue {
//    if ((self = [super initWithRequest:aRequest socket:socket])) {
//        _outboundQueue = queue;
//    }
//    return self;
//}

- (void)dispatchMessage:(NSDictionary *)messageDict{
    ORGMessage * message = [[ORGMessage alloc] initWith:messageDict webSocket:self];
    [[ORGInBoundMessageProcessor sharedInstance] processMessage:message];
}

//- (void)didOpen {
//    [self.outboundQueue suspend:NO];
//}
//
//- (void)didClose {
//    [self.outboundQueue suspend:YES];
//}

#pragma mark @protocol WebSocketDelegate

- (void)webSocketDidOpen:(ORGMainWebSocket *)ws {
    [self.outboundQueue suspend:NO];
}

- (void)webSocketDidClose:(WebSocket *)ws {
    [self.outboundQueue suspend:YES];
}


@end
