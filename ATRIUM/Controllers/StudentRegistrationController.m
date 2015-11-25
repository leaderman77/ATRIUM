//
//  StudentRegistrationController.m
//  ATRIUM
//
//  Created by Admin on 10/12/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "StudentRegistrationController.h"
#import "StudentRegistrationInfoView.h"

@interface StudentRegistrationController ()<BaseInfoViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) StudentRegistrationInfoView *studentRegistrationInfoView;

@property (nonatomic, strong) UITextField *activeTextField;
@property (nonatomic, assign) CGFloat keyboardHeight;


@end

@implementation StudentRegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    
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
    titleButton.text = [TRANSLATE(@"New Student") uppercaseString];
    titleButton.titleColor = rgbColor(69, 98, 138); 
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    UIButton *approveButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 27, 30, 30)];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
//    self.scrollView.layer.borderWidth = 2;
//    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(255, 255, 255);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    //create faculty member select button
    CGFloat left = 10.f;
    CGFloat top = 0.f;
    
    self.studentRegistrationInfoView = [[StudentRegistrationInfoView alloc] initWithFrame:CGRectMake(left, top, 300, self.scrollView.height)];
    //    self.professorRegisterInfoView.layer.borderWidth = 2;
    self.studentRegistrationInfoView.baseDelegate = self;
    self.studentRegistrationInfoView.navigationController = self.navigationController;
    self.studentRegistrationInfoView.viewController = self;
    [self.studentRegistrationInfoView createAndLayoutSubviews];
    [self.scrollView addSubview:self.studentRegistrationInfoView];
    
    self.scrollView.contentSize = CGSizeMake(0, 650);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
//    self.profileImageBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(left + 70, top, 150, 150)];
////    self.profileImageBtn.layer.borderWidth = 2;
//    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.profileImageBtn.width, self.profileImageBtn.height)];
//    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.profileImageView.left = 0.5 * (self.profileImageBtn.width - self.profileImageView.width);
//    self.profileImageView.top = 0.5 * (self.profileImageBtn.height - self.profileImageView.height);
//    self.profileImageView.layer.cornerRadius = 0.5 * self.profileImageView.width;
//    self.profileImageView.layer.masksToBounds = YES;
////    self.profileImageView.layer.borderWidth = 1.0f;
////    self.profileImageView.layer.borderColor = [UIColor blueColor].CGColor;
//    self.profileImageView.backgroundColor = [UIColor whiteColor];
//    self.profileImageView.image = [UIImage imageNamed:@"add_photo_student.png"];
////    [self.profileImageView sd_setImageWithURL:self.patientPersonalDetails.photo.url placeholderImage:[UIImage imageNamed:@"addimage.png"]];
//    [self.profileImageBtn addSubview:self.profileImageView];
//    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
//    self.profileImageBtn.backgroundColor = [UIColor clearColor];
//    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    
////    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
//    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
//    [self.profileImageBtn addTarget:self action:@selector(profileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:self.profileImageBtn];
//
//    [self createView];
}
//- (void)createView {
//    CGFloat left = 10.f;
//    CGFloat top = 130.f;
//    CGFloat labelWidth = 125;
//    CGFloat labelHeight = 20.f;
//    CGFloat textFieldWidth = 290;
//    CGFloat textFieldHeight = 35.f;
//    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;

//    _picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2 - 35, screenWidth, screenHeight/2 + 35)];
//    [_picker addTargetForDoneButton:self action:@selector(donePressed)];
//    //    [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
//    //    [self.view addSubview:picker];
//    _picker.hidden = NO;
//    [_picker setMode:UIDatePickerModeDate];
//    [_picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
//    
//    self.fullNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
////    self.fullNameLabel.layer.borderWidth = 2;
//    self.fullNameLabel.font = FONT_SANSUMI_BOLD(10);
//    self.fullNameLabel.textColor = rgbColor(0, 164, 234);
//    self.fullNameLabel.text = [TRANSLATE(@"Full name") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
//    self.fullNameLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.fullNameLabel];
//    top += self.fullNameLabel.height;
//    
//    self.fullNameTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
//    self.fullNameTextField.delegate = self;
////    self.fullNameTextField.placeholder = [TRANSLATE(@"Type in your full name") uppercaseString];
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.fullNameTextField.backgroundColor = rgbColor(236, 243, 249);
//    self.fullNameTextField.font = FONT_SANSUMI(16);
//    self.fullNameTextField.textColor = rgbColor(121, 143, 172);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.fullNameTextField.leftView = paddingView1;
//    self.fullNameTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.fullNameTextField.layer.cornerRadius = 5.f;
//    //    self.passwordTextField.layer.borderWidth = 1.f;
//    //    self.passwordTextField.layer.borderColor = rgbColor(213, 213, 213).CGColor;
//    self.fullNameTextField.layer.masksToBounds = YES;
//    self.fullNameTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.fullNameTextField];
//    top += self.fullNameTextField.height;
//    
//    self.emailNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
//    self.emailNameLabel.font = FONT_SANSUMI_BOLD(10);
//    self.emailNameLabel.textColor = rgbColor(0, 164, 234);
//    self.emailNameLabel.text = [TRANSLATE(@"E-mail") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
//    self.emailNameLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.emailNameLabel];
//    top += self.emailNameLabel.height;
//    self.emailTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
//    self.emailTextField.delegate = self;
////    self.emailTextField.placeholder = [TRANSLATE(@"Sample@email.com") uppercaseString];
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.emailTextField.backgroundColor = rgbColor(236, 243, 249);
//    self.emailTextField.font = FONT_SANSUMI(16);
//    self.emailTextField.textColor = rgbColor(121, 143, 172);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.emailTextField.leftView = paddingView2;
//    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.emailTextField.layer.cornerRadius = 5.f;
//    self.emailTextField.layer.masksToBounds = YES;
//    self.emailTextField.returnKeyType = UIReturnKeyNext;
//    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
//    [self.scrollView addSubview:self.emailTextField];
//    
//    top += self.emailTextField.height;
//    self.dobLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
//    self.dobLabel.font = FONT_SANSUMI_BOLD(10);
//    self.dobLabel.textColor = rgbColor(0, 164, 234);
//    self.dobLabel.text = [TRANSLATE(@"Date of birth") uppercaseString];
//    //    self.loginTitleLabel.hidden = YES;
//    self.dobLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.dobLabel];
//    
//    top += self.dobLabel.height;
//    self.dobDateTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
//    self.dobDateTextField.delegate = self;
//    [self.dobDateTextField setRightArrowVisible:YES];
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.dobDateTextField.backgroundColor = rgbColor(236, 243, 249);
//    self.dobDateTextField.font = FONT_SANSUMI(16);
//    self.dobDateTextField.textColor = rgbColor(121, 143, 172);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.dobDateTextField.leftView = paddingView3;
//    self.dobDateTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.dobDateTextField.layer.cornerRadius = 5.f;
//    self.dobDateTextField.layer.masksToBounds = YES;
//    self.dobDateTextField.inputView = self.picker;
//    self.dobDateTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.dobDateTextField];
//    
////    self.dobMonthTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 90, top + 177, textFieldWidth / 2 - 30, textFieldHeight)];
////    self.dobMonthTextField.delegate = self;
////    [self.dobMonthTextField setRightArrowVisible:YES];
////    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
////    self.dobMonthTextField.backgroundColor = rgbColor(236, 243, 249);
////    self.dobMonthTextField.font = FONT_SANSUMI(20);
////    self.dobMonthTextField.textColor = rgbColor(121, 143, 172);
////    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
////    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
////    self.dobMonthTextField.leftView = paddingView7;
////    self.dobMonthTextField.leftViewMode = UITextFieldViewModeAlways;
////    self.dobMonthTextField.layer.cornerRadius = 5.f;
////    self.dobMonthTextField.layer.masksToBounds = YES;
////    self.dobMonthTextField.returnKeyType = UIReturnKeyNext;
////    [self.scrollView addSubview:self.dobMonthTextField];
////    
////    self.dobYearTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 240, top + 177, textFieldWidth / 2 - 65, textFieldHeight)];
////    self.dobYearTextField.delegate = self;
////    [self.dobYearTextField setRightArrowVisible:YES];
////    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
////    self.dobYearTextField.backgroundColor = rgbColor(236, 243, 249);
////    self.dobYearTextField.font = FONT_SANSUMI(20);
////    self.dobYearTextField.textColor = rgbColor(121, 143, 172);
////    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
////    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
////    self.dobYearTextField.leftView = paddingView8;
////    self.dobYearTextField.leftViewMode = UITextFieldViewModeAlways;
////    self.dobYearTextField.layer.cornerRadius = 5.f;
////    self.dobYearTextField.layer.masksToBounds = YES;
////    self.dobYearTextField.returnKeyType = UIReturnKeyNext;
////    [self.scrollView addSubview:self.dobYearTextField];
//    
//    top += self.dobDateTextField.height;
//    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
//    self.phoneLabel.font = FONT_SANSUMI_BOLD(10);
//    self.phoneLabel.textColor = rgbColor(0, 164, 234);
//    self.phoneLabel.text = [TRANSLATE(@"Phone Number") uppercaseString];
//    //    self.loginTitleLabel.hidden = YES;
//    self.phoneLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.phoneLabel];
//    
//    top += self.phoneLabel.height;
//    self.phoneTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
//    self.phoneTextField.delegate = self;
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.phoneTextField.backgroundColor = rgbColor(236, 243, 249);
//    self.phoneTextField.font = FONT_SANSUMI(16);
//    self.phoneTextField.textColor = rgbColor(121, 143, 172);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.phoneTextField.leftView = paddingView4;
//    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.phoneTextField.layer.cornerRadius = 5.f;
//    self.phoneTextField.layer.masksToBounds = YES;
////    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.phoneTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.phoneTextField];
//    
//    top += self.phoneTextField.height;
//    self.passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
//    self.passwordLabel.font = FONT_SANSUMI_BOLD(10);
//    self.passwordLabel.textColor = rgbColor(0, 164, 234);
//    self.passwordLabel.text = [TRANSLATE(@"Password") uppercaseString];
//    //    self.loginTitleLabel.hidden = YES;
//    self.passwordLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.passwordLabel];
//    
//    top += self.passwordLabel.height;
//    self.passwordTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth/2 - 10, textFieldHeight)];
//    self.passwordTextField.delegate = self;
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.passwordTextField.backgroundColor = rgbColor(236, 243, 249);
//    self.passwordTextField.font = FONT_SANSUMI(16);
//    self.passwordTextField.textColor = rgbColor(121, 143, 172);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.passwordTextField.leftView = paddingView5;
//    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.passwordTextField.layer.cornerRadius = 5.f;
//    self.passwordTextField.layer.masksToBounds = YES;
//    self.passwordTextField.secureTextEntry = YES;
//    self.passwordTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.passwordTextField];
//    
//    
//    self.confmPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 160, top - 20, labelWidth, labelHeight)];
//    self.confmPasswordLabel.font = FONT_SANSUMI_BOLD(10);
//    self.confmPasswordLabel.textColor = rgbColor(0, 164, 234);
//    self.confmPasswordLabel.text = [TRANSLATE(@"Confirm Password") uppercaseString];
//    //    self.loginTitleLabel.hidden = YES;
//    self.confmPasswordLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.confmPasswordLabel];
//    
//
//    self.confmPasswordTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 150, top, textFieldWidth/2 - 5, textFieldHeight)];
//    self.confmPasswordTextField.delegate = self;
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.confmPasswordTextField.backgroundColor = rgbColor(236, 243, 249);
//    self.confmPasswordTextField.font = FONT_SANSUMI(16);
//    self.confmPasswordTextField.textColor = rgbColor(121, 143, 172);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.confmPasswordTextField.leftView = paddingView6;
//    self.confmPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.confmPasswordTextField.layer.cornerRadius = 5.f;
//    self.confmPasswordTextField.layer.masksToBounds = YES;
//    self.confmPasswordTextField.secureTextEntry = YES;
//    self.confmPasswordTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.confmPasswordTextField];
    
    
//}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
    
    NSDictionary *param = @{@"User[email]" : self.studentRegistrationInfoView.emailTextField.text,
                            @"User[fullName]" : self.studentRegistrationInfoView.fullNameTextField.text,
                            @"User[password]" : self.studentRegistrationInfoView.passwordTextField.text,
                            @"User[confirmPassword]" : self.studentRegistrationInfoView.confmPasswordTextField.text,
                            @"User[birthDate]" : self.studentRegistrationInfoView.dobDateTextField.text,
                            @"User[phoneNumber]" : self.studentRegistrationInfoView.phoneTextField.text,
                            @"User[position]" : @"Student",
                            @"User[photo]" : self.studentRegistrationInfoView.profilePhoto};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_SAVE_NEW_USER withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   [self.navigationController popViewControllerAnimated:YES];
                                               } else {
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];
    
}

#pragma mark Base Info View Cases

- (void)baseInfoView:(StudentRegistrationInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value {
    switch (actionType) {
        case 1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-160) animated:YES];
            break;
        case -1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-270) animated:YES];
            break;
        case -2:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-360) animated:YES];
            break;
        default:
            break;
    }
}


#pragma mark - Keyboard delegate

- (void)keyboardDidShow:(id)sender {
    [super keyboardDidShow:sender];
    //    CGRect rect = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize keyboardSize = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.keyboardHeight = keyboardSize.height;
    self.keyboardHeight = 332;
    //    CGRect rect1 = [self.view convertRect:rect fromView:self.view];
    self.scrollView.contentSize = CGSizeMake(0, self.scrollView.contentSize.height + keyboardSize.height);
    if (self.activeTextField && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        CGFloat top = self.activeTextField.top + self.activeTextField.superview.top - self.keyboardHeight + 75;
        if (self.activeTextField && top > 0) {
            [self.scrollView setContentOffset:CGPointMake(0, top) animated:YES];
        }
    }
}

- (void)keyboardDidHide:(id)sender {
    [super keyboardDidHide:sender];
    if (self.isKeyboardWasShown) {
        CGSize keyboardSize = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        self.keyboardHeight = keyboardSize.height;
        self.keyboardHeight = 332;
        self.scrollView.contentSize = CGSizeMake(0, self.scrollView.contentSize.height - keyboardSize.height);
        //            [self.scrollView setContentOffset:CGPointZero animated:YES];
    }
    
    self.isKeyboardWasShown = NO;
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
