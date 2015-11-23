//
// Created by Sanch0 on 4/29/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PopupItemsView;
@class BaseCell;

@protocol PopupItemsViewDelegate <NSObject>

@optional
- (id)textForPopupItemsView:(PopupItemsView *)popupItemsView withItem:(id)item atIndex:(NSInteger)index;

- (BaseCell *)cellForPopupItemsView:(PopupItemsView *)popupItemsView withItem:(id)item atIndex:(NSInteger)index;

- (NSPredicate *)predicatePopupItemsView:(PopupItemsView *)popupItemsView withSearchKey:(NSString *)searchKey;

@end

@interface PopupItemsView : UIControl

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) id <PopupItemsViewDelegate> delegate;
//@property (nonatomic, strong) NSPredicate *searchPredicate;
//@property (nonatomic, strong) NSPredicate *predicateString;


@property (nonatomic, copy) void(^selectItemAndCloseBlock)(PopupItemsView *popupItemsView, id selectedItem, NSInteger selectedIndex);

- (void)showView;

- (void)closeView;
@end