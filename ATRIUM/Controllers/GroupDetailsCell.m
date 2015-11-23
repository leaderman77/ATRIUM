//
//  GroupDetailsCell.m
//  ATRIUM
//
//  Created by Admin on 11/11/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "GroupDetailsCell.h"

@implementation GroupDetailsCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    GroupDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:[[GroupDetailsCell class] description]];
    CGFloat left = 15;
    CGFloat top = 0;
    if (!cell) {
        cell = [[GroupDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[GroupDetailsCell class] description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
        cell.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, 280, 20)];
        cell.dateLabel.font = FONT_SANSUMI(13);
        cell.dateLabel.textColor = rgbColorWithAlpha(37, 66, 97, 0.7);         //colorWithRGB(25, 94, 180);
        [cell.contentView addSubview:cell.dateLabel];
        
        cell.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top + 20, 300, 30)];
        cell.detailsLabel.textColor = rgbColor(37, 66, 97);
        cell.detailsLabel.font = FONT_SANSUMI(18);
        [cell.contentView addSubview:cell.detailsLabel];
    }
    return cell;
}
- (IBAction)buttonClicked:(UIButton *)sender withItem:(id)item {
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
