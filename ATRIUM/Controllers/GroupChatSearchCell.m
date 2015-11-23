//
//  GroupChatSearchCell.m
//  ATRIUM
//
//  Created by Admin on 11/12/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "GroupChatSearchCell.h"

@implementation GroupChatSearchCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    GroupChatSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:[[GroupChatSearchCell class] description]];
    CGFloat left = 0;
    CGFloat top = 0;
    
    if (!cell) {
        cell = [[GroupChatSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[GroupChatSearchCell class] description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;

        cell.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(left, top + 5, 40, 40)];
        cell.avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.imgButton.width, cell.imgButton.height)];
        [cell.avatarImageView setImage:[UIImage imageNamed:@"rained-red-rose-flowers-34592998-960-639.jpg"]];
        //    imageView.layer.borderWidth = 1;
        cell.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.avatarImageView.left = 0.5 * (cell.avatarImageView.width - cell.avatarImageView.width);
        cell.avatarImageView.top = 0.5 * (cell.avatarImageView.height - cell.avatarImageView.height);
        //        cell.announceImageView.layer.borderWidth = 1.0f;
        //        cell.announceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.avatarImageView.layer.cornerRadius = 0.5 * cell.avatarImageView.width;
        cell.avatarImageView.layer.masksToBounds = YES;
        [cell.imgButton addSubview:cell.avatarImageView];
        [cell.contentView addSubview:cell.imgButton];
        
        cell.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + cell.imgButton.width + 5, top, 190, 30)];
//        cell.userNameLabel.layer.borderWidth = 1;
        cell.userNameLabel.textColor = rgbColorWithAlpha(0, 167, 227, 0.9);
        cell.userNameLabel.font = FONT_SANSUMI(16);
        [cell.contentView addSubview:cell.userNameLabel];
        
        cell.positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + cell.imgButton.width + 10, top + cell.userNameLabel.height, 200, 12)];
        cell.positionLabel.textColor = rgbColorWithAlpha(0, 167, 227, 0.9);
        cell.positionLabel.font = FONT_SANSUMI(12);
        [cell.contentView addSubview:cell.positionLabel];
        
        cell.addMemberButton = [[UIButton alloc]initWithFrame:CGRectMake(left + cell.positionLabel.width + cell.imgButton.width - 5, top + 5, 30, 30)];
        cell.addMemberButton.image = [UIImage imageNamed:@"navig_bar_add.png"];
        [cell.contentView addSubview:cell.addMemberButton];
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
