//
//  SearchGroupsCell.m
//  ATRIUM
//
//  Created by Admin on 11/17/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "SearchGroupsCell.h"

@implementation SearchGroupsCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    SearchGroupsCell *cell = [tableView dequeueReusableCellWithIdentifier:[[SearchGroupsCell class] description]];
    CGFloat left = 5;
    CGFloat top = 3;
    if (!cell) {
        cell = [[SearchGroupsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[SearchGroupsCell class] description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.contentView.backgroundColor = rgbColor(22, 168, 235);
        
        cell.groupName = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, 180, 30)];
        //        cell.announceDescLabel.layer.borderWidth = 1;
        cell.groupName.backgroundColor = [UIColor clearColor];
        cell.groupName.textColor = rgbColor(37, 66, 97);
        [cell.groupName addBottomBorderWithHeight:0.5 color:rgbColor(37, 66, 97) leftOffset:0 rightOffset:10 andBottomOffset:0];
        cell.groupName.font = FONT_SANSUMI_BOLD(14);
        [cell.contentView addSubview:cell.groupName];
        
        cell.groupFollowers = [[UILabel alloc] initWithFrame:CGRectMake(left + cell.groupName.width + 10, top, 140, 30)];
        //        cell.announceDescLabel.layer.borderWidth = 1;
        cell.groupFollowers.backgroundColor = [UIColor clearColor];
        cell.groupFollowers.textColor = rgbColor(37, 66, 97);
        cell.groupFollowers.font = FONT_SANSUMI(12);
        [cell.contentView addSubview:cell.groupFollowers];
        
        
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
