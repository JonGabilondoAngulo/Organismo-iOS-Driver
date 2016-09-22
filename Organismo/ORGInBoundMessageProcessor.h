//
//  ORGInBoundMessageProcessor.h
//  organismo
//
//  Created by Jon Gabilondo on 05/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ORGMessage;

@interface ORGInBoundMessageProcessor : NSObject

+ (instancetype)sharedInstance;
- (void)processMessage:(ORGMessage*)message;

@end
