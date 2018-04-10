//
//  ORGOutboundMessageQueue.h
//  organismo
//
//  Created by Jon Gabilondo on 09/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORGMainWebSocket.h"

@class ORGMessage;

@interface ORGOutboundMessageQueue : NSObject 

//+ (instancetype)sharedInstance;

- (instancetype)initWithWebSocket:(ORGMainWebSocket *)webSocket;
- (void)postMessage:(ORGMessage*)message;
- (void)suspend:(BOOL)value;

@end
