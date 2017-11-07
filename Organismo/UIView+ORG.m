//
//  UIView+ORG.m
//  organismo
//
//  Created by Jon Gabilondo on 28/03/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIView+ORG.h"
#import "NSDictionary+ORG.h"
#import "ORGConstants.h"
#import "UIGestureRecognizer+ORG.h"
#import <objc/runtime.h>

static NSString * const AORGAssociatedKey_Segues = @"ORG_Segues";

@implementation UIView (ORG)

- (BOOL)ORG_isApplePrivateClass {
    NSString * className = NSStringFromClass(self.class);
    return [className hasPrefix:@"_"] ||
    [className isEqualToString:@"UITransitionView"] ||
    [className isEqualToString:@"UILayoutContainerView"] ||
    [className isEqualToString:@"UIViewControllerWrapperView"] ||
    [className isEqualToString:@"UINavigationTransitionView"];
}
- (BOOL)ORG_isAppleMap {
    return [self isKindOfClass:[MKMapView class]];
}
- (BOOL)ORG_isUIControl {
    return [self isKindOfClass:[UIControl class]];
}
- (BOOL)ORG_ignoreSubviews {
    return [self ORG_isAppleMap] ||
    [self ORG_isUIControl] ||
    [self isKindOfClass:[UITextView class]] ||
    [self isKindOfClass:[UIPickerView class]];
}
- (BOOL)ORG_ignoreGestureRecognizers {
    return self.userInteractionEnabled==NO;
}

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    
    if ([self ORG_isApplePrivateClass]) {
        properties[@"private"] = @YES;
    }

    properties[@"class"] = NSStringFromClass([self class]);
    properties[@"layerZPosition"] = [NSNumber numberWithFloat:self.layer.zPosition];
    properties[@"hidden"] = [NSNumber numberWithBool:self.isHidden];
    properties[@"opaque"] = [NSNumber numberWithBool:self.isOpaque];
    properties[@"alpha"] = [NSNumber numberWithFloat:self.alpha];
    properties[@"userInteractionEnabled"] = [NSNumber numberWithBool:self.userInteractionEnabled];
    if (self.backgroundColor) {
        properties[@"backgroundColor"] = self.backgroundColor.description;
    }
    if (self.tintColor) {
        properties[@"tintColor"] = self.tintColor.description;
    }

    CGRect appSpaceBounds = [self convertRect:self.bounds toView:nil];
    properties[@"bounds"] = [NSDictionary ORG_createWithCGRect:appSpaceBounds];

    NSMutableDictionary *accessibilityProps = [NSMutableDictionary dictionary];
    if (self.accessibilityLabel.length) {
        accessibilityProps[@"accessibilityLabel"] = self.accessibilityLabel;
    }
    if (self.accessibilityIdentifier.length) {
        accessibilityProps[@"accessibilityIdentifier"] = self.accessibilityIdentifier;
    }
    if (self.accessibilityHint.length) {
        accessibilityProps[@"accessibilityHint"] = self.accessibilityHint;
    }
    if (self.accessibilityValue.length) {
        accessibilityProps[@"accessibilityValue"] = self.accessibilityValue;
    }
    if (accessibilityProps.count) {
        properties[@"accessibility"] = accessibilityProps;
    }

    if ([self ORG_ignoreGestureRecognizers]==NO) {
        if (self.gestureRecognizers.count) {
            NSMutableArray * gestures = [NSMutableArray array];
            
            for (UIGestureRecognizer * gestureRecognizer in self.gestureRecognizers) {
                // MKMapView may have private gestures but we need to give their description so the web UI can tell what gestures it answers to.
                if ( [self isKindOfClass:[MKMapView class]] || [gestureRecognizer ORG_mustBeIgnored] == NO) {
                    NSDictionary * gestureDescription = [gestureRecognizer ORG_description];
                    if (gestureDescription) {
                        [gestures addObject:gestureDescription];
                    }
                }
            }
            if (gestures.count) {
                properties[@"gestures"] = gestures;
            }
        }
    }
    
    if (self.ORG_segues.count) {
        properties[@"segues"] = self.ORG_segues;
    }
    
    // UIKBKeyView
    if ([self respondsToSelector:@selector(key)]) {
        NSObject *keyTree = [self performSelector:@selector(key)]; //UIKBTree
        if (keyTree) {
            NSString * name = [keyTree performSelector:@selector(name)];
            if (name) {
                properties[@"name"] = name;
            }
        }
    }
    
    // Some advanced info
    properties[@"pointer"] = [NSString stringWithFormat:@"%p", self];
    
    return properties;
}

- (void)ORG_addSegueInfo:(NSDictionary*)segue {
    NSMutableArray * segues = self.ORG_segues;
    if (!segues) {
        segues = [NSMutableArray array];
        self.ORG_segues = segues;
    }
    [segues addObject:segue];
}

- (BOOL)ORG_needsScreenshot {
    return YES;
}

#pragma mark - Properties Utils

- (NSArray *)ORG_allPropertyNames {
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)  {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        if ([self ORG_ignorePropertyByName:propertyName] == NO) {
            [rv addObject:propertyName];
            
            @try {
                id propertyValue = [self valueForKey:propertyName   ];
                if (propertyValue && [self ORG_ignorePropertyByValue:propertyValue]==NO) {
                    NSLog(@"%@:%@", propertyName, propertyValue);
                }
            } @catch (NSException *exception) {
                // Happens often, not all properties are KVC compliant
            }
        }
    }
    
    free(properties);
    
    return rv;
}

- (BOOL)ORG_ignorePropertyByName:(NSString*)propertyName {
    
    return [propertyName hasPrefix:@"_"] ||
    [propertyName isEqualToString:@"description"] ||
    [propertyName isEqualToString:@"debugDescription"] ||
    [propertyName isEqualToString:@"hash"];
}

- (BOOL)ORG_ignorePropertyByValue:(id)propertyValue {
    
    return [NSStringFromClass([propertyValue class]) hasPrefix:@"_"];
}


#pragma mark - Associative properties

- (NSMutableArray*)ORG_segues {
    
    NSMutableArray* segues = objc_getAssociatedObject(self, (__bridge const void *)(AORGAssociatedKey_Segues));
    return segues;
}

- (void)setORG_segues:(NSMutableArray*)segues {
    objc_setAssociatedObject(self, (__bridge const void *)(AORGAssociatedKey_Segues), segues, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
