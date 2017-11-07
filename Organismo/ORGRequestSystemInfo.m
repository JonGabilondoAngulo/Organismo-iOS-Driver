//
//  ORGRequestSystemInfo.m
//  Organismo
//
//  Created by Jon Gabilondo on 07/11/2017.
//  Copyright © 2017 organismo-mobile. All rights reserved.
//

#import "ORGRequestSystemInfo.h"
#import "SystemServices.h"

@implementation ORGRequestSystemInfo

- (void)execute {
    
    // Return all System Information
    NSDictionary * systemInfo = [SystemServices sharedServices].allSystemInformation;
    [self respondSuccessWithResult:systemInfo];

}

@end
