//
//  UIPinchGestureRecognizer+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIPinchGestureRecognizer+ORG.h"
#import "UIGestureRecognizer+ORG.h"

@implementation UIPinchGestureRecognizer (ORG)

- (NSDictionary*)ORG_description {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"baseClass"] = @"UIPinchGestureRecognizer";
    dictionary[@"scale"] = [NSNumber numberWithFloat:self.scale];
    dictionary[@"velocity"] = [NSNumber numberWithFloat:self.velocity];
    
    [dictionary addEntriesFromDictionary:[super ORG_description]];
    return dictionary;
}

@end
