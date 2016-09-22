//
//  NSDictionary+ORG.h
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ORG)

+ (NSDictionary*)ORG_createWithCGRect:(CGRect)rect;
+ (NSDictionary*)ORG_createWithCGPoint:(CGPoint)point;
+ (NSDictionary*)ORG_createWithCGSize:(CGSize)size;
+ (NSDictionary*)ORG_createWithString:(NSString*)string;
- (CGRect)ORG_CGRect;
- (CGPoint)ORG_CGPoint;
- (CGSize)ORG_CGSize;
- (NSString*)ORG_JSONString;

@end