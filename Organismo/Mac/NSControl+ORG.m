//
//  NSControl+ORG.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 09/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "NSControl+ORG.h"

@implementation NSControl (ORG)

- (NSString*)ORG_description {
    return  [[NSString alloc] initWithFormat:@"%@ (%@)", NSStringFromClass(self.class), self.stringValue];
}

@end
