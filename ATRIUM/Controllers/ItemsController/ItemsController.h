//
// Created by Sanch0 on 12/1/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseController.h"

@class ItemsController;

@protocol ItemsControllerDelegate <NSObject>

@optional
- (void)itemsController:(ItemsController *)controller didSelectItem:(id)item atIndex:(NSInteger)index;

- (UITableViewCell *)itemsController:(ItemsController *)controller cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)headerViewForItemsController:(ItemsController *)itemsController;

- (UIView *)footerViewForItemsController:(ItemsController *)itemsController;

- (id)itemsController:(ItemsController *)controller textForRowAtIndex:(NSInteger)index;

- (void)itemsControllerDidCancelClicked:(ItemsController *)controller;

- (void)itemsControllerDidSaveClicked:(ItemsController *)controller;

@end


@interface ItemsController : BaseController

//@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id <ItemsControllerDelegate> controllerDelegate;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) CGFloat tableViewRowHeight;

@property (nonatomic, strong) NSNumber *selectedIndex;
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexSet;
@property (nonatomic, weak) id senderControl;

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) BOOL withNavigationItem;

- (void)configureWithHeaderTitle:(NSString *)headerTitle;

- (void)reloadData;

@end