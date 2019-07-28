//
//  ORGInspectorWindowController.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 08/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "ORGInspectorWindowController.h"
#import "ORGUITree.h"
#import "ORGUITreeNode.h"
#import "ORGNSViewHierarchy.h"

@interface ORGInspectorWindowController ()

@property (weak) IBOutlet NSOutlineView *outlineView;
@property (strong) ORGUITree *tree;

@end

@implementation ORGInspectorWindowController

- (NSString *)windowNibName {
    return @"ORGInspectorWindowController";
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSArray<NSWindow*> *windows = [ORGNSViewHierarchy appWindows:NSApp];
    
    self.tree = [[ORGUITree alloc] init];
    self.tree.windows = [[NSMutableArray alloc] init];
    for (NSWindow *window in windows) {
        [self.tree.windows addObject:[[ORGUITreeNode alloc] initWithView:(NSView*)window]];
    }
    for (ORGUITreeNode *node in self.tree.windows) {
        [ORGNSViewHierarchy childNodes:node skipPrivateClasses:NO screenshots:NO recursive:YES];
    }

    [self.outlineView reloadData];
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
    self.tree = nil;
}

#pragma mark - NSOutlineView

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return self.tree.windows.count;
    } else if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        return node.subviews.count;
    } else {
        return 0;
    }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if (item == nil) {
        return (self.tree.windows)[index];
    } else if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        return node.subviews[index];
    } else {
        return nil;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        return node.subviews.count;
        //return [node.view isKindOfClass:[NSWindow class]];
    }
    return NO;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    // Every regular view uses bindings to the item. The "Date Cell" needs to have the date extracted from the fileURL
    //    if ([tableColumn.identifier isEqualToString:@"DateCell"]) {
    //        id dateValue;
    //        if ([[item fileURL] getResourceValue:&dateValue forKey:NSURLContentModificationDateKey error:nil]) {
    //            return dateValue;
    //        } else {
    //            return nil;
    //        }
    //    }
    return item;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return NO;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    
    if ([item isKindOfClass:[ORGUITreeNode class]]) {
        ORGUITreeNode *node = item;
        if ([node.view isKindOfClass:[NSWindow class]]) {
            // Everything is setup in bindings
            return [outlineView makeViewWithIdentifier:@"WindowCell" owner:self];
        } else {
            return [outlineView makeViewWithIdentifier:@"MainCell" owner:self];
        }
    }
    return nil;
}

@end
