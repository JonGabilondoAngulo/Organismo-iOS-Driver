//
//  ORGGesture.h
//  Organismo
//
//  Created by Jon Gabilondo on 18/09/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORGGesture : NSObject

@property (nonatomic, nonnull) NSDictionary * parameters;

- (instancetype)initWithParameters:(NSDictionary*)parameters;
- (void)execute;

@end
