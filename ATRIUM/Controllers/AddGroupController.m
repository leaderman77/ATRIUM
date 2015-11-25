//
//  AddGroupController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AddGroupController.h"
#import "GroupInfoView.h"

@interface AddGroupController () <BaseInfoViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) GroupInfoView *groupInfoView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (retain, nonatomic) UILabel *groupNameLabel;
@property (strong, nonatomic) CustomTextField *groupNameTextField;

@property (retain, nonatomic) UILabel *groupDescriptionLabel;
@property (strong, nonatomic) UITextView *groupDescriptionTextView;

@property (nonatomic, strong) UITextField *activeTextField;

@property (nonatomic, strong) NSString *groupID;
@end

@implementation AddGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgbColor(22, 168, 235);
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 25, 220, 30)];
    titleButton.text = [TRANSLATE(@"Create new group") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    UIButton *approveButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 25, 30, 30)];
    UIImageView *approveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, approveButton.width, approveButton.height)];
    [approveImageView setImage:[UIImage imageNamed:@"navig_bar_save_changes.png"]];
    approveImageView.contentMode = UIViewContentModeScaleAspectFill;
    [approveButton addSubview:approveImageView];
    [approveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:approveButton];
    
    [self.view addSubview:self.topView];
}

- (void)configureControls {
//    [super configureControls];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height)];
    //    self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(22, 168, 235);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    //create faculty member select button
    CGFloat left = 10.f;
    CGFloat top = 0.f;
    
    self.groupInfoView = [[GroupInfoView alloc] initWithFrame:CGRectMake(left, top, 300, self.scrollView.height)];
    //    self.professorRegisterInfoView.layer.borderWidth = 2;
    self.groupInfoView.baseDelegate = self;
    self.groupInfoView.navigationController = self.navigationController;
    self.groupInfoView.viewController = self;
    [self.groupInfoView createAndLayoutSubviews];
    [self.scrollView addSubview:self.groupInfoView];
    
    self.scrollView.contentSize = CGSizeMake(0, 650);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
//    //create faculty member select button
//    CGFloat left = 15.f;
//    CGFloat top = 0.f;
//    
//    self.profileImageBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(left + 70, top, 150, 150)];
//    //        self.profileImageBtn.layer.borderWidth = 2;
//    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.profileImageBtn.width, self.profileImageBtn.height)];
//    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.profileImageView.left = 0.5 * (self.profileImageBtn.width - self.profileImageView.width);
//    self.profileImageView.top = 0.5 * (self.profileImageBtn.height - self.profileImageView.height);
//    self.profileImageView.layer.cornerRadius = 0.5 * self.profileImageView.width;
//    self.profileImageView.layer.masksToBounds = YES;
//    //    self.profileImageView.layer.borderWidth = 1.0f;
//    //    self.profileImageView.layer.borderColor = [UIColor blueColor].CGColor;
//    self.profileImageView.backgroundColor = rgbColor(22, 168, 235);
//    self.profileImageView.image = [UIImage imageNamed:@"add_photo_teacher.png"];
//    //    [self.profileImageView sd_setImageWithURL:self.patientPersonalDetails.photo.url placeholderImage:[UIImage imageNamed:@"addimage.png"]];
//    [self.profileImageBtn addSubview:self.profileImageView];
//    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
//    self.profileImageBtn.backgroundColor = rgbColor(22, 168, 235);
//    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
//    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
//    [self.profileImageBtn addTarget:self action:@selector(profileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:self.profileImageBtn];
//
//    
//    [self createView];
}
- (void)createView {
    CGFloat left = 20.f;
    CGFloat top = 145.f;
    CGFloat labelWidth = 125;
    CGFloat labelHeight = 20.f;
    CGFloat textFieldWidth = 270;
    CGFloat textFieldHeight = 40.f;
    
    self.groupNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    //    self.fullNameLabel.layer.borderWidth = 2;
    self.groupNameLabel.font = FONT_SANSUMI_BOLD(10);
    self.groupNameLabel.textColor = rgbColor(73, 108, 148);
    self.groupNameLabel.text = [TRANSLATE(@"Group Name") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.groupNameLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.groupNameLabel];
    
    self.groupNameTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top + 25, textFieldWidth, textFieldHeight)];
    self.groupNameTextField.delegate = self;
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.groupNameTextField.backgroundColor = rgbColor(63, 183, 232);
    self.groupNameTextField.font = FONT_SANSUMI(20);
    self.groupNameTextField.textColor = rgbColor(255, 255, 255);
    //    self.fullNameTextField.placeholder = [TRANSLATE(@"Type in your full name") uppercaseString];
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.groupNameTextField.leftView = paddingView1;
    self.groupNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.groupNameTextField.layer.cornerRadius = 5.f;
    //    self.passwordTextField.layer.borderWidth = 1.f;
    //    self.passwordTextField.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.groupNameTextField.layer.masksToBounds = YES;
    self.groupNameTextField.returnKeyType = UIReturnKeyNext;
    [self.scrollView addSubview:self.groupNameTextField];
    
    
    self.groupDescriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top + 70, labelWidth, labelHeight)];
    //    self.fullNameLabel.layer.borderWidth = 2;
    self.groupDescriptionLabel.font = FONT_SANSUMI_BOLD(10);
    self.groupDescriptionLabel.textColor = rgbColor(73, 108, 148);
    self.groupDescriptionLabel.text = [TRANSLATE(@"Group Description") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.groupDescriptionLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.groupDescriptionLabel];
    
    self.groupDescriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(left, top + 90, textFieldWidth, 270)];
    self.groupDescriptionTextView.backgroundColor = rgbColor(63, 183, 232);
    self.groupDescriptionTextView.editable = YES;
    self.groupDescriptionTextView.textColor = rgbColor(37, 66, 97);
    self.groupDescriptionTextView.scrollEnabled = YES;
    self.groupDescriptionTextView.font = FONT_SANSUMI(20);
    self.groupDescriptionTextView.textColor = rgbColor(255, 255, 255);
    self.groupDescriptionTextView.layer.cornerRadius = 5.f;
    self.groupDescriptionTextView.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.groupDescriptionTextView];
    //    self.scrollView.contentSize = CGSizeMake(0, 100);
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
    
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    
    NSDictionary *param = @{@"Group[title]" : self.groupInfoView.groupNameTextField.text,
                            @"Group[creator]" : userId,
                            @"Group[photo]" : self.groupInfoView.profilePhoto};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_ADD_GROUP withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                           DLog(@"success 1 fields");
                                           [self.view showLoading:NO];
                                           if (!error && [responseDic[@"status"] integerValue] == 1) {
                                               
                                               self.groupID = [[responseDic valueForKey:@"data"] valueForKey:@"id"];
                                               
                                               [self callApiGroupMemberMethods];
                                               if ([self.delegate respondsToSelector:@selector(callAppMethodOfChatLists)]) {
                                                   [self.delegate callAppMethodOfChatLists];
                                               }
                                               [self.navigationController popViewControllerAnimated:YES];
                                               
                                           } else {
                                               [[RestClient sharedClient] showErrorMessage:responseDic];
                                               //                                               ALERT(@"Error with saving profile.");
                                           }
                                       }];
    
    
}
- (void)callApiGroupMemberMethods {
    DLog(@"group add member method clicked");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
    
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    
    NSDictionary *param = @{@"id" : self.groupID,
                            @"user" : userId};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_ADD_GROUP_MEMBER withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               DLog(@"success 1 fields");
                                               [self.view showLoading:NO];
                                               if (!error && [responseDic[@"status"] integerValue] == 1) {
                                                                                                      
                                               } else {
                                                   [[RestClient sharedClient] showErrorMessage:responseDic];
                                                   //                                               ALERT(@"Error with saving profile.");
                                               }
                                           }];
}

#pragma mark Base Info View Cases

- (void)baseInfoView:(GroupInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value {
    switch (actionType) {
        case 1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-160) animated:YES];
            break;
        case -1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-190) animated:YES];
            break;
        case -2:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-100) animated:YES];
            break;
        default:
            break;
    }
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
