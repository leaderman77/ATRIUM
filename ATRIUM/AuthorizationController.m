//
//  AuthorizationController.m
//  ATRIUM
//
//  Created by Admin on 10/9/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AuthorizationController.h"
#import "UserTypeController.h"
#import "PasswordRecoveryController.h"
#import "AnnouncementsController.h"
#import "ChatsController.h"

#import "NewsController.h"

@interface AuthorizationController () <UITabBarControllerDelegate, UITabBarDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (retain, nonatomic) UIView *loginView;

@property (retain, nonatomic) UILabel *signInLabel;
@property (nonatomic, strong) UIButton *createAccountButton;

@property (retain, nonatomic) UILabel *emailLabel;
@property (strong, nonatomic) UITextField *loginTextField;

@property (retain, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *signInButton;
@property (nonatomic, strong) UIButton *recoverPasswordButton;


@end

@implementation AuthorizationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureControls];
    self.view.backgroundColor = rgbColor(22, 168, 235);
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Class methods Implementation

- (void)callApiMethods {

}

- (void)configureControls {
    CGFloat top = 60;
    CGFloat left = 10;
    CGFloat height = 35;
    CGFloat labelHeight = 30;
    CGFloat labelWidth = 300;
    //create language select button
    self.signInLabel = [[UILabel alloc]initWithFrame:CGRectMake(left, top, labelWidth, labelHeight)];
//    self.signInLabel.layer.borderWidth = 1;
    self.signInLabel.textAlignment = NSTextAlignmentCenter;
    self.signInLabel.font = FONT_SANSUMI_BOLD(16);
    self.signInLabel.textColor = rgbColor(255, 255, 255);
    self.signInLabel.text = [TRANSLATE(@"Please, sign in") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.signInLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.signInLabel];
    
    //create english language select button
    self.createAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(left, 80, labelWidth, height)];
//    self.createAccountButton.layer.borderWidth = 1.f;
    self.createAccountButton.layer.cornerRadius = 5.f;
    self.createAccountButton.backgroundColor = [UIColor clearColor];
    self.createAccountButton.titleColor = [UIColor whiteColor];
    self.createAccountButton.titleLabel.font = FONT_SANSUMI(14);
    self.createAccountButton.title = [TRANSLATE(@"Or set up a new account") uppercaseString];
    [self.createAccountButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    self.createAccountButton.enabled = YES;
    [self.createAccountButton addBottomBorderWithHeight:1 color:[UIColor whiteColor] leftOffset:30 rightOffset:30 andBottomOffset:8];
    [self.createAccountButton addTarget:self action:@selector(createAccountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createAccountButton];
    
    //create authorization
    self.loginView = [[UIView alloc] initWithFrame:CGRectMake(10, 130, 280, 370)];
    self.loginView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.loginView.layer.cornerRadius = 10.f;
//    self.loginView.layer.borderWidth = 1.f;
//    self.loginView.layer.borderColor = rgbColor(213, 213, 213).CGColor;
//    self.loginView.layer.masksToBounds = YES;
    self.loginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.loginView];
    
    self.emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 280, 20)];
    self.emailLabel.font = FONT_SANSUMI_BOLD(12);
    self.emailLabel.textColor = rgbColor(37, 66, 97);
    self.emailLabel.text = [TRANSLATE(@"E-mail") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.emailLabel.backgroundColor = [UIColor clearColor];
    [self.loginView addSubview:self.emailLabel];
    
    self.loginTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 280, height)];
    self.loginTextField.delegate = self;
//    self.loginTextField.borderStyle = UITextBorderStyleNone;
    self.loginTextField.backgroundColor = rgbColor(63, 183, 232);
    self.loginTextField.font = FONT_SANSUMI(20);
    self.loginTextField.textColor = rgbColor(255, 255, 255);
//    self.loginTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.loginTextField.leftView = paddingView;
    self.loginTextField.leftViewMode = UITextFieldViewModeAlways;
    self.loginTextField.layer.cornerRadius = 5.f;
//    self.loginTextField.layer.borderWidth = 1.f;
//    self.loginTextField.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.loginTextField.layer.masksToBounds = YES;
    self.loginTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.loginTextField.returnKeyType = UIReturnKeyNext;
    self.loginTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.loginTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.loginView addSubview:self.loginTextField];
    
    self.passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 280, 20)];
    self.passwordLabel.font = FONT_SANSUMI_BOLD(12);
    self.passwordLabel.textColor = rgbColor(37, 66, 97);
    self.passwordLabel.text = [TRANSLATE(@"Password") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.passwordLabel.backgroundColor = [UIColor clearColor];
    [self.loginView addSubview:self.passwordLabel];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 90, 280, height)];
    self.passwordTextField.delegate = self;
//    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.backgroundColor = rgbColor(63, 183, 232);
    self.passwordTextField.font = FONT_SANSUMI(20);
    self.passwordTextField.textColor = rgbColor(255, 255, 255);
//    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.passwordTextField.leftView = paddingView1;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.layer.cornerRadius = 5.f;
//    self.passwordTextField.layer.borderWidth = 1.f;
//    self.passwordTextField.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyJoin;
    self.passwordTextField.secureTextEntry = YES;
    [self.loginView addSubview:self.passwordTextField];
    //    top += self.passwordTextField.height + 10;

    self.signInButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 280, 150, height)];
    //    self.signInBtn.layer.borderWidth = 1.f;
    self.signInButton.layer.cornerRadius = 5.f;
    self.signInButton.backgroundColor = [UIColor whiteColor];
    self.signInButton.titleColor = rgbColor(37, 66, 97);
    self.signInButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    self.signInButton.title = [TRANSLATE(@"Sign in") uppercaseString];
    self.signInButton.enabled = YES;
    [self.signInButton addTarget:self action:@selector(signInButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signInButton];
    
    self.recoverPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(95, 307, 145, 30)];
//        self.recoverPasswordButton.layer.borderWidth = 1.f;
    self.recoverPasswordButton.layer.cornerRadius = 5.f;
    self.recoverPasswordButton.backgroundColor = [UIColor clearColor];
    self.recoverPasswordButton.titleColor = rgbColor(255, 255, 255);
    self.recoverPasswordButton.titleLabel.font = FONT_SANSUMI(10);
    self.recoverPasswordButton.title = [TRANSLATE(@"Forgot your Password?") uppercaseString];
    self.recoverPasswordButton.enabled = YES;
    [self.recoverPasswordButton addBottomBorderWithHeight:1 andColor:[UIColor whiteColor]];
    [self.recoverPasswordButton addTarget:self action:@selector(recoveryPasswordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recoverPasswordButton];
}
- (void)createAccountButtonClicked:(id)sender {
    UserTypeController *userTypeController = [[UserTypeController alloc]init];
    [self.navigationController pushViewController:userTypeController animated:YES];
}
- (void)recoveryPasswordButtonClicked:(id)sender {
    PasswordRecoveryController *passwordRecoveryController = [[PasswordRecoveryController alloc]init];
    [self.navigationController pushViewController:passwordRecoveryController animated:YES];
}
- (IBAction)signInButtonClicked:(id)sender {
    
//   self.tabBarController = [[CustomTabBarController alloc]init];
//    
//    NewsController *accountControlle = [[NewsController alloc]init];
//    accountControlle.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"Account") uppercaseString]
//                                                            image:[UIImage imageNamed:@"me_active.png"] tag:0];
//    UINavigationController *accountNavController = [[UINavigationController alloc]initWithRootViewController:accountControlle];
//    
//    ChatsController *chatsListController = [[ChatsController alloc]init];
//    chatsListController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"Chats") uppercaseString]
//                                                                  image:[UIImage imageNamed:@"messages_active.png"] tag:1];
//    UINavigationController *chatsNavController = [[UINavigationController alloc]initWithRootViewController:chatsListController];
//    
//    PasswordRecoveryController *passController = [[PasswordRecoveryController alloc]init];
//    passController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"") uppercaseString]
//                                                                  image:[UIImage imageNamed:@""] tag:2];
//    UINavigationController *passNavController = [[UINavigationController alloc]initWithRootViewController:passController];
//    
//    NewsController *newsControlle = [[NewsController alloc]init];
//    newsControlle.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"News") uppercaseString]
//                                                            image:[UIImage imageNamed:@"news_active.png"] tag:3];
//    UINavigationController *newsNavController = [[UINavigationController alloc]initWithRootViewController:newsControlle];
//    
//    AnnouncementsController *announcementController = [[AnnouncementsController alloc]init];
//    announcementController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"Announcements") uppercaseString]
//                                                                     image:[UIImage imageNamed:@"announcements_active.png"] tag:4];
//    
//    UINavigationController *announceNavController = [[UINavigationController alloc]initWithRootViewController:announcementController];
//    
//    CustomBtn *profileImageBtn = [[CustomBtn alloc]
//                                  initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 70/2, self.tabBarController.view.bounds.size.height - 70,
//                                                           70, 70)];
////    profileImageBtn.layer.borderWidth = 2;
//    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
//    profileImageView.contentMode = UIViewContentModeScaleAspectFill;
//    profileImageView.left = 0.5 * (profileImageBtn.width - profileImageView.width);
//    profileImageView.top = 0.5 * (profileImageBtn.height - profileImageView.height);
//    profileImageView.layer.cornerRadius = 0.5 * profileImageView.width;
//    profileImageView.layer.masksToBounds = YES;
//    profileImageView.backgroundColor = rgbColor(48, 182, 238);
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 17, 35, 35)];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [imageView setImage:[UIImage imageNamed:@"search copy.png"]];
//    [profileImageView addSubview:imageView];
//    [profileImageBtn addSubview:profileImageView];
//    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
//    profileImageBtn.backgroundColor = [UIColor clearColor];
//    profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
//    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
//    [profileImageBtn addTarget:self action:@selector(profileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.tabBarController.view addSubview:profileImageBtn];
////    [self.tabBarController.tabBar setFrame:CGRectMake(10,610, 370, 70)];
//    self.tabBarController.selectedIndex = 0;
//    
//    self.tabBarController.viewControllers = [NSArray
//                                             arrayWithObjects:accountNavController, chatsNavController, passNavController, newsNavController, announceNavController, nil];
//    
////    [self.tabBarController.tabBar addSubview:accountItem];
////    [self.tabBarController.tabBar addSubview:newsItem];
////    [self.tabBarController.tabBar addSubview:chatsItem];
////    [self.tabBarController.tabBar addSubview:announceItem];
//    
//    _tabBarController.delegate = self;
//    _tabBarController.moreNavigationController.delegate = self;
//    self.tabBarController.tabBar.backgroundColor = [UIColor blueColor];
////    self.tabBarController.tabBar.layer.borderWidth = 2;
//    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
//    self.tabBarController.tabBar.barTintColor = rgbColor(22, 168, 235);
//    [self.tabBarController setHiddenTabBar:NO];
    self.tabBarController = [[CustomTabBarController alloc]init];
    
    [self.view showLoading:YES];
    NSDictionary *param = @{@"email" : self.loginTextField.text, @"password" : self.passwordTextField.text};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_MEMBERS withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error && [responseDic[@"status"] integerValue] == 1 && responseDic[@"data"]) {
                                                   DLog(@"success 1 fields");
                                                   
                                                   NSArray *array = [[NSArray alloc]init];
                                                   array = [[responseDic objectForKey:@"data"] objectAtIndex:0];
                                                   
                                                   DLog(@"%@", array);
                                                   
                                                   NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                                   [userDefaults setObject:array forKey:@"loginDetails"];
                                                   [userDefaults synchronize];

                                                   [self.navigationController pushViewController:self.tabBarController animated:YES];
                                               } else {
                                                   ALERT(@"Email or Password is incorrect!");
                                               }
                                           }];
    
//    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_MEMBERS withHTTPMethodType:HTTP_POST withParameters:paramsDic callback:^(NSDictionary *responseDic, NSError *error) {
//        [self.view showLoading:NO];
//        if (!error && responseDic[@"data"]) {
//            [self.navigationController pushViewController:self.tabBarController animated:YES];
//        }  else {
//            ALERT(@"User not found");
//        }
//    }];
    
}
- (IBAction)profileImageClicked:(id)sender {
    DLog(@"Search Img Pressed");
}
//- (IBAction)singInBtn:(id)sender {
//    self.tabBarController = [[CustomTabBarController alloc]init];
//    
//    UIButton *accountItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    accountItem.frame = CGRectMake(20, 0, 50, 50);
//    accountItem.layer.cornerRadius = 5.0f;
//    accountItem.clipsToBounds = YES;
//    UIImageView *accountImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 40, 40)];
//    [accountImageView setImage:[UIImage imageNamed:@"me_active.png"]];
//    [accountItem addSubview:accountImageView];
//    accountItem.layer.masksToBounds = YES;
//    UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, accountItem.width, 20)];
//    accountLabel.textColor = rgbColor(255, 255, 255);
//    accountLabel.font = FONT_SANSUMI(10);
//    accountLabel.text = [TRANSLATE(@"Account") uppercaseString];
//    [accountItem addSubview:accountLabel];
//    accountItem.backgroundColor = [UIColor clearColor];
//    accountItem.enabled = YES;
//    [accountItem addTarget:self action:@selector(chatsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendAction:)];
//    //    [_toolbar setItems:[[NSArray alloc] initWithObjects:button1, nil]];
//  
//    
//    
//    UIButton *chatsItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    chatsItem.frame = CGRectMake(90, 0, 50, 50);
//    chatsItem.layer.cornerRadius = 5.0f;
//    chatsItem.clipsToBounds = YES;
//    UIImageView *chatsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [chatsImageView setImage:[UIImage imageNamed:@"messages_active.png"]];
//    [chatsItem addSubview:chatsImageView];
//    chatsItem.layer.masksToBounds = YES;
//    UILabel *chatsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, chatsItem.width, 20)];
//    chatsLabel.textColor = rgbColor(255, 255, 255);
//    chatsLabel.font = FONT_SANSUMI(10);
//    chatsLabel.text = [TRANSLATE(@"Chats") uppercaseString];
//    [chatsItem addSubview:chatsLabel];
//    chatsItem.backgroundColor = [UIColor clearColor];
//    chatsItem.enabled = YES;
//    [chatsItem addTarget:self action:@selector(chatsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    UIButton *newsItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    newsItem.frame = CGRectMake(230, 0, 50, 50);
//    newsItem.layer.cornerRadius = 5.0f;
//    newsItem.clipsToBounds = YES;
//    UIImageView *newsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [newsImageView setImage:[UIImage imageNamed:@"news_active.png"]];
//    [newsItem addSubview:newsImageView];
//    newsItem.layer.masksToBounds = YES;
//    UILabel *newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, newsItem.width, 20)];
//    newsLabel.textColor = rgbColor(255, 255, 255);
//    newsLabel.font = FONT_SANSUMI(10);
//    newsLabel.text = [TRANSLATE(@"News") uppercaseString];
//    [newsItem addSubview:newsLabel];
//    newsItem.backgroundColor = [UIColor clearColor];
//    newsItem.enabled = YES;
//    [newsItem addTarget:self action:@selector(newsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    UIButton *announceItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    announceItem.frame = CGRectMake(270, 0, 100, 50);
//    announceItem.layer.cornerRadius = 5.0f;
//    announceItem.clipsToBounds = YES;
//    UIImageView *announceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 0, 40, 40)];
//    [announceImageView setImage:[UIImage imageNamed:@"announcements_active.png"]];
//    [announceItem addSubview:announceImageView];
//    announceItem.layer.masksToBounds = YES;
//    UILabel *announceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, announceItem.width, 20)];
//    announceLabel.textColor = rgbColor(255, 255, 255);
//    announceLabel.font = FONT_SANSUMI(10);
//    announceLabel.text = [TRANSLATE(@"Announcements") uppercaseString];
//    [announceItem addSubview:announceLabel];
//    announceItem.backgroundColor = [UIColor clearColor];
//    announceItem.enabled = YES;
//    [announceItem addTarget:self action:@selector(searchAnnouncementsClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    CustomBtn *profileImageBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 70/2, self.tabBarController.view.bounds.size.height - 70, 70, 70)];
//    //        self.profileImageBtn.layer.borderWidth = 2;
//    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
//    profileImageView.contentMode = UIViewContentModeScaleAspectFill;
//    profileImageView.left = 0.5 * (profileImageBtn.width - profileImageView.width);
//    profileImageView.top = 0.5 * (profileImageBtn.height - profileImageView.height);
//    profileImageView.layer.cornerRadius = 0.5 * profileImageView.width;
//    profileImageView.layer.masksToBounds = YES;
//    profileImageView.backgroundColor = rgbColor(48, 182, 238);
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 35, 35)];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [imageView setImage:[UIImage imageNamed:@"search copy.png"]];
//    [profileImageView addSubview:imageView];
//    [profileImageBtn addSubview:profileImageView];
//    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
//    profileImageBtn.backgroundColor = [UIColor clearColor];
//    profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
//    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
//    [profileImageBtn addTarget:self action:@selector(profileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    NewsController *accountControlle = [[NewsController alloc]init];
//    [self.tabBarController.tabBar addSubview:accountItem];
//    
//    UINavigationController *accountNavController = [[UINavigationController alloc]initWithRootViewController:accountControlle];
//    
//    NewsController *newsControlle = [[NewsController alloc]init];
//    [self.tabBarController.tabBar addSubview:newsItem];
//    
//    UINavigationController *newsNavController = [[UINavigationController alloc]initWithRootViewController:newsControlle];
//    
//    ChatsController *chatsListController = [[ChatsController alloc]init];
//    [self.tabBarController.tabBar addSubview:chatsItem];
//    
//    UINavigationController *chatsNavController = [[UINavigationController alloc]initWithRootViewController:chatsListController];
//    
//    AnnouncementsController *announcementController = [[AnnouncementsController alloc]init];
//    [self.tabBarController.tabBar addSubview:announceItem];
//    
//    UINavigationController *announceNavController = [[UINavigationController alloc]initWithRootViewController:announcementController];
//    
////    [self.tabBarController.view addSubview:profileImageBtn];
//    self.tabBarController.selectedIndex = 0;
//    
//    self.tabBarController.viewControllers = [NSArray
//                                             arrayWithObjects:accountNavController, newsNavController, chatsNavController, announceNavController, nil];
//    
//    //    [self.tabBarController.tabBar addSubview:accountItem];
//    //    [self.tabBarController.tabBar addSubview:newsItem];
//    //    [self.tabBarController.tabBar addSubview:chatsItem];
//    //    [self.tabBarController.tabBar addSubview:announceItem];
//    
//    _tabBarController.delegate = self;
//    _tabBarController.moreNavigationController.delegate = self;
//    self.tabBarController.tabBar.backgroundColor = [UIColor blueColor];
//    //    self.tabBarController.tabBar.layer.borderWidth = 2;
//    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
//    self.tabBarController.tabBar.barTintColor = rgbColor(22, 168, 235);
//    [self.tabBarController setHiddenTabBar:NO];
//    [self.navigationController pushViewController:self.tabBarController animated:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if([self.loginTextField isEqual:textField]){
        [self.passwordTextField becomeFirstResponder];
    } else if([self.passwordTextField isEqual:textField]){
        [self.passwordTextField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if([self.loginTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if([self.passwordTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyJoin;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
