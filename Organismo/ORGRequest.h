//
//  ORGRequest.h
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessage.h"

@interface ORGRequest : ORGMessage

- (void)execute;
- (NSString*)name;
- (NSDictionary*)parameters;

@end
