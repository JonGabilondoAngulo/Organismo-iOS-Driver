//
//  UIDatePicker+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 07/08/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIDatePicker+ORG.h"
#import "UIView+ORG.h"

@implementation UIDatePicker (ORG)

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    
    [properties addEntriesFromDictionary:[super ORG_viewProperties]];
    
    properties[@"date"] = [self.date description];
    properties[@"minimumDate"] = [self.minimumDate description];
    properties[@"maximumDate"] = [self.maximumDate description];
    properties[@"countDownDuration"] = [NSNumber numberWithDouble:self.countDownDuration];
    properties[@"minuteInterval"] = [NSNumber numberWithInteger:self.minuteInterval];
    
    return properties;
}

@end
