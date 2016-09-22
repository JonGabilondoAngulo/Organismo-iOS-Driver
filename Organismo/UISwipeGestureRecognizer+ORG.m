//
//  UISwipeGestureRecognizer+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UISwipeGestureRecognizer+ORG.h"
#import "UIGestureRecognizer+ORG.h"

@implementation UISwipeGestureRecognizer (ORG)

- (NSDictionary*)ORG_description {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"baseClass"] = @"UISwipeGestureRecognizer";
    dictionary[@"numberOfTouchesRequired"] = [NSNumber numberWithInteger:self.numberOfTouchesRequired];

    NSString * direction = @"";
    switch (self.direction) {
        case UISwipeGestureRecognizerDirectionRight: @"Right"; break;
        case UISwipeGestureRecognizerDirectionLeft: @"Left"; break;
        case UISwipeGestureRecognizerDirectionUp: @"Up"; break;
        case UISwipeGestureRecognizerDirectionDown: @"Down"; break;
        default: break;
    }
    dictionary[@"direction"] = direction;

    [dictionary addEntriesFromDictionary:[super ORG_description]];
    return dictionary;
}
@end
