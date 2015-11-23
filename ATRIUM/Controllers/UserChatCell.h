//
//  UserChatCell.h
//  ATRIUM
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"
#import "Message.h"

@protocol UserChatCellDelegate <NSObject>

- (void)rowHeight:(CGFloat)height;
@end

@interface UserChatCell : BaseCell
@property (strong, nonatomic) Message *message;

@property (nonatomic, strong) UIButton *imgButton;
@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *firstUserLabel;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UITextView *textView2;

@property (nonatomic, strong) UIButton *senderButton;
@property (nonatomic, strong) UIImageView *avatar2ImageView;

@property (strong, nonatomic) UILabel *timeLabel;

@property (nonatomic, weak) id<UserChatCellDelegate> heightDelegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
