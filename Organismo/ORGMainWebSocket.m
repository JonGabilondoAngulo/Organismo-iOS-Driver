//
//  ORGMainWebSocket.m
//

#import "ORGMainWebSocket.h"
#import "ORGMessage.h"
#import "ORGInBoundMessageProcessor.h"

@implementation ORGMainWebSocket


- (void)dispatchMessage:(NSDictionary *)messageDict{
    ORGMessage * message = [[ORGMessage alloc] initWith:messageDict webSocket:self];
    [[ORGInBoundMessageProcessor sharedInstance] processMessage:message];
}


@end
