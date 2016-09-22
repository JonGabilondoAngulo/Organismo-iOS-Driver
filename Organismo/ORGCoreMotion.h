//
//  ORGCoreMotion.h
//

#import <Foundation/Foundation.h>

@interface ORGCoreMotion : NSObject

@property (nonatomic) NSDictionary * externalFeedData;

+ (instancetype)sharedInstance;

- (void)startFeed;
- (void)stopFeed;
- (void)virtualFeedUpdate:(NSDictionary*)updateInfo;

@end
