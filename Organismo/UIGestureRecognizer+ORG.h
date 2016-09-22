//
//  UIGestureRecognizer+ORG.h
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (ORG)

- (NSDictionary*)ORG_description;
- (BOOL)ORG_mustBeIgnored;

@end
