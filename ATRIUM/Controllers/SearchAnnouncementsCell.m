//
//  SearchAnnouncementsCell.m
//  ATRIUM
//
//  Created by Admin on 11/16/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "SearchAnnouncementsCell.h"

@implementation SearchAnnouncementsCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    SearchAnnouncementsCell *cell = [tableView dequeueReusableCellWithIdentifier:[[SearchAnnouncementsCell class] description]];
    CGFloat left = 0;
    CGFloat top = 3;
    if (!cell) {
        cell = [[SearchAnnouncementsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[SearchAnnouncementsCell class] description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.contentView.backgroundColor = rgbColor(22, 168, 235);
        cell.announcementNameBtn = [[UIButton alloc]initWithFrame:CGRectMake(left, top, 170, 30)];
//        cell.announcementNameBtn.layer.borderWidth = 2;
//        [cell.announcementNameBtn addBottomBorderWithHeight:0.1 andColor:[UIColor whiteColor]];
        cell.announcementNameBtn.backgroundColor = [UIColor clearColor];
        //        [cell.imgButton addTarget:self action:@selector(buttonClicked:withItem:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.contentView addSubview:cell.arrowButton];
        
        cell.announceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, cell.announcementNameBtn.width, cell.announcementNameBtn.height)];
        //        cell.announceDescLabel.layer.borderWidth = 1;
        cell.announceNameLabel.backgroundColor = [UIColor clearColor];
        cell.announceNameLabel.textColor = [UIColor whiteColor];
        [cell.announceNameLabel addBottomBorderWithHeight:0.5 color:[UIColor whiteColor] leftOffset:0 rightOffset:10 andBottomOffset:0];
        cell.announceNameLabel.font = FONT_SANSUMI_BOLD(14);
        [cell.announcementNameBtn addSubview:cell.announceNameLabel];
        
        [cell.contentView addSubview:cell.announcementNameBtn];
        
        cell.announceDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + cell.announcementNameBtn.width + 10, top, 110, 30)];
//        cell.announceDescLabel.layer.borderWidth = 1;
        cell.announceDescLabel.backgroundColor = [UIColor clearColor];
        cell.announceDescLabel.textColor = [UIColor whiteColor];
        cell.announceDescLabel.font = FONT_SANSUMI(12);
        [cell.contentView addSubview:cell.announceDescLabel];
        

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
