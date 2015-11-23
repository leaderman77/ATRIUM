//
//  SearchGroupsCell.h
//  ATRIUM
//
//  Created by Admin on 11/17/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"

@interface SearchGroupsCell : BaseCell
@property (nonatomic, strong) UILabel *groupName;
@property (nonatomic, strong) UILabel *groupFollowers;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
