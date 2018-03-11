#import "ORGHTTPConnection.h"
#import "HTTPMessage.h"
#import "HTTPResponse.h"
#import "HTTPDynamicFileResponse.h"
#import "GCDAsyncSocket.h"
#import "ORGBaseWebSocket.h"
#import "ORGMainWebSocket.h"
#import "HTTPDataResponse.h"
#import "ORGOutboundMessageQueue.h"

@implementation ORGHTTPConnection

- (WebSocket *)webSocketForURI:(NSString *)path {
    ORGMainWebSocket * webSocket;
	if ([path isEqualToString:@"/main"] || [path isEqualToString:@"/second"] || [path isEqualToString:@"/third"]) {
        webSocket = [[ORGMainWebSocket alloc] initWithRequest:request socket:asyncSocket];
        webSocket.outboundQueue = [[ORGOutboundMessageQueue alloc] initWithWebSocket:webSocket];
        webSocket.delegate = webSocket;
    } else {
        webSocket = (ORGMainWebSocket*)[super webSocketForURI:path];
    }

    return (WebSocket *)webSocket;
}



@end
