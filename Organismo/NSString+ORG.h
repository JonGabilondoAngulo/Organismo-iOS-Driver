//
//  NSString+ORG.h
//  organismo
//
//  Created by Jon Gabilondo on 26/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ORG)

- (NSDictionary *)ORG_dictionary:(NSError **)error;
- (BOOL)ORG_isEqualToStringIgnoreCase:(NSString*)string;
+ (NSString *)ORG_base64StringFromData: (NSData *)data length:(NSUInteger)length;

@end
