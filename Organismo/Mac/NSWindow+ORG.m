//
//  NSWindow+ORG.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 09/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "NSWindow+ORG.h"

@implementation NSWindow (ORG)

- (NSString*)ORG_description {
    NSString *description = [[NSString alloc] initWithFormat:@"%@ (%@)", NSStringFromClass(self.class), self.title];
    if (!self.isVisible) {
        description = [description stringByAppendingString:@" [Hidden]"];
    }
    return description;
}

@end
