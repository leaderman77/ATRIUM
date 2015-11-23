//
//  ChatsListCell.h
//  ATRIUM
//
//  Created by Admin on 10/19/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"

@interface ChatsListCell : BaseCell
@property (nonatomic, strong) UIButton *imgButton;
@property (nonatomic, strong) UIImageView *announceImageView;

@property (nonatomic, strong) UILabel *announceNameLabel;
@property (nonatomic, strong) UILabel *announceDescLabel;

@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
