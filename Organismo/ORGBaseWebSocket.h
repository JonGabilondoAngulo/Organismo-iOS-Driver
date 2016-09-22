#import <Foundation/Foundation.h>
#import "WebSocket.h"
#import "HTTPLogging.h"

@interface ORGBaseWebSocket : WebSocket 

- (void)dispatchMessage:(NSDictionary *)messageDict;

@end
