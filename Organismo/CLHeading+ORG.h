//
//  CLHeading+ORG.h
//  Organismo
//
//  Created by Jon Gabilondo on 13/04/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLHeading (ORG)

+ (instancetype)ORG_createWithHeading:(NSNumber*)heading accuracy:(NSNumber*)accuracy;

@end
