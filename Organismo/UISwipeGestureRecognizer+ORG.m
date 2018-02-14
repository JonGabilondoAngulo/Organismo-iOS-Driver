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
        case UISwipeGestureRecognizerDirectionRight: direction = @"Right"; break;
        case UISwipeGestureRecognizerDirectionLeft: direction = @"Left"; break;
        case UISwipeGestureRecognizerDirectionUp: direction = @"Up"; break;
        case UISwipeGestureRecognizerDirectionDown: direction = @"Down"; break;
        default: break;
    }
    dictionary[@"direction"] = direction;

    [dictionary addEntriesFromDictionary:[super ORG_description]];
    return dictionary;
}
@end
