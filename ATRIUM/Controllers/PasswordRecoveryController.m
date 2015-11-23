//
//  PasswordRecoveryController.m
//  ATRIUM
//
//  Created by Admin on 10/12/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "PasswordRecoveryController.h"
#import "DateTimePicker.h"

@interface PasswordRecoveryController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (retain, nonatomic) UILabel *titleLabel;

@property (nonatomic, strong) UIView *topView;

@property (retain, nonatomic) UILabel *emailNameLabel;
@property (strong, nonatomic) CustomTextField *emailTextField;

@property (retain, nonatomic) UILabel *dobLabel;
@property (strong, nonatomic) CustomTextField *dobDateTextField;

//@property (strong, nonatomic) CustomTextField *dobMonthTextField;
//@property (strong, nonatomic) CustomTextField *dobYearTextField;
@property (nonatomic, strong) DateTimePicker* picker;
@property (nonatomic, strong) UIButton *passcodeSendButton;
@end

@implementation PasswordRecoveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureControls];
    [self configureNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 27, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    [self.view addSubview:self.topView];
}
- (void)configureControls {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
    //    self.scrollView.layer.borderWidth = 2;
//    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(22, 168, 235);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    //create language select button
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, self.topView.height, 250, 60)];
    self.titleLabel.font = FONT_SANSUMI_BOLD(26);
    self.titleLabel.textColor = rgbColor(255, 255, 255);
    self.titleLabel.numberOfLines = 0.f;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *studentTitle = [TRANSLATE(@"Password") uppercaseString];
    NSMutableAttributedString *studentMemberTitle = [[NSMutableAttributedString alloc]
                                                     initWithAttributedString:[NSAttributedString attributedStringWithTitle:studentTitle withTextColor:rgbColor(255, 255, 255) withBoldFontSize:22]];
    NSString *additionalTitle2 = [TRANSLATE(@" \nRecovery") uppercaseString];
    NSMutableAttributedString *studentMemberTitle2 = [[NSMutableAttributedString alloc]
                                                      initWithAttributedString:[NSAttributedString attributedStringWithTitle:additionalTitle2 withTextColor:rgbColor(255, 255, 255) withFontSize:18]];
    
    [studentMemberTitle appendAttributedString:studentMemberTitle2];
    self.titleLabel.attributedText = studentMemberTitle;
    //    self.loginTitleLabel.hidden = YES;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.titleLabel];
        
    [self createView];
}
- (void)createView {
    CGFloat left = 15.f;
    CGFloat top = 75.f;
    CGFloat labelWidth = 125;
    CGFloat labelHeight = 20.f;
    CGFloat textFieldWidth = 280;
    CGFloat textFieldHeight = 35.f;
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    _picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2 - 35, screenWidth, screenHeight/2 + 35)];
    [_picker addTargetForDoneButton:self action:@selector(donePressed)];
    //    [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
    //    [self.view addSubview:picker];
    _picker.hidden = NO;
    [_picker setMode:UIDatePickerModeDate];
    [_picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];

    
    self.emailNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    self.emailNameLabel.font = FONT_SANSUMI_BOLD(12);
    self.emailNameLabel.textColor = rgbColor(73, 108, 148);
    self.emailNameLabel.text = [TRANSLATE(@"E-mail") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.emailNameLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.emailNameLabel];
    
    top += self.emailNameLabel.height;
    self.emailTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
    self.emailTextField.delegate = self;
    //    self.emailTextField.placeholder = [TRANSLATE(@"Sample@email.com") uppercaseString];
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.emailTextField.backgroundColor = rgbColor(63, 183, 232);
    self.emailTextField.font = FONT_SANSUMI(16);
    self.emailTextField.textColor = rgbColor(255, 255, 255);
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.emailTextField.leftView = paddingView2;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    self.emailTextField.layer.cornerRadius = 5.f;
    self.emailTextField.layer.masksToBounds = YES;
    self.emailTextField.returnKeyType = UIReturnKeyNext;
    self.emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.scrollView addSubview:self.emailTextField];
    
    top += self.emailTextField.height;
    self.dobLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    self.dobLabel.font = FONT_SANSUMI_BOLD(12);
    self.dobLabel.textColor = rgbColor(73, 108, 148);
    self.dobLabel.text = [TRANSLATE(@"Date of birth") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.dobLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.dobLabel];
    
    top += self.dobLabel.height;
    self.dobDateTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
    self.dobDateTextField.delegate = self;
    [self.dobDateTextField setRightArrowVisible:YES];
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.dobDateTextField.backgroundColor = rgbColor(63, 183, 232);
    self.dobDateTextField.font = FONT_SANSUMI(16);
    self.dobDateTextField.textColor = rgbColor(255, 255, 255);
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.dobDateTextField.leftView = paddingView3;
    self.dobDateTextField.leftViewMode = UITextFieldViewModeAlways;
    self.dobDateTextField.layer.cornerRadius = 5.f;
    self.dobDateTextField.layer.masksToBounds = YES;
    self.dobDateTextField.returnKeyType = UIReturnKeyNext;
    self.dobDateTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.dobDateTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.dobDateTextField.inputView = self.picker;
    [self.scrollView addSubview:self.dobDateTextField];
    
//    self.dobMonthTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 90, top + 100, textFieldWidth / 2 - 30, textFieldHeight)];
//    self.dobMonthTextField.delegate = self;
//    [self.dobMonthTextField setRightArrowVisible:YES];
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.dobMonthTextField.backgroundColor = rgbColor(63, 183, 232);
//    self.dobMonthTextField.font = FONT_SANSUMI(20);
//    self.dobMonthTextField.textColor = rgbColor(255, 255, 255);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.dobMonthTextField.leftView = paddingView7;
//    self.dobMonthTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.dobMonthTextField.layer.cornerRadius = 5.f;
//    self.dobMonthTextField.layer.masksToBounds = YES;
//    self.dobMonthTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.dobMonthTextField];
//    
//    self.dobYearTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 240, top + 100, textFieldWidth / 2 - 65, textFieldHeight)];
//    self.dobYearTextField.delegate = self;
//    [self.dobYearTextField setRightArrowVisible:YES];
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.dobYearTextField.backgroundColor = rgbColor(63, 183, 232);
//    self.dobYearTextField.font = FONT_SANSUMI(20);
//    self.dobYearTextField.textColor = rgbColor(255, 255, 255);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.dobYearTextField.leftView = paddingView8;
//    self.dobYearTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.dobYearTextField.layer.cornerRadius = 5.f;
//    self.dobYearTextField.layer.masksToBounds = YES;
//    self.dobYearTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.dobYearTextField];
    
    top += self.dobDateTextField.height;
    self.passcodeSendButton = [[UIButton alloc] initWithFrame:CGRectMake(35, top + 20, 250, 40)];
    //    self.signInBtn.layer.borderWidth = 1.f;
    self.passcodeSendButton.layer.cornerRadius = 5.f;
    self.passcodeSendButton.backgroundColor = [UIColor whiteColor];
    self.passcodeSendButton.titleColor = rgbColor(37, 66, 97);
    self.passcodeSendButton.titleLabel.font = FONT_SANSUMI_BOLD(12);
    self.passcodeSendButton.title = [TRANSLATE(@"Send a temporary passcode") uppercaseString];
    self.passcodeSendButton.enabled = YES;
    [self.passcodeSendButton addTarget:self action:@selector(sendPasscodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.passcodeSendButton];
    
    self.scrollView.contentSize = CGSizeMake(0, 520);
    self.scrollView.scrollEnabled = YES;
    //    [self.scrollView setContentOffset:CGPointMake(0, 600) animated:YES];
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendPasscodeButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
    
    NSDictionary *param = @{@"email" : self.emailTextField.text, @"birthDate" : @"1990-05-23"};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_PASSWORD_RECOVERY withHTTPMethodType:HTTP_POST withParameters:param
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
- (void)pickerChanged:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    self.dobDateTextField.text = [formatter stringFromDate:[(UIDatePicker*)sender date]];
    NSLog(@"value: %@",[sender date]);
}
-(void)donePressed {
    //    picker.hidden = YES;
    NSLog(@"Done button tapped");
    [self.dobDateTextField resignFirstResponder];
}

#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if([self.emailTextField isEqual:textField]){
        [self.dobDateTextField becomeFirstResponder];
    } else if([self.dobDateTextField isEqual:textField]){
        [self.dobDateTextField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if([self.emailTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if([self.dobDateTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyDone;
    }
    [self.scrollView setContentOffset:CGPointMake(0, textField.center.y-100) animated:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.dobDateTextField isEqual:textField]) {
        [self.scrollView setContentOffset:CGPointMake(0, textField.center.y - 180) animated:YES];
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
