//
//  SearchViewForPopover.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/15/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CustomSearchBar, TPKeyboardAvoidingTableView;

@interface SearchViewForPopover : UIView
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) CustomSearchBar *customSearchBar;
@property (nonatomic, assign) BOOL isPatientPicker;

- (void)setDisplaySelectedItems:(NSArray *)selectedItems ;
- (NSArray *)getSelectedItem;
@end
