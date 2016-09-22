//
//  UIControl+ORG.m
//  Organismo
//
//  Created by Jon Gabilondo on 17/07/2016.
//  Copyright © 2016 organismo-mobile. All rights reserved.
//

#import "UIControl+ORG.h"
#import "UIView+ORG.h"

@implementation UIControl (ORG)

- (NSMutableDictionary*)ORG_viewProperties {
    
    NSMutableDictionary * properties = [NSMutableDictionary dictionary];
    
    [properties addEntriesFromDictionary:[super ORG_viewProperties]];
    
    properties[@"selected"] = [NSNumber numberWithBool:self.selected];
    properties[@"highlighted"] = [NSNumber numberWithBool:self.highlighted];
    
    NSString * state = @"";
    switch (self.state) {
        case UIControlStateNormal: state = @"UIControlStateNormal"; break;
        case UIControlStateHighlighted: state = @"UIControlStateHighlighted"; break;
        case UIControlStateDisabled: state = @"UIControlStateDisabled"; break;
        case UIControlStateSelected: state = @"UIControlStateSelected"; break;
        case UIControlStateFocused: state = @"UIControlStateFocused"; break;
        case UIControlStateApplication: state = @"UIControlStateApplication"; break;
        case UIControlStateReserved: state = @"UIControlStateReserved"; break;
    };
    properties[@"state"] = state;
    
    // Targets
    NSSet * allTargets = self.allTargets;
    NSMutableArray * targets = [NSMutableArray array];
    for (id target in allTargets) {
        [targets addObject:NSStringFromClass([target class])];
    }
    if (targets.count) {
        properties[@"targets"] = targets;
    }

    // Control Events
    UIControlEvents controlEvents = self.allControlEvents;
    if (controlEvents) {
        NSMutableArray * events = [NSMutableArray array];
        if (controlEvents & UIControlEventTouchDown) {
            [events addObject:@"UIControlEventTouchDown"];
        }
        if (controlEvents & UIControlEventTouchDownRepeat) {
            [events addObject:@"UIControlEventTouchDownRepeat"];
        }
        if (controlEvents & UIControlEventTouchDragInside) {
            [events addObject:@"UIControlEventTouchDragInside"];
        }
        if (controlEvents & UIControlEventTouchDragOutside) {
            [events addObject:@"UIControlEventTouchDragOutside"];
        }
        if (controlEvents & UIControlEventTouchDragEnter) {
            [events addObject:@"UIControlEventTouchDragEnter"];
        }
        if (controlEvents & UIControlEventTouchDragExit) {
            [events addObject:@"UIControlEventTouchDragExit"];
        }
        if (controlEvents & UIControlEventTouchUpInside) {
            [events addObject:@"UIControlEventTouchUpInside"];
        }
        if (controlEvents & UIControlEventTouchUpOutside) {
            [events addObject:@"UIControlEventTouchUpOutside"];
        }
        if (controlEvents & UIControlEventTouchCancel) {
            [events addObject:@"UIControlEventTouchCancel"];
        }
        if (controlEvents & UIControlEventValueChanged) {
            [events addObject:@"UIControlEventValueChanged"];
        }
        if (controlEvents & UIControlEventPrimaryActionTriggered) {
            [events addObject:@"UIControlEventPrimaryActionTriggered"];
        }
        if (controlEvents & UIControlEventEditingDidBegin) {
            [events addObject:@"UIControlEventEditingDidBegin"];
        }
        if (controlEvents & UIControlEventEditingChanged) {
            [events addObject:@"UIControlEventEditingChanged"];
        }
        if (controlEvents & UIControlEventEditingDidEnd) {
            [events addObject:@"UIControlEventEditingDidEnd"];
        }
        if (controlEvents & UIControlEventEditingDidEndOnExit) {
            [events addObject:@"UIControlEventEditingDidEndOnExit"];
        }
        if (controlEvents & UIControlEventAllTouchEvents) {
            [events addObject:@"UIControlEventAllTouchEvents"];
        }
        if (controlEvents & UIControlEventAllEditingEvents) {
            [events addObject:@"UIControlEventAllEditingEvents"];
        }
        if (controlEvents & UIControlEventApplicationReserved) {
            [events addObject:@"UIControlEventApplicationReserved"];
        }
        if (controlEvents & UIControlEventSystemReserved) {
            [events addObject:@"UIControlEventSystemReserved"];
        }
        if (controlEvents & UIControlEventAllEvents) {
            [events addObject:@"UIControlEventAllEvents"];
        }
        if (events.count) {
            properties[@"controlEvents"] = events;
        }
    }

    return properties;
}

@end
