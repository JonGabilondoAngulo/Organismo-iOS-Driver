/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A basic subclass of NSTableCellView that adds some properties strictly for allowing access to the items in code.
 */

#import "ORGTableCellView.h"

@interface ORGTableCellView ()

@property (assign) BOOL isSmallSize;

@end


#pragma mark -

@implementation ORGTableCellView

- (void)layoutViewsForSmallSize:(BOOL)smallSize animated:(BOOL)animated {
    if (self.isSmallSize != smallSize) {
        _isSmallSize = smallSize;
        CGFloat targetAlpha = self.isSmallSize ? 0 : 1;
        if (animated) {
            self.subTitleTextField.animator.alphaValue = targetAlpha;
        } else {
            self.subTitleTextField.alphaValue = targetAlpha;
        }
    }
}

@end
