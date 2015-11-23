//
//  SearchInChatCell.h
//  ATRIUM
//
//  Created by Admin on 11/17/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"

@interface SearchInChatCell : BaseCell
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *userPosition;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
