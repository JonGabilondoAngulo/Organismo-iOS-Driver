//
//  ORGRequestDeviceInfo.m
//  organismo
//
//  Created by Jon Gabilondo on 04/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestDeviceInfo.h"
#import "NSDictionary+ORG.h"

@implementation ORGRequestDeviceInfo

- (void)execute {
    
    NSMutableDictionary * deviceInfo = [NSMutableDictionary dictionary];
    UIDevice * device = [UIDevice currentDevice];
    deviceInfo[@"name"] = device.name;
    deviceInfo[@"model"] = device.model;
    deviceInfo[@"localizationModel"] = device.localizedModel;
    deviceInfo[@"systemName"] = device.systemName;
    deviceInfo[@"systemVersion"] = device.systemVersion;
    deviceInfo[@"identifierForVendor"] = device.identifierForVendor.UUIDString;
    switch (device.orientation) {
        case UIDeviceOrientationUnknown: deviceInfo[@"orientation"] = @"UIDeviceOrientationUnknown"; break;
        case UIDeviceOrientationPortrait: deviceInfo[@"orientation"] = @"UIDeviceOrientationPortrait"; break;
        case UIDeviceOrientationPortraitUpsideDown: deviceInfo[@"orientation"] = @"UIDeviceOrientationPortraitUpsideDown"; break;
        case UIDeviceOrientationLandscapeLeft: deviceInfo[@"orientation"] = @"UIDeviceOrientationLandscapeLeft"; break;
        case UIDeviceOrientationLandscapeRight: deviceInfo[@"orientation"] = @"UIDeviceOrientationLandscapeRight"; break;
        case UIDeviceOrientationFaceUp: deviceInfo[@"orientation"] = @"UIDeviceOrientationFaceUp"; break;
        case UIDeviceOrientationFaceDown: deviceInfo[@"orientation"] = @"UIDeviceOrientationFaceDown"; break;
    }
//    device.batteryLevel
//    device.batteryState
    switch (device.userInterfaceIdiom) {
        case UIUserInterfaceIdiomUnspecified: deviceInfo[@"userInterfaceIdiom"] = @"UIUserInterfaceIdiomUnspecified"; break;
        case UIUserInterfaceIdiomPhone: deviceInfo[@"UIUserInterfaceIdiomPhone"] = @"UIUserInterfaceIdiomPhone"; break;
        case UIUserInterfaceIdiomPad: deviceInfo[@"UIUserInterfaceIdiomPad"] = @"UIUserInterfaceIdiomPad"; break;
        case UIUserInterfaceIdiomTV: deviceInfo[@"UIUserInterfaceIdiomTV"] = @"UIUserInterfaceIdiomTV"; break;
    }
    
    // screen
    deviceInfo[@"scale"] = [NSNumber numberWithFloat:[UIScreen mainScreen].scale];
    deviceInfo[@"screenSize"] = [NSDictionary ORG_createWithCGSize:[UIScreen mainScreen].bounds.size];
    
    
    [self respondSuccessWithResult:deviceInfo];
}
@end
