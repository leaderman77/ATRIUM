//
//  UserChatCell.m
//  ATRIUM
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "UserChatCell.h"

@implementation UserChatCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setMessage:(Message *)message
{
    _message = message;
    [self buildCell];
    message.heigh = self.height;
}
- (void)buildCell {
    CGFloat left = 10;
    CGFloat top = 0;
    if (_message.sender == MessageSenderMyself) {
        self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(25 *left, 5, 40, 40)];
        self.avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imgButton.width, self.imgButton.height)];
        [self.avatarImageView setImage:[UIImage imageNamed:@"rained-red-rose-flowers-34592998-960-639.jpg"]];
        //    imageView.layer.borderWidth = 1;
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarImageView.left = 0.5 * (self.avatarImageView.width - self.avatarImageView.width);
        self.avatarImageView.top = 0.5 * (self.avatarImageView.height - self.avatarImageView.height);
        //        cell.announceImageView.layer.borderWidth = 1.0f;
        //        cell.announceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.avatarImageView.layer.cornerRadius = 0.5 * self.avatarImageView.width;
        self.avatarImageView.layer.masksToBounds = YES;
        [self.imgButton addSubview:self.avatarImageView];
        
        //timer label show
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(19 *left, 0, 52, 14)];
        //    self.timeLabel.layer.borderWidth = 2;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        _timeLabel.userInteractionEnabled = NO;
        //    _timeLabel.backgroundColor = [UIColor yellowColor];
        _timeLabel.alpha = 0.7;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        //Set Text to Label
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.timeStyle = NSDateFormatterShortStyle;
        df.dateStyle = NSDateFormatterNoStyle;
        df.doesRelativeDateFormatting = YES;
        self.timeLabel.text = [df stringFromDate:_message.date];
        [self.contentView addSubview:_timeLabel];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(left + self.senderButton.width / 2, top + 10, 200, 80)];
        //    _textView.layer.borderWidth = 2;
        self.textView.layer.cornerRadius = 5.0;
        self.textView.userInteractionEnabled = NO;
        self.textView.layer.masksToBounds = YES;
        self.textView.text = self.message.text;
        self.textView.font = FONT_SANSUMI(15);
        self.textView.textColor = rgbColor(198, 218, 232);           //colorWithRGB(25, 94, 180);
        
        [_textView sizeToFit];
        
        CGFloat textView_x;
        CGFloat textView_y;
        CGFloat textView_w = _textView.frame.size.width;
        CGFloat textView_h = _textView.frame.size.height + 5;
        
        UIViewAutoresizing autoresizing;
        
        self.textView.backgroundColor = rgbColor(2, 173, 231);
        
        textView_x = self.contentView.frame.size.width - textView_w - 70;
        textView_y += 20;
        autoresizing = UIViewAutoresizingFlexibleLeftMargin;
        textView_x -= [self isSingleLineCase]?65.0:0.0;
        textView_x -= [self isStatusFailedCase]?([self fail_delta]-15):0.0;
        
        _textView.autoresizingMask = autoresizing;
        _textView.frame = CGRectMake(20, textView_y, 250, textView_h);
        if ([self.heightDelegate respondsToSelector:@selector(rowHeight:)]) {
            [self.heightDelegate rowHeight:textView_h];
        }
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.imgButton];
        [self.contentView addSubview:self.senderButton];

    } else {
        self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(left, 10, 40, 40)];
        self.avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imgButton.width, self.imgButton.height)];
        [self.avatarImageView setImage:[UIImage imageNamed:@"rained-red-rose-flowers-34592998-960-639.jpg"]];
        //    imageView.layer.borderWidth = 1;
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarImageView.left = 0.5 * (self.avatarImageView.width - self.avatarImageView.width);
        self.avatarImageView.top = 0.5 * (self.avatarImageView.height - self.avatarImageView.height);
        //        cell.announceImageView.layer.borderWidth = 1.0f;
        //        cell.announceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.avatarImageView.layer.cornerRadius = 0.5 * self.avatarImageView.width;
        self.avatarImageView.layer.masksToBounds = YES;
        [self.imgButton addSubview:self.avatarImageView];
        
        //timer label show
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(4 *left, 0, 52, 14)];
        //    self.timeLabel.layer.borderWidth = 2;
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        _timeLabel.userInteractionEnabled = NO;
        //    _timeLabel.backgroundColor = [UIColor yellowColor];
        _timeLabel.alpha = 0.7;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        
        //Set Text to Label
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.timeStyle = NSDateFormatterShortStyle;
        df.dateStyle = NSDateFormatterNoStyle;
        df.doesRelativeDateFormatting = YES;
        self.timeLabel.text = [df stringFromDate:_message.date];
        [self.contentView addSubview:_timeLabel];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(left + self.senderButton.width / 2, top + 10, 200, 80)];
        //    _textView.layer.borderWidth = 2;
        self.textView.layer.cornerRadius = 5.0;
        self.textView.userInteractionEnabled = NO;
        self.textView.layer.masksToBounds = YES;
        self.textView.text = self.message.text;
        self.textView.font = FONT_SANSUMI(15);
        self.textView.textColor = rgbColor(198, 218, 232);           //colorWithRGB(25, 94, 180);
        
        [_textView sizeToFit];
        
        CGFloat textView_x;
        CGFloat textView_y;
        CGFloat textView_w = _textView.frame.size.width;
        CGFloat textView_h = _textView.frame.size.height + 5;
        
        UIViewAutoresizing autoresizing;
        
        self.textView.backgroundColor = rgbColor(243, 243, 243);
        
        textView_x = 20;
        textView_y = -1;
        autoresizing = UIViewAutoresizingFlexibleRightMargin;
        
        _textView.autoresizingMask = autoresizing;
        _textView.frame = CGRectMake(40, textView_y + 15, 250, textView_h);
        if ([self.heightDelegate respondsToSelector:@selector(rowHeight:)]) {
            [self.heightDelegate rowHeight:textView_h];
        }
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.imgButton];
        [self.contentView addSubview:self.senderButton];
    }
    
    self.firstUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 *left + self.imgButton.width / 2, top + 10, 250, 80)];
    self.firstUserLabel.layer.cornerRadius = 0.5;
    self.firstUserLabel.layer.masksToBounds = YES;
    self.firstUserLabel.text = self.message.text;
    self.firstUserLabel.backgroundColor = rgbColor(228, 239, 243);
    self.firstUserLabel.font = FONT_SANSUMI_BOLD(16);
    self.firstUserLabel.textColor = rgbColor(0, 160, 227);           //colorWithRGB(25, 94, 180);
//    [self.contentView addSubview:self.firstUserLabel];
//    [self.contentView addSubview:self.imgButton];
    
//    self.senderButton = [[UIButton alloc]initWithFrame:CGRectMake(25 *left, 0, 40, 40)];
//    self.avatar2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imgButton.width, self.imgButton.height)];
//    [self.avatar2ImageView setImage:[UIImage imageNamed:@"Scofield.png"]];
//    //    imageView.layer.borderWidth = 1;
//    self.avatar2ImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.avatar2ImageView.left = 0.5 * (self.avatar2ImageView.width - self.avatar2ImageView.width);
//    self.avatar2ImageView.top = 0.5 * (self.avatar2ImageView.height - self.avatar2ImageView.height);
//    //        cell.announceImageView.layer.borderWidth = 1.0f;
//    //        cell.announceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.avatar2ImageView.layer.cornerRadius = 0.5 * self.avatar2ImageView.width;
//    self.avatar2ImageView.layer.masksToBounds = YES;
//    [self.senderButton addSubview:self.avatar2ImageView];
    
//    self.contentView.layer.borderWidth = 2;
  
    
    

    
    


}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    
    UserChatCell *cell = [tableView dequeueReusableCellWithIdentifier:[[UserChatCell class] description]];
    CGFloat left = 10;
    CGFloat top = 0;
    if (!cell) {
        cell.contentView.layer.borderWidth = 2;
        cell = [[UserChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[UserChatCell class] description]];
        cell.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(2 *left, 0, 60, 60)];
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
        
        cell.firstUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 *left + cell.imgButton.width / 2, top + 10, 300, 80)];
        cell.firstUserLabel.layer.cornerRadius = 0.5;
        cell.firstUserLabel.layer.masksToBounds = YES;
        cell.firstUserLabel.text = @"MEssage";
        cell.firstUserLabel.backgroundColor = rgbColor(228, 239, 243);
        cell.firstUserLabel.font = FONT_SANSUMI_BOLD(16);
        cell.firstUserLabel.textColor = rgbColor(0, 160, 227);           //colorWithRGB(25, 94, 180);
        [cell.contentView addSubview:cell.firstUserLabel];
        [cell.contentView addSubview:cell.imgButton];
        
        cell.senderButton = [[UIButton alloc]initWithFrame:CGRectMake(10 *left, 0, 60, 60)];
        cell.avatar2ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.imgButton.width, cell.imgButton.height)];
        [cell.avatar2ImageView setImage:[UIImage imageNamed:@"rained-red-rose-flowers-34592998-960-639.jpg"]];
        //    imageView.layer.borderWidth = 1;
        cell.avatar2ImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.avatar2ImageView.left = 0.5 * (cell.avatar2ImageView.width - cell.avatar2ImageView.width);
        cell.avatar2ImageView.top = 0.5 * (cell.avatar2ImageView.height - cell.avatar2ImageView.height);
        //        cell.announceImageView.layer.borderWidth = 1.0f;
        //        cell.announceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.avatar2ImageView.layer.cornerRadius = 0.5 * cell.avatar2ImageView.width;
        cell.avatar2ImageView.layer.masksToBounds = YES;
        [cell.senderButton addSubview:cell.avatar2ImageView];
        [cell.contentView addSubview:cell.senderButton];
        
//        cell.secondUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 *left + cell.senderButton.width / 2, top + 10, 300, 80)];
//        cell.secondUserLabel.layer.cornerRadius = 0.5;
//        cell.secondUserLabel.layer.masksToBounds = YES;
//        cell.secondUserLabel.backgroundColor = rgbColor(2, 173, 231);
//        cell.secondUserLabel.font = FONT_SANSUMI_BOLD(16);
//        cell.secondUserLabel.textColor = rgbColor(198, 218, 232);           //colorWithRGB(25, 94, 180);
//        [cell.contentView addSubview:cell.secondUserLabel];
        
        
    }
    return cell;
}
-(BOOL)isSingleLineCase
{
    CGFloat delta_x = _message.sender == MessageSenderMyself?65.0:44.0;
    
    CGFloat textView_height = _textView.frame.size.height;
    CGFloat textView_width = _textView.frame.size.width;
    CGFloat view_width = self.contentView.frame.size.width;
    
    //Single Line Case
    return (textView_height <= 45 && textView_width + delta_x <= 0.8*view_width)?YES:NO;
}
-(BOOL)isStatusFailedCase
{
    return self.message.status == MessageStatusFailed;
}
-(NSInteger)fail_delta
{
    return 60;
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
