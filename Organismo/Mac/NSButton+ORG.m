//
//  NSButton+ORG.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 09/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "NSButton+ORG.h"

@implementation NSButton (ORG)

- (NSString*)ORG_description {
    NSString *descriptor = @"";
    if (self.title.length) {
        descriptor = self.title;
    } else if (self.attributedTitle.length) {
        descriptor = self.attributedTitle.string;
    }
    return  [[NSString alloc] initWithFormat:@"%@ (%@)", NSStringFromClass(self.class), descriptor];
}

@end
