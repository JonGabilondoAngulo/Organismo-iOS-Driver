//
//  ORGUITree.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 05/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ORGUITreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface ORGUITree : NSObject

@property (nonatomic) NSMutableArray<ORGUITreeNode*> *windows;


@end

NS_ASSUME_NONNULL_END
