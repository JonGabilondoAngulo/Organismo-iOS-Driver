//
//  ORGMessage+Responder.h
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessage.h"

@class ORGMainWebSocket;


@interface ORGMessage (Responder)

@property (nonatomic) ORGMainWebSocket * webSocket;

- (instancetype)initWith:(NSDictionary*)message webSocket:(ORGMainWebSocket*)webSocket;
- (void)respondSuccessWithResult:(NSDictionary*)result;
- (void)respondWithError:(NSInteger)errorNum description:(NSString*)description;

@end
