//
//  NSObject+AAM.m
//
//  Created by Jon Gabilondo on 5/13/13.
//

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSObject+ORG.h"

@implementation NSObject (ORG)

+ (BOOL)ORG_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    BOOL success = NO;
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    if (origMethod && newMethod) {
        if (class_addMethod(self, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            class_replaceMethod(self, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        } else {
            method_exchangeImplementations(origMethod, newMethod);
        }
        success = YES;
    }
    if (!success) {
        NSLog(@"ERROR INSTRUMENTING CLASS:%@ Method:%@. ", self.class, NSStringFromSelector(origSelector));
    }
    return success;
}

+ (BOOL)ORG_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector ofClass:(Class)newSelectorClass {
    BOOL success = NO;
    Method origMethod = class_getInstanceMethod(self.class, origSelector);
    Method newMethod = class_getInstanceMethod(newSelectorClass, newSelector);
    
    if (origMethod && newMethod) {
        if (class_addMethod(self.class, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) {
            class_replaceMethod(self.class, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        }
    }
//    Method origMethod = class_getInstanceMethod(self.class, origSelector);
//    Method newMethod = class_getInstanceMethod(newSelectorClass, newSelector);
//    
//    if (origMethod && newMethod) {
//        if (class_addMethod(self.class, newSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
//            method_exchangeImplementations(origMethod, newMethod);
//            success = YES;
//        }
//    }
    if (!success) {
        NSLog(@"ERROR INSTRUMENTING CLASS:%@ Method:%@. ", self.class, NSStringFromSelector(origSelector));
    }
    return success;
}

//+ (BOOL)ORG_swizzleMethod:(SEL)origSelector ofClass:(Class)orginalClass withMethod:(SEL)newSelector ofClass:(Class)newSelectorClass {
//    BOOL success = NO;
//    Method origMethod = class_getInstanceMethod(self.class, origSelector);
//    Method newMethod = class_getInstanceMethod(newSelectorClass.class, newSelector);
//    
//    if (origMethod && newMethod) {
//        if (class_addMethod(self.class, newSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) {
//            class_replaceMethod(self.class, origSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
//        }
//    }
//    if (!success) {
//        NSLog(@"ERROR INSTRUMENTING CLASS:%@ Method:%@. ", self.class, NSStringFromSelector(origSelector));
//    }
//    return success;
//}


/**
 *  Swizzle an existing class method with another existing class method.
 *
 *  @param origSelector The existing class method to swizzle
 *  @param newSelector  The existing class method with the new implementation
 *
 *  @return True if success.
 */
+ (BOOL)ORG_swizzleClassMethod:(SEL)origSelector withClassMethod:(SEL)newSelector
{
    BOOL success = NO;
    Method origMethod = class_getClassMethod(self, origSelector);
    Method newMethod = class_getClassMethod(self, newSelector);
    
    if (origMethod && newMethod) {
        method_exchangeImplementations(origMethod, newMethod);
        success = YES;
    }
    if (!success) {
        NSLog(@"ERROR INSTRUMENTING CLASS:%@ Method:%@. ", self.class, NSStringFromSelector(origSelector));
    }
    return success;
}

+ (BOOL)ORG_isSuperclassOfClass:(Class)aClass
{
    BOOL result = NO;
    
    if ([self class] == aClass) {
        result = YES;
    } else {
        Class superClass = class_getSuperclass(aClass);
        
        if (superClass) {
            result = [self ORG_isSuperclassOfClass:superClass];
        }
    }

    return result;
}

// ATTENTION does not return category methods ! http://www.cocoabuilder.com/archive/cocoa/101686-how-to-get-category-method.html
- (BOOL)ORG_hasMethod:(SEL) selector {
	return class_getInstanceMethod([self class], selector) != nil;
}

- (void)ORG_interceptMethod:(SEL)originalSelector withMethod:(SEL)repl ofClass:(Class)classWithReplacementSel renameOrig:(SEL)backupSelector types:(char*) types
{
    @try {
        
        Method replMethod = class_getInstanceMethod(classWithReplacementSel, repl);
        NSAssert(replMethod, @"THIS SHOULD NOT HAPPEN. NO METHOD IN CLASS: %@ SEL:%@", classWithReplacementSel, NSStringFromSelector(repl));
        if (!replMethod) {
            //AAMLogError(@"Error. This should not happen. no method in class: %@ SEL:%@. At:%@", classWithReplacementSel, NSStringFromSelector(repl), NSStringFromSelector(_cmd));
            return;
        }
        IMP replImp = method_getImplementation(replMethod);
        NSAssert(replImp, @"THIS SHOULD NOT HAPPEN. NO IMP IN METHOD IN CLASS %@", classWithReplacementSel);
        if (!replImp) {
            //AAMLogError(@"Error. This should not happen. no IMP in method of class: %@ SEL:%@. At:%@", classWithReplacementSel, NSStringFromSelector(repl), NSStringFromSelector(_cmd));
            return;
        }
        
        if (class_getInstanceMethod(self.class, originalSelector) != NULL) {
//        if ([self respondsToSelector:originalSelector]) {
            
            // Either the self or a superclass has the method
            
            if ([self ORG_hasSelector:originalSelector]) { // The self has the method so swizzle it. Add the backup witht he original impl, abd set swizzle impl to original
               
                //AAMLogDebug(@"SELF HAS THE METHOD, GOING TO SWIZZLE IT %@ !!!! Original SEL:%@",self.class, NSStringFromSelector(originalSelector));
                Method originalMethod = [self ORG_getInstanceMethod:originalSelector];
                IMP origImp = method_getImplementation(originalMethod);
                if (class_addMethod(self.class, backupSelector, origImp, (types ?types :method_getTypeEncoding(replMethod)))) {
                    // Replace original
                    method_setImplementation(originalMethod, replImp);
                    //AAMLogDebug(@"ADDED BACKUP METHOD AND SWIZZLE ORIGINAL TO %@ !!!! SEL:%@",self.class, NSStringFromSelector(backupSelector));
                    
                }
            } else { // Some superclass has the method. Swizzle the superclass.
               
                //AAMLogDebug(@"SELF HAS NOT THE METHOD, CALLED SUPERCLASS FOR SWIZZLE %@ !!!! Original SEL:%@",self.class, NSStringFromSelector(originalSelector));
                [self.superclass ORG_interceptMethod:originalSelector
                                                  withMethod:repl
                                                     ofClass:classWithReplacementSel
                                                  renameOrig:backupSelector // new method name
                                                       types:types];
            }
        } else {
            // Add the original method becase the class does not have the original. Set the swizzled implementation.
            if (class_addMethod(self.class, originalSelector, replImp, (types ?types :method_getTypeEncoding(replMethod)))) {
                //AAMLogDebug(@"ADD ORIGINAL TO %@ !BECAUSE IT HAD NONE !!! SUPERCLASS:%@ SEL:%@",self.class, self.class.superclass, NSStringFromSelector(originalSelector));
                if ([self ORG_hasSelector:originalSelector]==NO) {
                    //AAMLogDebug(@"ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR  !!! CLASS:%@ SUPERCLASS:%@ SEL:%@",self.class, self.class.superclass, NSStringFromSelector(originalSelector));
                }
            } else {
                //AAMLogDebug(@"ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR  COULD NOT ADD ORIGINAL METHOD!!! CLASS:%@ SUPERCLASS:%@ SEL:%@",self.class, self.class.superclass, NSStringFromSelector(originalSelector));
            }
        }
    }
    @catch (NSException *exception) {
        //AAMLogDebug(@"--------------------------------------------------------------------------------------------------------------",@"");
        //AAMLogDebug(@"hpInterceptMethod EXCEPTION  EXCEPTION  EXCEPTION  EXCEPTION  EXCEPTION  EXCEPTION  EXCEPTION  %@",exception);
        //AAMLogDebug(@"--------------------------------------------------------------------------------------------------------------",@"");
        //AAMLogError(@"ERROR. Exception:%@. At:%@", exception, NSStringFromSelector(_cmd));
    }
    @finally {
    }
}

- (void)ORG_interceptMethod2:(SEL)orig withMethod:(SEL)repl ofClass:(Class)class renameOrig:(SEL)newName types:(char*) types {
	Method originalMethod = class_getInstanceMethod([self class], orig);
	IMP origImp = nil;
	if (originalMethod) {
		origImp = method_getImplementation(originalMethod);
	}
	Method replacedMethod = class_getInstanceMethod(class, repl);
	IMP replImp = method_getImplementation(replacedMethod);
    
	if (origImp != replImp) {
		if (originalMethod) {
			method_setImplementation(originalMethod, replImp);
			class_addMethod([self class], newName, origImp,(types ?types :method_getTypeEncoding(originalMethod)));
		} else {
			class_addMethod([self class], orig, replImp,(types ?types :method_getTypeEncoding(replacedMethod)));
		}
	}
}

- (BOOL)ORG_hasSelector:(SEL)selector
{
    BOOL hasSelector = NO;
    
    Method originalMethod = NULL;
    unsigned int count = 0;
    Method * methods = class_copyMethodList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        Method m = methods[i];
        if (m) {
            SEL mSelector = method_getName(m);
            if (mSelector == selector) {
                if (method_getImplementation(m) != NULL) { // extra security, canit happen taht IMP is NULL ?
                    originalMethod = m;
                    hasSelector = YES;
                    break;
                }
            }
        }
    }
    return hasSelector;
}
- (Method)ORG_getInstanceMethod:(SEL)selector
{
    Method originalMethod = NULL;
    unsigned int count = 0;
    Method * methods = class_copyMethodList(self.class, &count);
    for (unsigned int i=0; i<count; i++) {
        Method m = methods[i];
        if (m) {
            SEL methodSelector = method_getName(m);
            if (methodSelector == selector) {
                if (method_getImplementation(m) != NULL) { // extra security, can it happen that IMP is NULL ?
                    originalMethod = m;
                    break;
                }
            }
        }
    }
    return originalMethod;
}

@end
