//
//  GroupDetailsCell.h
//  ATRIUM
//
//  Created by Admin on 11/11/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"

@interface GroupDetailsCell : BaseCell
@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
