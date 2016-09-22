//
//  UITapGestureRecognizer+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIGestureRecognizer+ORG.h"
#import "UITapGestureRecognizer+ORG.h"

@implementation UITapGestureRecognizer (ORG)

- (NSDictionary*)ORG_description {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"baseClass"] = @"UITapGestureRecognizer";
    dictionary[@"numberOfTapsRequired"] = [NSNumber numberWithUnsignedInteger:self.numberOfTapsRequired];
    dictionary[@"numberOfTouchesRequired"] = [NSNumber numberWithUnsignedInteger:self.numberOfTouchesRequired];
    
    [dictionary addEntriesFromDictionary:[super ORG_description]];
    return dictionary;
}

@end
