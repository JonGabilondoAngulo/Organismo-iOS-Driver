//
//  ORGRequestDeviceInfo.m
//  organismo
//
//  Created by Jon Gabilondo on 04/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "ORGRequestDeviceInfo.h"
#import "NSDictionary+ORG.h"
#include <sys/sysctl.h>

@interface ORGRequestDeviceInfo()
- (NSString *)devicePlatformString;
@end

@implementation ORGRequestDeviceInfo

- (void)execute {
    
    NSMutableDictionary * deviceInfo = [NSMutableDictionary dictionary];
    UIDevice * device = [UIDevice currentDevice];
    deviceInfo[@"name"] = device.name;
    deviceInfo[@"productName"] = [self devicePlatformString];
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
        case UIUserInterfaceIdiomPhone: deviceInfo[@"userInterfaceIdiom"] = @"UIUserInterfaceIdiomPhone"; break;
        case UIUserInterfaceIdiomPad: deviceInfo[@"userInterfaceIdiom"] = @"UIUserInterfaceIdiomPad"; break;
        case UIUserInterfaceIdiomTV: deviceInfo[@"userInterfaceIdiom"] = @"UIUserInterfaceIdiomTV"; break;
    }
    
    // screen
    deviceInfo[@"scale"] = [NSNumber numberWithFloat:[UIScreen mainScreen].scale];
    deviceInfo[@"screenSize"] = [NSDictionary ORG_createWithCGSize:[UIScreen mainScreen].bounds.size];
    
    [self respondSuccessWithResult:deviceInfo];
}


- (NSString *)devicePlatformString {
    
    // Gets a string with the device model
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1st Gen";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2nd Gen";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3rd Gen";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4th Gen";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5th Gen";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6th Gen";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    return platform;
}

@end
