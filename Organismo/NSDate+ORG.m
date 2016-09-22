//
//  NSDate+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 05/06/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "NSDate+ORG.h"
#import "NSObject+ORG.h"
#import <objc/runtime.h>

static NSString * const ORGAssociatedKey_DateOffset = @"ORGDateOffset";
static NSTimeInterval ORG_dateOffset = 0;


@implementation NSDate (ORG)

+ (void)load {
    
    if (self == [NSDate class]) {
        [self ORG_swizzleClassMethod:@selector(date) withClassMethod:@selector(ORG_date)];
     }
}

+ (instancetype)ORG_date {
    
    NSDate * systemDate = [NSDate ORG_date];
    NSDate * ORG_date;
    if (ORG_dateOffset) {
        ORG_date = [NSDate dateWithTimeIntervalSince1970:[systemDate timeIntervalSince1970] + ORG_dateOffset];
    } else {
        ORG_date = systemDate;
    }
    return ORG_date;
}

+ (void)ORG_setDateOffset:(NSTimeInterval)dateOffset {
    
    ORG_dateOffset = dateOffset;
}

@end
