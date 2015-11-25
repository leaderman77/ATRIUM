//
//  SearchInChatCell.m
//  ATRIUM
//
//  Created by Admin on 11/17/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "SearchInChatCell.h"

@implementation SearchInChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    SearchInChatCell *cell = [tableView dequeueReusableCellWithIdentifier:[[SearchInChatCell class] description]];
    CGFloat left = 5;
    CGFloat top = 3;
    if (!cell) {
        cell = [[SearchInChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[SearchInChatCell class] description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.contentView.backgroundColor = rgbColor(22, 168, 235);
        
        cell.userName = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, 190, 30)];
        //        cell.announceDescLabel.layer.borderWidth = 1;
        cell.userName.backgroundColor = [UIColor clearColor];
        cell.userName.textColor = [UIColor whiteColor];
        [cell.userName addBottomBorderWithHeight:0.5 color:[UIColor whiteColor] leftOffset:0 rightOffset:10 andBottomOffset:0];
        cell.userName.font = FONT_SANSUMI_BOLD(14);
        [cell.contentView addSubview:cell.userName];
        
        cell.userPosition = [[UILabel alloc] initWithFrame:CGRectMake(left + cell.userName.width, top, 105, 30)];
//        cell.userPosition.layer.borderWidth = 1;
        cell.userPosition.backgroundColor = [UIColor clearColor];
        cell.userPosition.textColor = [UIColor whiteColor];
        cell.userPosition.textAlignment = NSTextAlignmentRight;
        cell.userPosition.font = FONT_SANSUMI(10);
        [cell.contentView addSubview:cell.userPosition];
        
        
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
