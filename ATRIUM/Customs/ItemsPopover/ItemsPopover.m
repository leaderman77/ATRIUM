//
// Created by Sanch0 on 1/17/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ItemsPopover.h"

#define TABLE_VIEW_ROW_HEIGHT 44.f

@interface ItemsPopover () <UIPopoverPresentationControllerDelegate, ItemsControllerDelegate>
@property (nonatomic, strong) ItemsController *itemsController;
@property (nonatomic, strong) UIPopoverPresentationController *popoverPresentationController;

@end

@implementation ItemsPopover {

}

- (id)init {
    self = [super init];
    if (self) {
        [self createControls];
    }

    return self;
}

- (id)initWithType:(ItemsPopoverType)type {
    self = [super init];
    if (self) {
        _type = type;
        [self createControls];
    }

    return self;
}

- (id)initWithTitle:(NSString *)title withCustomView:(UIView *)customView withNavigationBarButtons:(BOOL)withButtons {
    self = [super init];
    if (self) {
        _customContentView = customView;
        self.title = title;
        if(withButtons) {
            _type = kWithCustomContentViewWithNavigationButtons;
        } else {
            _type = kWithCustomContentView;
        }
        [self createControls];
    }
    return self;

}


- (id)initWithTitle:(NSString *)title withItems:(NSArray *)items withType:(ItemsPopoverType)type {
    self = [super init];
    if (self) {
        self.title = title;
        self.items = items;
        _type = type;
        [self createControls];
    }

    return self;
}


- (id)initWithTitle:(NSString *)title withItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.title = title;
        self.items = items;
        [self createControls];
    }

    return self;
}

- (void)createControls {
    self.itemsController = [[ItemsController alloc] init];
    self.itemsController.withNavigationItem = YES;
    self.itemsController.items = [NSMutableArray arrayWithArray:self.items ? self.items : @[]];
    self.itemsController.controllerDelegate = self;
    self.itemsController.tableViewRowHeight = TABLE_VIEW_ROW_HEIGHT;

    if (self.type == kWithNavigationBarPopoverType || self.type == kMultipleChoicePopoverType ||  self.type == kWithCustomContentViewWithNavigationButtons) {
        self.itemsController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:TRANSLATE(@"Cancel")
                                                                                                 style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
        self.itemsController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:TRANSLATE(@"Save")
                                                                                                  style:UIBarButtonItemStyleBordered target:self action:@selector(saveClicked:)];
        self.itemsController.withNavigationItem = YES;
    }


    self.itemsController.title = self.title;

    CustomNavigationController *contentController = [[CustomNavigationController alloc] initWithRootViewController:self.itemsController];
    
    self.popoverPresentationController = [[UIPopoverPresentationController alloc] initWithPresentedViewController:contentController presentingViewController:contentController];
    if(self.type == kWithCustomContentView || self.type == kWithCustomContentViewWithNavigationButtons) {
//        self.popoverPresentationController. popoverContentSize = CGSizeMake(self.customContentView.width,  self.customContentView.height + 44);
        self.itemsController.controllerDelegate = nil;
        [self.itemsController viewDidLoad];
        self.customContentView.left = self.customContentView.top = 0;
        self.customContentView.top = 44;
        [self.itemsController.view addSubview:self.customContentView];
    } else if(self.type == kOnlyViewPopoverType) {
//        self.popoverPresentationController.popoverContentSize = CGSizeMake(320, TABLE_VIEW_ROW_HEIGHT * ((self.items.count < 10)? self.items.count + 1 : 10));
    } else {
//        self.popoverPresentationController.popoverContentSize = CGSizeMake(320, TABLE_VIEW_ROW_HEIGHT * 10);
    }
    self.popoverPresentationController.delegate = self;

}

- (void)setTitleNavigationBarView:(UIView *)titleNavigationBarView {
    _titleNavigationBarView = titleNavigationBarView;
    self.itemsController.titleView = titleNavigationBarView;
}


- (void)setType:(ItemsPopoverType)type {
    _type = type;
    if (self.type == kWithNavigationBarPopoverType || self.type == kMultipleChoicePopoverType) {
        self.itemsController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:TRANSLATE(@"Cancel")
                                                                                                 style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
        self.itemsController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:TRANSLATE(@"Save")
                                                                                                  style:UIBarButtonItemStyleBordered target:self action:@selector(saveClicked:)];
    } else {
        self.itemsController.navigationItem.leftBarButtonItem = nil;
        self.itemsController.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.itemsController.title = _title;
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = self.itemsController.tableView;
    }
    return _tableView;
}

- (void)setPopoverContentSize:(CGSize)popoverContentSize {
    _popoverContentSize = popoverContentSize;
//    self.popoverController.popoverContentSize = _popoverContentSize;
//    if (SYSTEM_VERSION >= 8.0) {
//        self.popoverController.contentViewController.preferredContentSize = _popoverContentSize;
//    } else {
//        self.popoverController.contentViewController.contentSizeForViewInPopover = _popoverContentSize;
//    }
//    self.itemsController.contentSize = _popoverContentSize;

}

- (void)setVisibleItemsCount:(NSInteger)visibleItemsCount {
    _visibleItemsCount = visibleItemsCount;
//    self.popoverContentSize = CGSizeMake(320, TABLE_VIEW_ROW_HEIGHT * _visibleItemsCount + 10 + kPortraitNavbarHeight);
    CGFloat height = (SYSTEM_VERSION > 8.0) ? 0 : kPortraitNavbarHeight;
    self.popoverContentSize = CGSizeMake(320, TABLE_VIEW_ROW_HEIGHT * _visibleItemsCount + 10 + height);

}

- (void)setItems:(NSArray *)items {
    _items = items;
    self.itemsController.items = [NSMutableArray arrayWithArray:_items ? _items : @[]];
    self.visibleItemsCount = _items.count > 10 ? 10 : _items.count;
    [self.itemsController reloadData];
}

- (void)setSelectedIndex:(NSNumber *)selectedIndex {
    _selectedIndex = selectedIndex;
    self.itemsController.selectedIndex = _selectedIndex;
}

- (void)setSelectedIndexSet:(NSMutableIndexSet *)selectedIndexSet {
    _selectedIndexSet = selectedIndexSet;
    self.itemsController.selectedIndexSet = _selectedIndexSet;
}


#pragma mark - Class methods Implementation

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
    [self.popoverPresentationController presentingViewController];
//    [self.popoverPresentationController presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
}

- (void)dismissPopover {
//     [self.popoverController dismissPopoverAnimated:YES];
}

- (void)cancelClicked:(id)sender {
    self.selectedIndex = nil;
//    [self.popoverController dismissPopoverAnimated:YES];
}

- (void)saveClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(itemsPopover:didSaveClickedWithItem:atIndex:)]) {
        NSInteger selectedIndex = self.selectedIndex ? self.selectedIndex.integerValue : -1;
        id selectedItem = selectedIndex >= 0 && self.items.count > 0 ? self.items[selectedIndex] : nil;
        [self.delegate itemsPopover:self didSaveClickedWithItem:selectedItem atIndex:selectedIndex];
    }
    [self cancelClicked:nil];
}

#pragma mark - ItemsControllerDelegate

- (UITableViewCell *)itemsController:(ItemsController *)controller cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    self.tableView = controller.tableView;
    if ([self.delegate respondsToSelector:@selector(itemsPopoper:cellForRowAtIndex:)]) {
        cell = [self.delegate itemsPopoper:self cellForRowAtIndex:indexPath.row];
    }
    return cell;
}

- (void)itemsController:(ItemsController *)controller didSelectItem:(id)item atIndex:(NSInteger)index {
    if(self.type == kOnlyViewPopoverType) {
        return;
    }
//    [_selectedIndexSet addIndex:index];
//    controller.selectedIndex = self.selectedIndex;
    if([_selectedIndexSet containsIndex:index])  {
//        _selectedIndex = nil;
        [_selectedIndexSet removeIndex:index];
    } else {
        self.selectedIndex = @(index);
        [_selectedIndexSet addIndex:index];
    }
    [controller reloadData];
    if (self.type == kSingleChoicePopoverType || self.type == kRequiredSingleChoicePopoverType) {
        [self saveClicked:nil];
    }
}

- (id)itemsController:(ItemsController *)controller textForRowAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(itemsPopover:textForRowAtIndex:)]) {
        return [self.delegate itemsPopover:self textForRowAtIndex:index];
    } else if ([self.items[index] respondsToSelector:@selector(name)]) {
        return [self.items[index] name];
    }

    return self.items[index];
}

#pragma mark UIPopover delegate 

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController  {
    if(self.type == kRequiredSingleChoicePopoverType) {
        return self.selectedIndex != nil;
    }
    return YES;
}

@end