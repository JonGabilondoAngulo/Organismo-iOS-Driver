//
//  UITableViewCell+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 27/03/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "UITableViewCell+ORG.h"
#import "UIView+ORG.h"

@implementation UITableViewCell (ORG)

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [super ORG_viewProperties];

    UITableView *table = [self ORG_superviewWithClass:[UITableView class]];
    if (table.delegate) {
        if ([table.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            properties[@"selectable"] = @"YES";
        }
        if (@available(iOS 11, *)) {
            if ([table.delegate respondsToSelector:@selector(tableView:leadingSwipeActionsConfigurationForRowAtIndexPath:)]) {
                properties[@"leadingSwipe"] = @"ON";
            }
            if ([table.delegate respondsToSelector:@selector(tableView:trailingSwipeActionsConfigurationForRowAtIndexPath:)]) {
                properties[@"trailingSwipe"] = @"ON";
            }
        }
    }

    return properties;
}

@end
