//
//  ORGRequestClassHierarchy.m
//  Organismo
//
//  Created by Jon Gabilondo on 13/02/2018.
//  Copyright © 2018 organismo-mobile. All rights reserved.
//

#import "ORGRequestClassHierarchy.h"

@implementation ORGRequestClassHierarchy

- (void)execute {
    
    NSString * className = self.parameters[@"className"];
    if (!className || className.length==0) {
        [self respondWithError:1000 description:@"Missing class name."];
    }
    
    Class class = NSClassFromString(className);
    if (!class) {
        [self respondWithError:1000 description:@"Unknown class name."];
    }
    
    NSMutableArray<NSString *> * hierarchy = [NSMutableArray arrayWithObject:className];
    [self hierarchyOfClass:class.superclass array:hierarchy];
    [self respondSuccessWithResult:hierarchy];
}

- (NSMutableArray<NSString *>*)hierarchyOfClass:(Class)class array:(NSMutableArray<NSString *>*)array {
    [array insertObject:NSStringFromClass(class) atIndex:0];
    if (class.superclass) {
        [self hierarchyOfClass:class.superclass array:array];
    }
    return array;
}

@end
