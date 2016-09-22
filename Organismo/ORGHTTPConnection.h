#import <Foundation/Foundation.h>
#import "HTTPConnection.h"

@class ORGBaseWebSocket;

@interface ORGHTTPConnection : HTTPConnection
{
	ORGBaseWebSocket *ws;
}

@end
