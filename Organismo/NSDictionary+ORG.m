//
//  NSDictionary+ORG.m
//

#import "NSDictionary+ORG.h"
#import "ORGConstants.h"

@implementation NSDictionary (ORG)

+ (NSDictionary*)ORG_createWithString:(NSString *)string
{
    NSDictionary * resultDict;
    if (string && string.length) {
        NSData * stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSError * error;
        resultDict = [NSJSONSerialization JSONObjectWithData:stringData options:kNilOptions  error:&error];
        
        if (error || ![NSJSONSerialization isValidJSONObject:resultDict]) {
        }
    }
    return resultDict;
}

+ (NSDictionary*)ORG_createWithCGRect:(CGRect)rect
{
    return @{AAMActionKey_Left:[NSNumber numberWithFloat:(rect.origin.x)],AAMActionKey_Top:[NSNumber numberWithFloat:(rect.origin.y)],
             AAMActionKey_Right:[NSNumber numberWithFloat:(rect.origin.x+rect.size.width)], AAMActionKey_Bottom:[NSNumber numberWithFloat:(rect.origin.y+rect.size.height)]};
}

- (CGRect)ORG_CGRect
{
    return CGRectMake([self[AAMActionKey_Left] floatValue], [self[AAMActionKey_Top] floatValue], [self[AAMActionKey_Right] floatValue]-[self[AAMActionKey_Left] floatValue], [self[AAMActionKey_Bottom] floatValue]-[self[AAMActionKey_Top] floatValue]);
}

+ (NSDictionary*)ORG_createWithCGPoint:(CGPoint)point
{
    return @{AAMActionKey_X:[NSNumber numberWithFloat:(point.x)],AAMActionKey_Y:[NSNumber numberWithFloat:(point.y)]};
}

- (CGPoint)ORG_CGPoint
{
    CGPoint point = CGPointZero;
    NSNumber * x = self[AAMActionKey_X];
    NSNumber * y = self[AAMActionKey_Y];
    if (x && y) {
        point = CGPointMake(x.floatValue, y.floatValue);
    }
    return point;
}

+ (NSDictionary*)ORG_createWithCGSize:(CGSize)size
{
    return @{@"width":[NSNumber numberWithFloat:(size.width)],@"height":[NSNumber numberWithFloat:(size.height)]};
}

- (CGSize)ORG_CGSize
{
    return CGSizeMake([self[@"width"] floatValue], [self[@"height"] floatValue]);
}

- (NSString*)ORG_JSONString
{
    NSString * jsonString;
    @try {
        NSError * error;
        NSData * data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
        if (data) {
            jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    } @catch (NSException *exception) {
        NSLog(@"ERROR. Exception: %@. At:%s", exception, __PRETTY_FUNCTION__);
    }
    return jsonString;
}

@end
