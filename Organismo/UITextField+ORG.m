//
//  UITextField+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 20/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UITextField+ORG.h"
#import "UIView+ORG.h"

@implementation UITextField (ORG)

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [super ORG_viewProperties];
    properties[@"secureTextEntry"] = [NSNumber numberWithBool:self.secureTextEntry];
    
    return properties;
}

@end
