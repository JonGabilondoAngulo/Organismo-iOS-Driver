//
//  ORGNSViewHierarchy
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#import "ORGUITreeNode.h"

@interface ORGNSViewHierarchy : NSObject

+ (void)childNodes:(ORGUITreeNode*)rootView skipPrivateClasses:(BOOL)skipPrivate screenshots:(BOOL)takeScreenshots recursive:(BOOL)deep;

+ (NSArray*)windowsElementTree:(NSDictionary*)properties skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots;
+ (NSArray*)mainWindowElementTree:(NSDictionary*)properties skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots;
+ (NSDictionary*)viewElementTree:(NSView*)rootView skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots;
+ (NSWindow*)keyWindow:(NSApplication*)app;
+ (NSWindow*)mainWindow:(NSApplication*)app;
+ (NSArray<NSWindow*>*)appWindows:(NSApplication*)app;
+ (NSDictionary*)elementInfoAtLocation:(CGPoint)location;


@end
