//
//  UITextView+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 20/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UITextView+ORG.h"
#import "UIView+ORG.h"

@implementation UITextView (ORG)

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [super ORG_viewProperties];
    properties[@"editable"] = [NSNumber numberWithBool:self.editable];
    
    return properties;
}

- (BOOL)ORG_ignoreGestureRecognizers {
    BOOL result = [super ORG_ignoreGestureRecognizers] || self.isEditable==NO;
    return result;
}
@end
