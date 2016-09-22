//
//  NSObject+ORG.h
//
//  Created by Jon Gabilondo on 5/13/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (ORG)

+ (BOOL)ORG_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;
+ (BOOL)ORG_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector ofClass:(Class)newSelectorClass;
+ (BOOL)ORG_swizzleClassMethod:(SEL)origSelector withClassMethod:(SEL)newSelector;
+ (BOOL)ORG_isSuperclassOfClass:(Class)aClass;

- (void)ORG_interceptMethod:(SEL)orig withMethod:(SEL)repl ofClass:(Class)class renameOrig:(SEL)newName types:(char*) types;
- (void)ORG_interceptMethod2:(SEL)orig withMethod:(SEL)repl ofClass:(Class)class renameOrig:(SEL)newName types:(char*) types;

- (BOOL)ORG_hasMethod:(SEL)selector;
- (BOOL)ORG_hasSelector:(SEL)selector;

@end
