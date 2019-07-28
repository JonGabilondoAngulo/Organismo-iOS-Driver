//
//  ORGUITreeNode.h
//  Organismo-mac
//
//  Created by Jon Gabilondo on 05/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ORGUITreeNode : NSObject

@property (nonatomic, weak) NSView *view;
@property (nonatomic) NSMutableArray<ORGUITreeNode*> *subviews;

- (instancetype)initWithView:(nonnull NSView*)view;
- (NSString*)title;
- (NSString*)descriptor;
- (NSImage*)thumbnailImage;

@end

NS_ASSUME_NONNULL_END
