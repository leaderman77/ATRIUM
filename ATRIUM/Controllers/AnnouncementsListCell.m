//
//  AnnouncementsListCell.m
//  ATRIUM
//
//  Created by Admin on 10/19/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AnnouncementsListCell.h"

@implementation AnnouncementsListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    AnnouncementsListCell *cell = [tableView dequeueReusableCellWithIdentifier:[[AnnouncementsListCell class] description]];
    CGFloat left = 10;
    CGFloat top = 0;
    if (!cell) {
        cell = [[AnnouncementsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[AnnouncementsListCell class] description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UIImageView *next = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_forward.png"]];
        cell.accessoryView = next;
        cell.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(left, 10, 50, 50)];
        cell.announceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.imgButton.width, cell.imgButton.height)];
        [cell.announceImageView setImage:[UIImage imageNamed:@"rained-red-rose-flowers-34592998-960-639.jpg"]];
        //    imageView.layer.borderWidth = 1;
        cell.announceImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.announceImageView.left = 0.5 * (cell.announceImageView.width - cell.announceImageView.width);
        cell.announceImageView.top = 0.5 * (cell.announceImageView.height - cell.announceImageView.height);
//        cell.announceImageView.layer.borderWidth = 1.0f;
//        cell.announceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.announceImageView.layer.cornerRadius = 0.5 * cell.announceImageView.width;
        cell.announceImageView.layer.masksToBounds = YES;
        [cell.imgButton addSubview:cell.announceImageView];

        [cell.imgButton addTarget:self action:@selector(buttonClicked:withItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cell.imgButton];
        
        cell.announceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * left + cell.imgButton.width, top + 5, 250, 35)];
//        cell.announceNameLabel.layer.borderWidth= 1;
        cell.announceNameLabel.numberOfLines = 0.f;
        cell.announceNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.announceNameLabel.textAlignment = NSTextAlignmentLeft;
        cell.announceNameLabel.font = FONT_SANSUMI_BOLD(12);
        cell.announceNameLabel.textColor = rgbColor(0, 160, 227);           //colorWithRGB(25, 94, 180);
        [cell.contentView addSubview:cell.announceNameLabel];
        
        cell.announceDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.imgButton.width + 2 *left, cell.announceNameLabel.height + 5, 300, 20)];
        cell.announceDescLabel.textColor = rgbColorWithAlpha(0, 167, 227, 0.9);
        cell.announceDescLabel.font = FONT_SANSUMI(12);
        [cell.contentView addSubview:cell.announceDescLabel];
        
        cell.arrowButton = [[UIButton alloc]initWithFrame:CGRectMake(left + 270, top + 20, 30, 30)];
//        cell.arrowButton.layer.borderWidth = 2;
        cell.arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.imgButton.width, cell.imgButton.height)];
//        cell.arrowImageView.layer.borderWidth = 2;
        [cell.arrowImageView setImage:[UIImage imageNamed:@"arrow_forward.png"]];
        cell.arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.arrowButton addSubview:cell.arrowImageView];
//        [cell.imgButton addTarget:self action:@selector(buttonClicked:withItem:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:cell.arrowButton];
    }
    return cell;
}
- (IBAction)buttonClicked:(UIButton *)sender withItem:(id)item {

    
}

@end
