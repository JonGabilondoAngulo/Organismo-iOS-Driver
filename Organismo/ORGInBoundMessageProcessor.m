//
//  ORGInBoundMessageProcessor.m
//  organismo
//
//  Created by Jon Gabilondo on 05/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGInBoundMessageProcessor.h"
#import "ORGMessage.h"

@interface ORGInBoundMessageProcessor ()
@property (nonatomic) NSOperationQueue * queue;
@end

@implementation ORGInBoundMessageProcessor

+ (instancetype)sharedInstance {
    static ORGInBoundMessageProcessor * singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ORGInBoundMessageProcessor alloc] init];
        singleton.queue = [[NSOperationQueue alloc] init];
        [singleton.queue setMaxConcurrentOperationCount:1];
    });
    return singleton;
}


- (void)processMessage:(ORGMessage*)message {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:message
                                                                            selector:@selector(process)
                                                                              object:nil];
    [self.queue addOperation:operation];
}

@end
