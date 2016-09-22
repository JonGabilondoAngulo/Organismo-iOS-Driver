//
//  UIGestureRecognizer+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIGestureRecognizer+ORG.h"

@implementation UIGestureRecognizer (ORG)

- (NSDictionary*)ORG_description {
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    
    dictionary[@"class"] = NSStringFromClass(self.class);
    dictionary[@"enabled"] = [NSNumber numberWithBool:self.enabled];
    dictionary[@"hasDelegate"] = (self.delegate ?@YES :@NO);
    if (self.delegate) {
        dictionary[@"delegateClass"] = NSStringFromClass(self.delegate.class);
    }
    
    return dictionary;
}

- (BOOL)ORG_mustBeIgnored {
 
    NSString * gestureClassName = NSStringFromClass(self.class);
    if ([gestureClassName hasPrefix:@"_"]) {
        return YES;
    }
    
    if (!self.delegate) {
        return YES;
    }

    NSString * delegateClassName = NSStringFromClass(self.delegate.class);
    if ([delegateClassName hasPrefix:@"_"]) {
        return YES;
    }
    
    // ignore textview system gestures UITextInteractionAssistant
    if ([gestureClassName isEqualToString:@"UIScrollViewDelayedTouchesBeganGestureRecognizer"]) {
        return YES;
    }
    if ([delegateClassName isEqualToString:@"UITextInteractionAssistant"]) {
        return YES;
    }
    
    return NO;
}


@end
