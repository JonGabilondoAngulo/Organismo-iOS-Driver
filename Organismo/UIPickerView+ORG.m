//
//  UIPickerView+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 07/08/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIPickerView+ORG.h"
#import "UIView+ORG.h"

@implementation UIPickerView (ORG)


- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    
    [properties addEntriesFromDictionary:[super ORG_viewProperties]];
    
    properties[@"showsSelectionIndicator"] = [NSNumber numberWithBool:self.showsSelectionIndicator];
    properties[@"numberOfComponents"] = [NSNumber numberWithInteger:self.numberOfComponents];
    
    return properties;
}
@end
