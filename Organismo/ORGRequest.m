
//
//  ORGRequest.m
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequest.h"
#import "ORGMessage.h"

@implementation ORGRequest


- (NSString*)name {
    return self.messageDict[@"data"][@"request"];
}

- (void)execute {
    // override
}

- (NSDictionary*)parameters {
    return self.messageDict[@"data"][@"parameters"];    
}


@end
