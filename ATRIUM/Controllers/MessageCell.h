//
//  MessageCel.h
//  ATRIUM
//
//  Created by Admin on 10/27/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseCell.h"
#import "Message.h"

@interface MessageCell : BaseCell
@property (strong, nonatomic) Message *message;
@property (nonatomic, strong) UIButton *imgButton;
@property (nonatomic, strong) UIImageView *avatarImageView;

-(void)updateMessageStatus;

//Estimate BubbleCell Height
-(CGFloat)height;
@end
