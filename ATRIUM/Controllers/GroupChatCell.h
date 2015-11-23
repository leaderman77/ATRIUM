//
//  GroupChatCell.h
//  ATRIUM
//
//  Created by Admin on 11/12/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"

@interface GroupChatCell : BaseCell
@property (nonatomic, strong) UILabel *memberNameLabel;
@property (nonatomic, strong) UIButton *removeMemberButton;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
