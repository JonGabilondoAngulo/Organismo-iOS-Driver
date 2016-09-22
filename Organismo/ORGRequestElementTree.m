//
//  ORGRequestGetElementTree.m
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestElementTree.h"
#import "ORGUIViewHierarchy.h"
#import "ORGMessage.h"

@implementation ORGRequestElementTree


- (void)execute {

    // working on UI better done on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray * tree = [ORGUIViewHierarchy mainWindowElementTree:[self parameters] skipPrivateClasses:YES viewScreenshots:YES];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self respondSuccessWithResult:tree];
        });
    });
}

@end
