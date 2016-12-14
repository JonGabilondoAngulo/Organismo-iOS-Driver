//
//  UILabel+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 03/10/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UILabel+ORG.h"
#import "UIView+ORG.h"

@implementation UILabel (ORG)


- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [super ORG_viewProperties];
    if (self.text) {
        properties[@"text"] = self.text;
    }
    if (self.attributedText) {
        properties[@"text"] = self.attributedText.string;
    }
    if (self.font) {
        properties[@"font"] = self.font.description;
    }
    if (self.textColor) {
        properties[@"textColor"] = self.textColor.description;
    }
    if (self.enabled) {
        properties[@"enabled"] = [NSNumber numberWithBool:self.enabled];
    }
    properties[@"textAlignment"] = [NSNumber numberWithInteger:self.textAlignment];
    properties[@"lineBreakMode"] = [NSNumber numberWithInteger:self.lineBreakMode];

    // etc ..
    
    return properties;
}

@end
