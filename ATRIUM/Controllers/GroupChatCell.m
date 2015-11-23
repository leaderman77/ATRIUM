//
//  GroupChatCell.m
//  ATRIUM
//
//  Created by Admin on 11/12/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "GroupChatCell.h"

@implementation GroupChatCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    GroupChatCell *cell = [tableView dequeueReusableCellWithIdentifier:[[GroupChatCell class] description]];
    CGFloat left = 0;
    CGFloat top = 0;
    if (!cell) {
        cell = [[GroupChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[GroupChatCell class] description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
        cell.memberNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, 230, 30)];
        cell.memberNameLabel.textColor = rgbColorWithAlpha(0, 167, 227, 0.9);
        cell.memberNameLabel.font = FONT_SANSUMI(16);
        [cell.contentView addSubview:cell.memberNameLabel];
        
        cell.removeMemberButton = [[UIButton alloc]initWithFrame:CGRectMake(cell.memberNameLabel.width, 0, 20, 30)];
        cell.removeMemberButton.image = [UIImage imageNamed:@"Chat---Atrium---30.07_08.png"];
        [cell.contentView addSubview:cell.removeMemberButton];
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
