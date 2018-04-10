//
//  ORGMessage.h
//

#import <Foundation/Foundation.h>

@class ORGMainWebSocket;

@interface ORGMessage : NSObject

@property (nonatomic) NSDictionary * messageDict;
@property (nonatomic) ORGMainWebSocket * webSocket;

- (instancetype)initWith:(NSDictionary*)message andWebSocket:(ORGMainWebSocket*)webSocket;

- (NSString*)type;
- (NSString*)messageId;
- (NSString*)version;
- (NSDictionary*)data;
- (NSString*)timestamp;

- (NSString*)serialize;

@end



@interface ORGMessage (Process)

- (void)process;

@end



@interface ORGMessage (Responder)

- (void)respondSuccessWithResult:(id)result;
- (void)respondWithError:(NSInteger)errorNum description:(NSString*)description;

@end

