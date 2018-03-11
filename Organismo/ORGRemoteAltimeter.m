//
//  ORGRemoteAltimeter.m
//  organismo
//
//  Created by Jon Gabilondo on 11/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRemoteAltimeter.h"
#import "ORGOutboundMessageQueue.h"
#import "ORGMessageBuilder.h"

@interface ORGRemoteAltimeter()
@property (nonatomic) NSMapTable * altimeters; // Key is weak and is the altimeter object.
@property (nonatomic) NSLock * lock;
@end

@implementation ORGRemoteAltimeter

+ (instancetype)sharedInstance {
    static ORGRemoteAltimeter * singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[ORGRemoteAltimeter alloc] init];
        singleton.altimeters = [NSMapTable weakToStrongObjectsMapTable]; // keys weak
        singleton.lock = [[NSLock alloc] init];
    });
    return singleton;
}

- (void)startRelativeAltitudeUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAltitudeHandler)handler altimeter:(CMAltimeter*)altimeter {
    [self.webSocket.outboundQueue postMessage:[ORGMessageBuilder buildRequest:@"startRelativeAltitudeUpdatesToQueue"]];
    //[[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"startRelativeAltitudeUpdatesToQueue"]];
    [_lock lock];
    [_altimeters setObject:@[queue, handler] forKey:altimeter];
    [_lock unlock];
}

- (void)stopRelativeAltitudeUpdates:(CMAltimeter*)altimeter {
    [self.webSocket.outboundQueue postMessage:[ORGMessageBuilder buildRequest:@"stopRelativeAltitudeUpdates"]];
    //[[ORGOutboundMessageQueue sharedInstance] postMessage:[ORGMessageBuilder buildRequest:@"stopRelativeAltitudeUpdates"]];
    [_lock lock];
    [_altimeters removeObjectForKey:altimeter];
    [_lock unlock];
}

- (void)broadcast:(CMAltitudeData*)altitudeData {
    [_lock lock];
    NSEnumerator *enumerator = [_altimeters keyEnumerator];
    CMAltimeter * key;
    
    while ((key = [enumerator nextObject])) {
        NSArray * tuple = [_altimeters objectForKey:key];
        if (tuple.count) {
            NSOperationQueue * queue = tuple[0];
            [queue addOperationWithBlock:^{
                CMAltitudeHandler handler = tuple[1];
                if (handler) {
                    handler(altitudeData, nil);
                }
            }];
        }
    }
    [_lock unlock];
}

@end
