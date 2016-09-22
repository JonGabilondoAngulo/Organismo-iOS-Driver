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

- (WebSocket *)webSocketForURI:(NSString *)path
{
    
    WebSocket * webSocket;
	if([path isEqualToString:@"/main"]) {
        webSocket = [[ORGMainWebSocket alloc] initWithRequest:request socket:asyncSocket];
        webSocket.delegate = [ORGOutboundMessageQueue sharedInstance];
    } else {
        webSocket = [super webSocketForURI:path];
    }

    return webSocket;
}



@end
