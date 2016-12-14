//
//  UIButton+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 07/08/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIButton+ORG.h"
#import "UIView+ORG.h"

@implementation UIButton (ORG)

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    
    [properties addEntriesFromDictionary:[super ORG_viewProperties]];
    
    if (self.currentTitle) {
        properties[@"currentTitle"] = self.currentTitle;
    }
    if (self.currentAttributedTitle) {
        properties[@"currentAttributedTitle"] = self.currentAttributedTitle;
    }
    if (self.currentTitleColor) {
        properties[@"currentTitleColor"] = self.currentTitleColor.description;
    }
    if (self.currentTitleShadowColor) {
        properties[@"currentTitleShadowColor"] = self.currentTitleShadowColor.description;
    }
    properties[@"currentImage"] = (self.currentImage ? @YES :@NO);
    properties[@"currentBackgroundImage"] = (self.currentBackgroundImage ? @YES :@NO);

    return properties;
}
@end
