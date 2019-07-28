//
//  ORGUITreeWindowController.m
//  Organismo-mac
//
//  Created by Jon Gabilondo on 07/07/2019.
//  Copyright © 2019 organismo-mobile. All rights reserved.
//

#import "ORGUITreeWindowController.h"
#import "ORGUITree.h"
#import "ORGUITreeNode.h"
#import "ORGNSViewHierarchy.h"

@interface ORGUITreeWindowController ()

@property (weak) IBOutlet NSOutlineView *outlineView;
@property (strong) ORGUITree *tree;
@property (strong) NSArray<NSWindow*> *windows;

@end

@implementation ORGUITreeWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.windows = [ORGNSViewHierarchy appWindows:NSApp];
    NSLog(@"%@", self.windows);
    
    [self.outlineView reloadData];
}

#pragma mark - NSOutlineView

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return self.windows.count;
    } else if ([item isKindOfClass:[NSWindow class]]) {
        return 0;
    } else {
        return 0;
    }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if (item == nil) {
        return (self.windows)[index];
    } else {
        return nil;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return [item isKindOfClass:[NSWindow class]];
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
    return [item isKindOfClass:[NSWindow class]];
}
/*
- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    if ([item isKindOfClass:[ATDesktopFolderEntity class]]) {
        // Everything is setup in bindings
        return [outlineView makeViewWithIdentifier:@"GroupCell" owner:self];
    } else {
        NSView *result = [outlineView makeViewWithIdentifier:tableColumn.identifier owner:self];
        if ([result isKindOfClass:[ATTableCellView class]]) {
            ATTableCellView *cellView = (ATTableCellView *)result;
            // setup the color; we can't do this in bindings
            cellView.colorView.drawBorder = YES;
            cellView.colorView.backgroundColor = [item fillColor];
        }
        // Use a shared date formatter on the DateCell for better performance. Otherwise, it is encoded in every NSTextField
        if ([tableColumn.identifier isEqualToString:@"DateCell"]) {
            [(id)result setFormatter:self.sharedDateFormatter];
        }
        return result;
    }
    return nil;
}
*/

@end
