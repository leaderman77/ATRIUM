//
//  GroupChatInfoView.h
//  ATRIUM
//
//  Created by Admin on 11/5/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseInfoView.h"

@class Photo;

@interface GroupChatInfoView : BaseInfoView
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (retain, nonatomic) UILabel *chatTitleLabel;
@property (strong, nonatomic) CustomTextField *chatTitleTextField;

@property (retain, nonatomic) UILabel *addMemberLabel;
@property (strong, nonatomic) CustomTextField *positionTextField;

@property (retain, nonatomic) UILabel *emailNameLabel;
@property (strong, nonatomic) CustomTextField *nameTextField;

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) Photo *photo;

@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, strong) NSString *profilePhoto;

@property (nonatomic, strong) NSString *groupID;

- (void)setProfileImage:(UIImage *)image;
- (void)uploadAndSetProfileImage:(UIImage *)image;
@end
