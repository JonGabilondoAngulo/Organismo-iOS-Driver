//
//  ORGMessage+Process.m
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessage+Process.h"
#import "ORGMessage+Responder.h"
#import "NSString+ORG.h"
#import "ORGRequest.h"
#import "ORGRequestFactory.h"

@implementation ORGMessage (Process)

- (void)process {
    
    if ([self.type ORG_isEqualToStringIgnoreCase:@"request"]) {
        ORGRequest * request = [ORGRequestFactory createRequestWith:self.messageDict];
        request.webSocket = self.webSocket;
        [request execute];
    } else {
        [self respondWithError:1000 description:@"unknown message"];
    }
}

@end
