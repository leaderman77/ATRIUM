//
// Created by Sanch0 on 1/17/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemsController.h"

@class ItemsPopover;

typedef enum {
    kWithNavigationBarPopoverType,
    kSingleChoicePopoverType,
    kMultipleChoicePopoverType,
    kRequiredSingleChoicePopoverType,
    kWithCustomContentView,
    kWithCustomContentViewWithNavigationButtons,
    kOnlyViewPopoverType,
} ItemsPopoverType;

@protocol ItemsPopoverDelegate <NSObject>

- (void)itemsPopover:(ItemsPopover *)popover didSaveClickedWithItem:(id)item atIndex:(NSInteger)index;

@optional
- (id)itemsPopover:(ItemsPopover *)popover textForRowAtIndex:(NSInteger)index;

- (UITableViewCell *)itemsPopoper:(ItemsPopover *)popover cellForRowAtIndex:(NSInteger)index;

- (UIButton *)titleViewForNavigationBar;

@end


@interface ItemsPopover : NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) CGSize popoverContentSize;
@property (nonatomic, weak) id <ItemsPopoverDelegate> delegate;
@property (nonatomic, strong) NSNumber *selectedIndex;
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexSet;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) id senderControl;
@property (nonatomic, assign) ItemsPopoverType type;
@property (nonatomic, assign) NSInteger visibleItemsCount;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIView *titleNavigationBarView;
@property (nonatomic, strong) id tagObject;
@property (nonatomic, strong, readonly) UIView *customContentView;


- (id)initWithType:(ItemsPopoverType)type;
- (id)initWithTitle:(NSString *)title withCustomView:(UIView *)customView withNavigationBarButtons:(BOOL)withButtons;

- (id)initWithTitle:(NSString *)title withItems:(NSArray *)items;

- (id)initWithTitle:(NSString *)title withItems:(NSArray *)items withType:(ItemsPopoverType)type;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

- (void)dismissPopover;

@end