#import "ORGBaseWebSocket.h"
#import "NSString+ORG.h"
#import <DDLog.h>

//static const int ddLogLevel = HTTP_LOG_LEVEL_ERROR | HTTP_LOG_FLAG_TRACE;


@implementation ORGBaseWebSocket



- (void)didReceiveMessage:(NSString *)msg
{
    if (msg == nil) {
        return;
    }
    
    NSError *error;
    NSDictionary *actionDict = [msg ORG_dictionary:&error];
    if (!actionDict || error) {
        DDLogError(@"%@. At:%s", error.description, __PRETTY_FUNCTION__);
        
        [self sendMessage:@"{@\"status\":@\"failure\"}"];
    } else {
        [self dispatchMessage:actionDict];
    }
}

- (void)dispatchMessage:(NSDictionary *)messageDict
{
    // subclasses override
}

@end