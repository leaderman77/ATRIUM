//
//  SearchAnnouncementsCell.h
//  ATRIUM
//
//  Created by Admin on 11/16/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"

@interface SearchAnnouncementsCell : BaseCell
@property (nonatomic, strong) UILabel *announceNameLabel;
@property (nonatomic, strong) UILabel *announceDescLabel;
@property (nonatomic, strong) UIButton *announcementNameBtn;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
