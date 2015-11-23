//
//  GroupChatSearchCell.h
//  ATRIUM
//
//  Created by Admin on 11/12/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"

@interface GroupChatSearchCell : BaseCell
@property (nonatomic, strong) UIButton *imgButton;
@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *positionLabel;

@property (nonatomic, strong) UIButton *addMemberButton;
@property (nonatomic, strong) UIImageView *addImageView;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
