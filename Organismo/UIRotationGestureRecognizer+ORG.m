//
//  UIRotationGestureRecognizer+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIRotationGestureRecognizer+ORG.h"
#import "UIGestureRecognizer+ORG.h"

@implementation UIRotationGestureRecognizer (ORG)

- (NSDictionary*)ORG_description {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"baseClass"] = @"UIRotationGestureRecognizer";
    dictionary[@"rotation"] = [NSNumber numberWithFloat:self.rotation];
    dictionary[@"velocity"] = [NSNumber numberWithFloat:self.velocity];
    
    [dictionary addEntriesFromDictionary:[super ORG_description]];
    return dictionary;
}
@end
