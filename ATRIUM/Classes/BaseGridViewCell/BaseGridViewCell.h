//
// Created by Sanch0 on 12/12/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFGridViewCell.h"

@class BaseGridViewCell;
@class PFGridView;

@protocol BaseGridViewCellDelegate <NSObject>

@optional
- (void)gridViewCell:(BaseGridViewCell *)gridViewCell didAction:(NSInteger)actionType withValue:(id)value;

@end

@interface BaseGridViewCell : PFGridViewCell

@property (nonatomic, strong) id tagObject;
@property (nonatomic, weak) id<BaseGridViewCellDelegate> baseGridViewCellDelegate;

+ (instancetype)gridViewCellForGridView:(PFGridView *)gridView withItem:(id)item;

@end