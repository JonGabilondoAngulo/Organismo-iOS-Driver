//
//  UIView+ORG.h
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ORG)

@property (nonatomic) NSMutableArray * ORG_segues;

- (NSMutableDictionary*)ORG_viewProperties;

- (BOOL)ORG_isApplePrivateClass;
- (BOOL)ORG_isAppleMap;
- (BOOL)ORG_isUIControl;
- (BOOL)ORG_ignoreSubviews;
- (void)ORG_addSegueInfo:(NSDictionary*)segue;
- (BOOL)ORG_needsScreenshot;
- (BOOL)ORG_ignoreGestureRecognizers;

@end
