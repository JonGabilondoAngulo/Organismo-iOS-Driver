//
//  UIStoryboardSegue+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 18/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIStoryboardSegue+ORG.h"
#import "NSObject+ORG.h"

@implementation UIStoryboardSegue (ORG)

+ (void)load {
    
    if (self == [UIStoryboardSegue class]) {
    
//        [self ORG_swizzleMethod:@selector(init) withMethod:@selector(ORG_init)];
//        [self ORG_swizzleMethod:@selector(initWithIdentifier:source:destination:) withMethod:@selector(ORG_initWithIdentifier:source:destination:)];
//        [self ORG_swizzleClassMethod:@selector(segueWithIdentifier:source:destination:performHandler:)
//                          withClassMethod:@selector(ORG_segueWithIdentifier:source:destination:performHandler:)];
    }
}

- (id)ORG_segueWithIdentifier:(id)arg1 source:(id)arg2 destination:(id)arg3 performHandler:(id /* block */)arg4 {
    return [self ORG_segueWithIdentifier:arg1 source:arg2 destination:arg3 performHandler:arg4];
}

- (id)ORG_init {
    return [self ORG_init];
}

- (id)ORG_initWithIdentifier:(id)arg1 source:(id)arg2 destination:(id)arg3 {
    return [self ORG_initWithIdentifier:arg1 source:arg2 destination:arg3];
}


@end
