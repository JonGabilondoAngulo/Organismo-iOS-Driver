//
//  ORGRequestElementInfo.m
//  Organismo
//
//  Created by Jon Gabilondo on 08/08/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestElementInfo.h"
#import "ORGUIViewHierarchy.h"
#import "NSDictionary+ORG.h"

@implementation ORGRequestElementInfo

- (void)execute {
    
    // working on UI better done on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary * location = self.parameters[@"location"];
        if (location) {
            NSDictionary * elementInfo = [ORGUIViewHierarchy elementInfoAtLocation:[location ORG_CGPoint]];

            if (elementInfo) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self respondSuccessWithResult:elementInfo];
                });
            }
        }
    });
}

@end
