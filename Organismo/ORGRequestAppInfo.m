//
//  ORGRequestAppInfo.m
//  organismo
//
//  Created by Jon Gabilondo on 04/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestAppInfo.h"

@implementation ORGRequestAppInfo

- (void)execute {

    NSMutableDictionary * appInfo = [NSMutableDictionary dictionary];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    // name
    NSString * appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (appName==nil || [appName length]==0) {
        appName = [infoDictionary objectForKey:@"CFBundleName"];
    }
    if (appName==nil || [appName length]==0) {
        appName = @"AppNameNotFound";
    }
    appInfo[@"name"] = appName;
    
    //version
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (appVersion == nil) {
        appVersion = [infoDictionary objectForKey:@"CFBundleVersion"];;
    }
    if (appVersion == nil) {
        appVersion = @"VersionNotFound";
    }
    appInfo[@"version"] = appVersion;
    
    //app bundle id
    NSString *appId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    if (appId == nil) {
        appId = @"AppIdNotFound";
    }
    appInfo[@"bundleIdentifier"] = appId;
        
    [self respondSuccessWithResult:appInfo];
}

@end
