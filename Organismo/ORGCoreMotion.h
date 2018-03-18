//
//  ORGCoreMotion.h
//

#import <Foundation/Foundation.h>

@class ORGMainWebSocket;

@interface ORGCoreMotion : NSObject

@property (nonatomic) NSDictionary * externalFeedData;
@property (nonatomic) ORGMainWebSocket * webSocket;

+ (instancetype)sharedInstance;

- (void)startFeed;
- (void)stopFeed;
- (void)virtualFeedUpdate:(NSDictionary*)updateInfo;

@end
