//
//  UIApplication+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 25/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIApplication+ORG.h"
#import "NSDictionary+ORG.h"
#import <objc/runtime.h>
#import <HTTPServer.h>
#import <HTTPConnection.h>
#import "ORGHTTPConnection.h"
#import "DDTTYLogger.h"
#import "DDASLLogger.h"
#import "DDLog.h"
#import "ORGOutboundMessageQueue.h"
#import "ORGMessageBuilder.h"
#import "ORGMainWebSocket.h"

static HTTPServer *httpServer;
static BOOL org_enableOrientationFeed;
static ORGMainWebSocket * org_webSocket;

@implementation UIApplication (ORG)

CATEGORY_PROPERTY_GET_SET(ORGMainWebSocket*, org_webSocket, setOrg_webSocket:);
CATEGORY_PROPERTY_GET_SET_BOOL(org_enableOrientationFeed, setOrg_enableOrientationFeed:);

+ (void)load
{
    if (self == [UIApplication class])
    {
        // App's life cycle Notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidFinishLaunchingNotification:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationWillTerminateNotification:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationWillResignActiveNotification:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        
        
        // Orientations
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationWillChangeStatusBarOrientationNotification:)
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidChangeStatusBarOrientationNotification:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
    }
    
}

#pragma mark @App LifeCycle


+ (void)ORG_applicationDidFinishLaunchingNotification:(id)sender
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                   ^{
                       httpServer = [[HTTPServer alloc] init];
                       
                       //-
                       // Bonjour.
                       // Tell the server to broadcast its presence via Bonjour.
                       // This allows browsers such as Safari to automatically discover our service.
                       //-
                       [httpServer setType:@"_http._tcp."];
                       [httpServer setName:@"Organismo"];

                       [httpServer setConnectionClass:[ORGHTTPConnection class]];
                       [httpServer setPort:5567];
                       //[httpServer setInterface:@"lo0"]; // Listen only on Loopback Device, WIFI client connections will NOT be possible
                       
                       // Serve files from our embedded Web folder
                       NSBundle * organismoBundle = [NSBundle bundleForClass:NSClassFromString(@"ORGCoreMotion")];
                       NSString *webPath = [[organismoBundle resourcePath] stringByAppendingPathComponent:@"Web"];
                       [httpServer setDocumentRoot:webPath];

                       NSError *error;
                       if ([httpServer start:&error]) {
                       }
                       else {
                       }
                   });

}

+ (void)ORG_applicationDidBecomeActive:(id)sender
{
}

+ (void)ORG_applicationDidEnterBackgroundNotification:(id)sender
{
}

+ (void)ORG_applicationWillEnterForegroundNotification:(id)sender
{
    
}

+ (void)ORG_applicationWillTerminateNotification:(id)sender
{
}

+ (void)ORG_applicationWillResignActiveNotification:(id)sender
{
}

#pragma mark @StatusBar

+ (void)ORG_applicationWillChangeStatusBarOrientationNotification:(id)sender {
}

+ (void)ORG_applicationDidChangeStatusBarOrientationNotification:(id)sender {
    
    NSString * orientationStr = @"UNKNOWN";
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:  orientationStr = @"UIInterfaceOrientationPortrait"; break;
        case UIInterfaceOrientationPortraitUpsideDown: orientationStr = @"UIInterfaceOrientationPortraitUpsideDown"; break;
        case UIInterfaceOrientationLandscapeLeft: orientationStr = @"UIInterfaceOrientationLandscapeLeft"; break;
        case UIInterfaceOrientationLandscapeRight: orientationStr = @"UIInterfaceOrientationLandscapeRight"; break;
        default:
            break;
    }

    if (org_enableOrientationFeed && org_webSocket) {
        [org_webSocket.outboundQueue postMessage:[ORGMessageBuilder buildNotification:@"orientation-change"
                                                                       withParameters:@{@"orientation":orientationStr,
                                                                                        @"screenSize":[NSDictionary ORG_createWithCGSize:[UIScreen mainScreen].bounds.size]
                                                                                        }]];
    }
}

#pragma mark @ Get/Set

+ (BOOL)org_enableOrientationFeed {
    return org_enableOrientationFeed;
}

+ (void)org_setEnableOrientationFeed:(BOOL)enable {
    org_enableOrientationFeed = enable;
}

+ (ORGMainWebSocket*)org_webSocket {
    return org_webSocket;
}

+ (void)org_setWebSocket:(ORGMainWebSocket*)webSocket {
    org_webSocket = webSocket;
}

@end
