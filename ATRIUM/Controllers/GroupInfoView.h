//
//  GroupInfoView.h
//  ATRIUM
//
//  Created by Admin on 11/5/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseInfoView.h"

@class Photo;

@interface GroupInfoView : BaseInfoView
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (retain, nonatomic) UILabel *groupNameLabel;
@property (strong, nonatomic) CustomTextField *groupNameTextField;

@property (retain, nonatomic) UILabel *groupDescriptionLabel;
@property (strong, nonatomic) UITextView *groupDescriptionTextView;

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) Photo *photo;

@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, strong) NSString *profilePhoto;

- (void)setProfileImage:(UIImage *)image;
- (void)uploadAndSetProfileImage:(UIImage *)image;
@end
