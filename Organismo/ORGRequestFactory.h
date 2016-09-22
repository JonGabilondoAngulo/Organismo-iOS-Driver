//
//  ORGRequestFactory.h
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGMessage.h"
#import "ORGRequest.h"

@interface ORGRequestFactory : ORGMessage

+ (ORGRequest*)createRequestWith:(NSDictionary*)messageDict;

@end
