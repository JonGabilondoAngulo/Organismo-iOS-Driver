//
//  UINibDecoder+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 19/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UINibDecoderORG.h"
#import "NSObject+ORG.h"

#import "UIView+ORG.h"

#import <objc/runtime.h>

static IMP originalIMP = nil;

@interface UINibDecoderORG()

/**
 *  Swizzle the class that decodes nibs (UINibDecoder) to get information about segues.
 *  Swizzled in the safest possible way, using the IMP.
 *
 *  @param
 *
 *  @return
 */
+ (void)load;

/**
 *  Our implementation of "decodeObjectForKey:" to capture the original call while decoding a Nib and get segues information.
 *
 *  @param arg1 Just a key string. We know that the relevant info comes with key UINibConnectionsKey.
 *
 *  @return the object created by the original method.
 */
- (id)ORG_decodeObjectForKey:(id)arg1;

/**
 *  Search the segues information in the decoded object. This object is the content of "UINibConnectionsKey" where the segues are kept.
 *  The segues info will be kept in the source UI Object of the segue.
 *
 *  @param decodedObject the decoded object to analyze
 */
+ (void)obtainSeguesInfo:(id)decodedObject;
@end

@implementation UINibDecoderORG

+ (void)load {
    
    if (self == [UINibDecoderORG class]) {
        
        Class UINibDecoderClass = NSClassFromString(@"UINibDecoder"); // https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/UIKit.framework/UINibDecoder.h
        if (UINibDecoderClass) {
            Method origMethod = class_getInstanceMethod(UINibDecoderClass, sel_getUid("decodeObjectForKey:"));
            originalIMP = method_getImplementation(origMethod);
            
            Method newMethod = class_getInstanceMethod(self.class, sel_getUid("ORG_decodeObjectForKey:"));
            IMP newImp = method_getImplementation(newMethod);
            method_setImplementation(origMethod, newImp);
        }
    }
}

- (id)ORG_decodeObjectForKey:(id)arg1 {
    
    id decodedObject = ((id(*)(id,SEL,id))originalIMP)(self, _cmd, arg1); // Call original
    
    // The segues come in key UINibConnectionsKey
    if (decodedObject && [arg1 isEqualToString:@"UINibConnectionsKey"]) {
        [UINibDecoderORG obtainSeguesInfo:decodedObject]; // self is UINibDecoder not UINibDecoderORG, do not use self
    }

    return decodedObject;
}

+ (void)obtainSeguesInfo:(id)decodedObject {
    
    if (!decodedObject) {
        return;
    }
    
    //NSLog(@"Arg:%@. ObjDesc: %@. Obj:%@", arg1, [decodedObject description], [decodedObject class]);
    
    // It has to be an Array
    if ([decodedObject isKindOfClass:[NSArray class]]) {
        for (id element in decodedObject) {
            
            //NSLog(@"Element in Array. class:%@. Descr;%@", [element class], element);
            
            // The object we need is a UIRuntimeEventConnection
            if ([NSStringFromClass([element class]) isEqualToString:@"UIRuntimeEventConnection"]) {
                
                // https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/UIKit.framework/UIRuntimeEventConnection.h
                
                // We have it, "source" will tell us the UI object that triggers the segue.
                // Keep the information of the segue in the object itself.
                
                UIView * control = [element performSelector:@selector(source)];
                if (control) {
                    NSMutableDictionary * segue = [NSMutableDictionary dictionary];
                    
                    NSObject * target = [element performSelector:@selector(target)];
                    if (target && [NSStringFromClass(target.class) isEqualToString:@"UIStoryboardSegueTemplate"]) {
                        segue[@"kind"] = NSStringFromClass([target class]); //  UIStoryboardPushSegueTemplate, Modal, Popover, Preview ..
                        
                        NSString * identifier = [target performSelector:@selector(identifier)];  //https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/UIKit.framework/UIStoryboardSegueTemplate.h
                        if (identifier) {
                            segue[@"identifier"] = identifier;
                        }
                        
                        if ([target respondsToSelector:@selector(viewController)]) {
                            UIViewController * destinationViewController = [target performSelector:@selector(viewController)];
                            if (destinationViewController) {
                                segue[@"destinationViewController"] = NSStringFromClass([destinationViewController class]);
                            }
                        }
                    } else {
                        // Could be things like SwitchOptionTableViewCell base class UITableViewCell
                        segue[@"target"] = NSStringFromClass(target.class);
                    }
                    // destination same as target ?
                    //NSObject * destination = [element performSelector:@selector(destination)];
                    //if (destination) {
                    //    segue[@"destination"] = NSStringFromClass([destination class]);
                    //}
                    NSObject * label = [element performSelector:@selector(label)];
                    if (label) {
                        segue[@"label"] = label;
                    }
                    if ([control respondsToSelector:@selector(ORG_addSegueInfo:)]) {
                        [control ORG_addSegueInfo:segue];
                    }
                    
                    //NSLog(@"This element has a segue !:%@. Class:%@", control, [control class]);
                }
            }
        }
    }
}

@end


