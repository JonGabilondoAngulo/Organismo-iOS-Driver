//
//  UILongPressGestureRecognizer+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIGestureRecognizer+ORG.h"
#import "UILongPressGestureRecognizer+ORG.h"

@implementation UILongPressGestureRecognizer (ORG)

- (NSDictionary*)ORG_description {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"baseClass"] = @"UILongPressGestureRecognizer";
    dictionary[@"minimumPressDuration"] = [NSNumber numberWithDouble:self.minimumPressDuration];
    dictionary[@"numberOfTapsRequired"] = [NSNumber numberWithUnsignedInteger:self.numberOfTapsRequired];
    dictionary[@"numberOfTouchesRequired"] = [NSNumber numberWithUnsignedInteger:self.numberOfTouchesRequired];
    
    // allowableMovement is sometimes infinite and crashes on serialization
    //NSNumber * numberAllowableMovement = [NSNumber numberWithFloat:self.allowableMovement];
    //if (self.allowableMovement < INFINITY) {
    //    dictionary[@"allowableMovement"] = [NSNumber numberWithFloat:self.allowableMovement];
    //}
    
    [dictionary addEntriesFromDictionary:[super ORG_description]];
    return dictionary;
}

@end
