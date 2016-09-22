//
//  ORGScreenshot.h
//  organismo
//
//  Created by Jon Gabilondo on 30/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORGScreenshot : NSObject

/**
 *  Creates a full screenshot.
 *
 *  @return An UIImage object of the screenshot.
 */
+ (UIImage*)screenshot; // Technical Q&A QA1703

/**
 *  Create a full screenshot in PNG format.
 *
 *  @return A PNG.
 */
+ (NSData*)screenshotPNG;

/**
 *  Create a full screenshot in JPEG format.
 *
 *  @return A JPEG.
 */
+ (NSData*)screenshotJPEG;

/**
 *  Create an screenshot of the given view.
 *
 *  @param view The UIView to make s image with.
 *
 *  @return The UIImage of the UIView.
 */
+ (UIImage*)viewScreenshot:(UIView*)view;

/**
 *  Create a an screenshot of the given view in PNG format.
 *
 *  @param view The UIView to make the screenshot with.
 *
 *  @return An NSData object with PNG data.
 */
+ (NSData*)viewScreenshotPNG:(UIView*)view;

/**
 *  Create a an screenshot of the given view in JPEG format.
 *
 *  @param view The UIView to make the screenshot with.
 *
 *  @return An NSData object with JPEG data.
 */
+ (NSData*)viewScreenshotJPEG:(UIView*)view;

@end
