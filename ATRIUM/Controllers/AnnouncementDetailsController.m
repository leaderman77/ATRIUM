//
//  AnnouncementDetailsController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AnnouncementDetailsController.h"

@interface AnnouncementDetailsController ()
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, retain) UITextView *detailsTextView;

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *chatLabel;

@property (nonatomic, retain) UIButton *chatButton;
@property (nonatomic, strong) UIButton *approveButton;
@end

@implementation AnnouncementDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureControls];
    [self configureNavigationBar];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.backgroundColor = rgbColor(22, 168, 235);
//    self.navigationController.navigationBar.barTintColor = rgbColor(22, 168, 235);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(255, 255, 255);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(@"My Announcements") uppercaseString];
    titleButton.titleColor = rgbColor(22, 168, 235);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    self.approveButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 25, 30, 30)];
    UIImageView *approveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.approveButton.width, self.approveButton.height)];
    [approveImageView setImage:self.isViewMode ? [UIImage imageNamed:@"navig_bar_edit.png"] : [UIImage imageNamed:@"navig_bar_save_changes.png"]];
    approveImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.approveButton addSubview:approveImageView];
    if (_isViewMode) {
        [self.approveButton addTarget:self action:@selector(isEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.approveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.topView addSubview:self.approveButton];
    
    [self.view addSubview:self.topView];
}
- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)isEditButtonClicked:(id)sender {
    if (_isViewMode) {
        self.isViewMode = NO;
//        self.studentProfileInfoView.isViewMode = NO;
        [self configureNavigationBar];
    } else {
        self.isViewMode = YES;
        [self configureNavigationBar];
        [self.approveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
- (void)configureControls {
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, self.view.bounds.size.width, 160)];
    //    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.backgroundColor = [UIColor blueColor];
    [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"addimage.png"]];
    [self.view addSubview:self.profileImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, self.profileImageView.height - 40, 220, 30)];
//    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.font = FONT_SANSUMI_BOLD(15);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = self.announceTitle;
    self.titleLabel.textColor = rgbColor(255, 255, 255);           //colorWithRGB(25, 94, 180);
    [self.profileImageView addSubview:self.titleLabel];
    
    self.chatButton = [[UIButton alloc] initWithFrame:CGRectMake(160, self.profileImageView.height + 65, 50, 30)];
    UIImageView *chatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.chatButton.width, self.chatButton.height)];
    [chatImageView setImage:[UIImage imageNamed:@"chat_with_the_author.png"]];
    chatImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.chatButton addSubview:chatImageView];
    [self.chatButton addTarget:self action:@selector(chatWithAuthorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chatButton];
    
    self.chatLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, self.profileImageView.height + 60, 80, 35)];
//    self.chatLabel.layer.borderWidth = 1;
    self.chatLabel.layer.cornerRadius = 0.5;
    self.chatLabel.layer.masksToBounds = YES;
    self.chatLabel.numberOfLines = 0.f;
    self.chatLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.chatLabel.textAlignment = NSTextAlignmentCenter;
    self.chatLabel.backgroundColor = [UIColor clearColor];
    NSString *followersString = [TRANSLATE(@"Chat With") uppercaseString];
    NSMutableAttributedString *followersNum = [[NSMutableAttributedString alloc]
                                               initWithAttributedString:[NSAttributedString attributedStringWithTitle:followersString withTextColor:rgbColor(37, 66, 97) withBoldFontSize:12]];
    NSString *followersTring2 = [TRANSLATE(@"\nThe Author") uppercaseString];
    NSMutableAttributedString *followersText = [[NSMutableAttributedString alloc]
                                                initWithAttributedString:[NSAttributedString attributedStringWithTitle:followersTring2 withTextColor:rgbColor(37, 66, 97) withFontSize:12]];
    [followersNum appendAttributedString:followersText];
    self.chatLabel.attributedText = followersNum;
    [self.view addSubview:self.chatLabel];
    
    self.detailsTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, self.profileImageView.height + 100, 290, 220)];
//        self.detailsTextView.layer.borderWidth = 2;
    self.detailsTextView.backgroundColor = [UIColor whiteColor];
    self.detailsTextView.text = self.myAnnounceText;
    self.detailsTextView.editable = self.isViewMode;
    self.detailsTextView.textColor = rgbColor(37, 66, 97);
    self.detailsTextView.scrollEnabled = YES;
    self.detailsTextView.font = FONT_SANSUMI_BOLD(15);
    [self.view addSubview:self.detailsTextView];
}
- (void)chatWithAuthorButtonClicked:(id)sender {
    
}
- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
//    NSDictionary *param = @{@"User[email]" : self.studentProfileInfoView.emailTextField.text,
//                            @"User[birthDate]" : self.studentProfileInfoView.dobDateTextField.text,
//                            @"User[phoneNumber]" : self.studentProfileInfoView.phoneTextField.text,
//                            @"User[position]" : @"Student",
//                            @"User[position]" : self.studentProfileInfoView.profilePhoto};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_CHANGE_PROFESSOR_PROFILE withHTTPMethodType:HTTP_POST withParameters:nil
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   
                                               } else {
                                                   [[RestClient sharedClient] showErrorMessage:responseDic];
                                                   //                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];
    
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
