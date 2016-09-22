//
//  UISegmentedControl+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 07/08/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UISegmentedControl+ORG.h"
#import "UIView+ORG.h"

@implementation UISegmentedControl (ORG)

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    
    [properties addEntriesFromDictionary:[super ORG_viewProperties]];
    
    properties[@"momentary"] = [NSNumber numberWithBool:self.momentary];
    properties[@"numberOfSegments"] = [NSNumber numberWithUnsignedInteger:self.numberOfSegments];
    properties[@"selectedSegmentIndex"] = [NSNumber numberWithInteger:self.selectedSegmentIndex];
    
    // TODO: Add items info
    
    return properties;
}

@end
