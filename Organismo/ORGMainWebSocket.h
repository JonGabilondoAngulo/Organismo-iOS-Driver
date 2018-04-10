//
//  ORGMainSocket.h


#import "ORGBaseWebSocket.h"

@class ORGOutboundMessageQueue;

@interface ORGMainWebSocket : ORGBaseWebSocket <WebSocketDelegate>

@property (nullable) ORGOutboundMessageQueue * outboundQueue;

//- (id _Nullable )initWithRequest:(HTTPMessage *_Nullable)aRequest socket:(GCDAsyncSocket *_Nullable)socket outboundQueue:(ORGOutboundMessageQueue*_Nullable)queue;

//- (void)didOpen;
//- (void)didClose;

@end
