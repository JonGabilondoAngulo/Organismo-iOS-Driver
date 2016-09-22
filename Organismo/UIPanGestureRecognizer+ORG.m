//
//  UIPanPressGestureRecognizer+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIPanGestureRecognizer+ORG.h"
#import "UIGestureRecognizer+ORG.h"

@implementation UIPanGestureRecognizer (ORG)

- (NSDictionary*)ORG_description {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"baseClass"] = @"UIPanGestureRecognizer";
    dictionary[@"maximumNumberOfTouches"] = [NSNumber numberWithUnsignedInteger:self.maximumNumberOfTouches];
    dictionary[@"minimumNumberOfTouches"] = [NSNumber numberWithUnsignedInteger:self.minimumNumberOfTouches];
    
    [dictionary addEntriesFromDictionary:[super ORG_description]];
    return dictionary;
}

@end
