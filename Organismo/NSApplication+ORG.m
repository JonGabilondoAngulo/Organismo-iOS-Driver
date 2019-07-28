//
//  NSApplication+ORG.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 30/06/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "NSApplication+ORG.h"
#import "ATBasicTableViewWindowController.h"
#import "ATComplexTableViewController.h"
#import "ATComplexOutlineController.h"
#import "ORGNSViewHierarchy.h"
#import "ORGInspectorWindowController.h"

static NSMutableArray *windowControllers;

@implementation NSApplication (ORG)

+ (void)load
{
    if (self == [NSApplication class])
    {
        // App's life cycle Notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidBecomeActive:)
                                                     name:NSApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidHideNotification:)
                                                     name:NSApplicationDidHideNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationDidUnhideNotification:)
                                                     name:NSApplicationDidUnhideNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationWillTerminateNotification:)
                                                     name:NSApplicationWillTerminateNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationWillResignActiveNotification:)
                                                     name:NSApplicationWillResignActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(ORG_applicationWillUpdateNotification:)
                                                     name:NSApplicationWillUpdateNotification
                                                   object:nil];
        
    }
    
}

#pragma mark @App LifeCycle


+ (void)ORG_applicationDidFinishLaunchingNotification:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [NSApplication ORG_createOrganismoMenu];
}

+ (void)ORG_applicationDidBecomeActive:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

+ (void)ORG_applicationDidHideNotification:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

+ (void)ORG_applicationDidUnhideNotification:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

+ (void)ORG_applicationWillTerminateNotification:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

+ (void)ORG_applicationWillResignActiveNotification:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

+ (void)ORG_applicationWillUpdateNotification:(id)sender
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark -

+ (void)ORG_createOrganismoMenu {
    NSMenu *mainMenu = [NSApp mainMenu];
    if (mainMenu) {
        NSMenuItem *organismoMenubarItem = [mainMenu addItemWithTitle:@"Organismo" action:@selector(ORG_submenuAction:) keyEquivalent:@""];
        [organismoMenubarItem setHidden:NO];
        [organismoMenubarItem setEnabled:YES];
        organismoMenubarItem.target = NSApp;
        
        NSMenu *organismoMenu = [[NSMenu alloc] initWithTitle:@"Organismo"];
        organismoMenu.autoenablesItems = NO;
        [organismoMenubarItem setSubmenu:organismoMenu];

        NSMenuItem *orgMenuItem = [organismoMenu addItemWithTitle:@"Inspector" action:@selector(ORG_submenuAction:) keyEquivalent:@""];
        orgMenuItem.identifier = @"inspector";
        orgMenuItem.target = NSApp;
        orgMenuItem.enabled = YES;

        orgMenuItem = [organismoMenu addItemWithTitle:@"About Organismo" action:@selector(ORG_submenuAction:) keyEquivalent:@""];
        orgMenuItem.identifier = @"about";
        orgMenuItem.target = NSApp;
        orgMenuItem.enabled = YES;
    }
}

- (void)ORG_submenuAction:(NSMenuItem*)menuItem {
    
    if ([menuItem.identifier isEqualToString:@"about"]) {
        NSAttributedString *credits = [[NSAttributedString alloc] initWithString:@""];
        [NSApp orderFrontStandardAboutPanelWithOptions:@{NSAboutPanelOptionCredits:credits,
                                                         NSAboutPanelOptionApplicationName:@"Organismo Injected",
                                                         NSAboutPanelOptionVersion:@"0.1",
                                                         NSAboutPanelOptionApplicationVersion:@"0.1"
                                                         }];
    } else if ([menuItem.identifier isEqualToString:@"inspector"]) {
        [self newWindowWithControllerClass:[ORGInspectorWindowController class]];
    }
}

- (void)newWindowWithControllerClass:(Class)c {
    NSWindowController *controller = [[c alloc] init];
    if (windowControllers == nil) {
        windowControllers = [NSMutableArray array];
    }
    [windowControllers addObject:controller];
    [controller showWindow:self];
}


@end
