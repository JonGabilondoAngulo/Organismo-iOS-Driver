//
//  ORGUIViewHierarchy
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ORGUIViewHierarchy : NSObject


/**
 Returns a tree of all the elements in the windows defined in "properties".

 @param properties A dictionary of the window type and of to get thir element tree.
 @param skipPrivate Do not report views with private classes.
 @param viewScreenshots Get screenshots for every view.
 @return An array of windows with their trees.
 */
+ (NSArray*)windowsElementTree:(NSDictionary*)properties skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots;

/**
 *  Returns a tree of all the UI elements of the App's main window.
 *
 *  @param properties      properties for the creation of the tree.
 *  @param skipPrivate     ignore all the UI elements that are Apple's private.
 *  @param viewScreenshots get an screenshot of every ui element.
 *
 *  @return Array with just one dictionary holding the first node of the tree which is the main window.
 */
+ (NSArray*)mainWindowElementTree:(NSDictionary*)properties skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots;

/**
 *  Creates a tree with all the elements of the given ui element. The first element is the element passed in the argument.
 *
 *  @param rootView        The ui element of type UIView from which to build the tree, the given element will me the root node in the tree.
 *  @param skipPrivate     Ignore all the UI elements that are Apple's private.
 *  @param viewScreenshots Get an screenshot of every ui element and add it to the description of the object inthe tree node.
 *
 *  @return A dictionary with the description of the root view plus all its sub elements.
 */
+ (NSDictionary*)viewElementTree:(UIView*)rootView skipPrivateClasses:(BOOL)skipPrivate viewScreenshots:(BOOL)viewScreenshots;

/**
 *  Finds the main window of the App.
 *
 *  @param app The UIApplciation
 *
 *  @return The main UIWindow of the App, ignores the status, alerts and keyboards and gets the main window.
 */
+ (UIWindow*)rootWindow:(UIApplication*)app;

/**
 *  Finds all the windows of the given App and returns them in visual order. The frontmost window will be first in the list.
 *
 *  @param app             The App.
 *  @param ignoreKeyboards Ignore the keyboard window.
 *
 *  @return An array with all the windows in visual order. Frontmost window willbe first.
 */
+ (NSArray*)appWindows:(UIApplication*)app ignoreKeyboards:(BOOL)ignoreKeyboards;


/**
 *  Return the inforamtion of the UI element found at the given location.
 *
 *  @param location Point in App coordinates.
 *
 *  @return A Dictionary with all the information about the element.
 */
+ (NSDictionary*)elementInfoAtLocation:(CGPoint)location;

/**
 *  Given a point in a rootView, find the subview that the point hits. If no subview found the rootView will the returned as the result.
 *
 *  @param pt       Point in App coordinates
 *  @param rootView The root view to start searching.
 *
 *  @return The found UIView.
 */
- (UIView*)findViewAtPoint:(CGPoint)pt rootView:(UIView*)rootView;

@end
