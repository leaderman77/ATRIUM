//
//  StudentRegistrationInfoView.h
//  ATRIUM
//
//  Created by Admin on 11/5/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BaseInfoView.h"

@class Photo;


@interface StudentRegistrationInfoView : BaseInfoView
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (retain, nonatomic) UILabel *fullNameLabel;
@property (strong, nonatomic) CustomTextField *fullNameTextField;

@property (retain, nonatomic) UILabel *emailNameLabel;
@property (strong, nonatomic) CustomTextField *emailTextField;

@property (retain, nonatomic) UILabel *dobLabel;
@property (strong, nonatomic) CustomTextField *dobDateTextField;

@property (strong, nonatomic) CustomTextField *dobMonthTextField;
@property (strong, nonatomic) CustomTextField *dobYearTextField;

@property (retain, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) CustomTextField *phoneTextField;

@property (retain, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) CustomTextField *passwordTextField;

@property (retain, nonatomic) UILabel *confmPasswordLabel;
@property (strong, nonatomic) CustomTextField *confmPasswordTextField;

@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) Photo *photo;

@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, strong) NSString *profilePhoto;

- (void)setProfileImage:(UIImage *)image;
- (void)uploadAndSetProfileImage:(UIImage *)image;
@end
