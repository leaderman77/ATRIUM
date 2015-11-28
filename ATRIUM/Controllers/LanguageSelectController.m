//
//  LanguageSelectController.m
//  ATRIUM
//
//  Created by Admin on 10/9/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "LanguageSelectController.h"
#import "AuthorizationController.h"
#import "PasswordRecoveryController.h"
#import "AnnouncementsController.h"
#import "ChatsController.h"

#import "NewsController.h"

#define ENGLISH_LANGUAGE     @"en"
#define RUSSIAN_LANGUAGE     @"ru"

@interface LanguageSelectController () <UITabBarControllerDelegate, UITabBarDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) UILabel *languageSelectLabel;
@property (retain, nonatomic) UILabel *orLabel;

@property (nonatomic, strong) UIButton *englishLangButton;
@property (nonatomic, strong) UIButton *russianLangButton;
@end

@implementation LanguageSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"Language Selct Controller";
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    [self configureControls];
    self.view.backgroundColor = rgbColor(22, 168, 235);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)configureControls {
//    [super configureControls];
    
    //create language select button
    self.languageSelectLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 100, 300, 20)];
    self.languageSelectLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.languageSelectLabel.font = FONT_SANSUMI(15);
    self.languageSelectLabel.textColor = rgbColor(255, 255, 255);
    self.languageSelectLabel.text = @"CHOOSE YOUR LANGUAGE";
    //    self.loginTitleLabel.hidden = YES;
    self.languageSelectLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.languageSelectLabel];
    
    //create english language select button
    self.englishLangButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 170, 250, 60)];
    //    self.signInBtn.layer.borderWidth = 1.f;
    self.englishLangButton.width;
    self.englishLangButton.layer.cornerRadius = 5.f;
    self.englishLangButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.englishLangButton.backgroundColor = [UIColor clearColor];
    self.englishLangButton.titleColor = [UIColor whiteColor];
    self.englishLangButton.titleLabel.font = FONT_SANSUMI_BOLD(20);
    self.englishLangButton.title = @"ENGLISH";
    self.englishLangButton.enabled = YES;
    [self.englishLangButton addTarget:self action:@selector(englishLangButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.englishLangButton];
    
    //create or label
    self.orLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 240, 250, 20)];
    self.orLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.orLabel.font = FONT_SANSUMI(20);
    self.orLabel.textColor = rgbColor(255, 255, 255);
    self.orLabel.text = @"OR";
    //    self.loginTitleLabel.hidden = YES;
    self.orLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.orLabel];
    
    //create russian language select button
    self.russianLangButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 270, 250, 60)];
    //    self.signInBtn.layer.borderWidth = 1.f;
    self.russianLangButton.layer.cornerRadius = 5.f;
    self.russianLangButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.russianLangButton.backgroundColor = [UIColor clearColor];
    self.russianLangButton.titleColor = [UIColor whiteColor];
    self.russianLangButton.titleLabel.font = FONT_SANSUMI_BOLD(20);
    self.russianLangButton.title = @"RUSSIAN";
    self.russianLangButton.enabled = YES;
    [self.russianLangButton addTarget:self action:@selector(russainLangButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.russianLangButton];
}
- (void)englishLangButtonClicked:(id)sneder {
    
    
    
    self.tabBarController = [[CustomTabBarController alloc]init];
    
//    NewsController *accountControlle = [[NewsController alloc]init];
//    accountControlle.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"Account") uppercaseString]
//                                                               image:[UIImage imageNamed:@"me_active.png"] tag:0];
//    UINavigationController *accountNavController = [[UINavigationController alloc]initWithRootViewController:accountControlle];
//    
//    ChatsController *chatsListController = [[ChatsController alloc]init];
//    chatsListController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"Chats") uppercaseString]
//                                                                  image:[UIImage imageNamed:@"messages_active.png"] tag:1];
//    UINavigationController *chatsNavController = [[UINavigationController alloc]initWithRootViewController:chatsListController];
//    
//    PasswordRecoveryController *passController = [[PasswordRecoveryController alloc]init];
//    passController.tabBarItem = [[UITabBarItem alloc]initWithTitle:[TRANSLATE(@"") uppercaseString]
//                                                             image:[UIImage imageNamed:@""] tag:2];
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
//    //    profileImageBtn.layer.borderWidth = 2;
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
//    //    [self.tabBarController.tabBar setFrame:CGRectMake(10,610, 370, 70)];
//    self.tabBarController.selectedIndex = 0;
//    
//    self.tabBarController.viewControllers = [NSArray
//                                             arrayWithObjects:accountNavController, chatsNavController, passNavController, newsNavController, announceNavController, nil];
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
//
    
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    AuthorizationController *authorizationController = [[AuthorizationController alloc]init];
    if (userId == nil) {
        [self.navigationController pushViewController:authorizationController animated:YES];
    } else {
//        [self.navigationController pushViewController:authorizationController animated:YES];
        [self.navigationController pushViewController:self.tabBarController animated:YES];
    }
    
   
}
- (void)russainLangButtonClicked:(id)sneder {
    self.tabBarController = [[CustomTabBarController alloc]init];
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    [[SettingsManager sharedManager]setCurrentLanguage:RUSSIAN_LANGUAGE];
    AuthorizationController *authorizationController = [[AuthorizationController alloc]init];
    if (userId == nil) {
        [self.navigationController pushViewController:authorizationController animated:YES];
    } else {
        //        [self.navigationController pushViewController:authorizationController animated:YES];
        [self.navigationController pushViewController:self.tabBarController animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Orientation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
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
