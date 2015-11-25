//
//  ProfessorRegistrationController.m
//  ATRIUM
//
//  Created by Admin on 10/12/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "ProfessorRegistrationController.h"
#import "ItemsPopover.h"
//#import "HomeViewTabBarController.h"
#import "ChatsBottomView.h"
#import "ProfessorRegistrationInfoView.h"

@interface ProfessorRegistrationController () <UITextFieldDelegate, ItemsPopoverDelegate, UIPopoverPresentationControllerDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate, BaseInfoViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (retain, nonatomic) UILabel *fullNameLabel;
@property (strong, nonatomic) CustomTextField *fullNameTextField;

@property (retain, nonatomic) UILabel *positionLabel;
@property (strong, nonatomic) CustomTextField *positionTextField;

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

@property(nonatomic,retain) UIPopoverPresentationController *dateTimePopover8;
@property (nonatomic, retain) UIPickerView *dobPickerView;
@property (nonatomic, retain) NSMutableArray *pickerData;

@property (nonatomic, strong) ItemsPopover *itemsPopover;
@property (nonatomic, strong) PickerPopover *datePickerPopover;

@property (nonatomic, strong) ProfessorRegistrationInfoView *professorRegisterInfoView;

@property (nonatomic, strong) UITextField *activeTextField;
@property (nonatomic, assign) CGFloat keyboardHeight;
@end

@implementation ProfessorRegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    
//    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 25, 240, 30)];
    titleButton.text = [TRANSLATE(@"New Faculty Member") uppercaseString];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
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
    
    self.professorRegisterInfoView = [[ProfessorRegistrationInfoView alloc] initWithFrame:CGRectMake(left, top, 300, self.scrollView.height)];
//    self.professorRegisterInfoView.layer.borderWidth = 2;
    self.professorRegisterInfoView.baseDelegate = self;
    self.professorRegisterInfoView.navigationController = self.navigationController;
    self.professorRegisterInfoView.viewController = self;
    [self.professorRegisterInfoView createAndLayoutSubviews];
    [self.scrollView addSubview:self.professorRegisterInfoView];
    
    self.scrollView.contentSize = CGSizeMake(0, 650);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)createView {
    CGFloat left = 10.f;
    CGFloat top = 130.f;
    CGFloat labelWidth = 155;
    CGFloat labelHeight = 15.f;
    CGFloat textFieldWidth = 290;
    CGFloat textFieldHeight = 32.f;
    
    self.fullNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    //    self.fullNameLabel.layer.borderWidth = 2;
    self.fullNameLabel.font = FONT_SANSUMI_BOLD(10);
    self.fullNameLabel.textColor = rgbColor(73, 108, 148);
    self.fullNameLabel.text = [TRANSLATE(@"Full name") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.fullNameLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.fullNameLabel];
    
    top += self.fullNameLabel.height;
    self.fullNameTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
    self.fullNameTextField.delegate = self;
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.fullNameTextField.backgroundColor = rgbColor(63, 183, 232);
    self.fullNameTextField.font = FONT_SANSUMI(16);
    self.fullNameTextField.textColor = rgbColor(255, 255, 255);
//    self.fullNameTextField.placeholder = [TRANSLATE(@"Type in your full name") uppercaseString];
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.fullNameTextField.leftView = paddingView1;
    self.fullNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.fullNameTextField.layer.cornerRadius = 5.f;
    //    self.passwordTextField.layer.borderWidth = 1.f;
    //    self.passwordTextField.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.fullNameTextField.layer.masksToBounds = YES;
    self.fullNameTextField.returnKeyType = UIReturnKeyNext;
    [self.scrollView addSubview:self.fullNameTextField];
    
    top += self.fullNameTextField.height;
    self.positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    //    self.fullNameLabel.layer.borderWidth = 2;
    self.positionLabel.font = FONT_SANSUMI_BOLD(10);
    self.positionLabel.textColor = rgbColor(73, 108, 148);
    self.positionLabel.text = [TRANSLATE(@"Position") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.positionLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.positionLabel];
    
    top += self.positionLabel.height;
    self.positionTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
    self.positionTextField.delegate = self;
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.positionTextField.backgroundColor = rgbColor(63, 183, 232);
    self.positionTextField.font = FONT_SANSUMI(16);
    self.positionTextField.textColor = rgbColor(255, 255, 255);
//    self.positionTextField.placeholder = [TRANSLATE(@"Type in your full name") uppercaseString];
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.positionTextField.leftView = paddingView9;
    self.positionTextField.leftViewMode = UITextFieldViewModeAlways;
    self.positionTextField.layer.cornerRadius = 5.f;
    //    self.passwordTextField.layer.borderWidth = 1.f;
    //    self.passwordTextField.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.positionTextField.layer.masksToBounds = YES;
    self.positionTextField.returnKeyType = UIReturnKeyNext;
    [self.scrollView addSubview:self.positionTextField];
    
    top += self.positionTextField.height;
    self.emailNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    self.emailNameLabel.font = FONT_SANSUMI_BOLD(10);
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
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.scrollView addSubview:self.emailTextField];
    
    top += self.emailTextField.height;
    self.dobLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    self.dobLabel.font = FONT_SANSUMI_BOLD(10);
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
    [self.scrollView addSubview:self.dobDateTextField];
    
//    self.dobMonthTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 90, top + 205, textFieldWidth / 2 - 30, textFieldHeight)];
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
//    self.dobYearTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 240, top + 205, textFieldWidth / 2 - 65, textFieldHeight)];
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
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    self.phoneLabel.font = FONT_SANSUMI_BOLD(10);
    self.phoneLabel.textColor = rgbColor(73, 108, 148);
    self.phoneLabel.text = [TRANSLATE(@"Phone Number") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.phoneLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.phoneLabel];
    
    top += self.phoneLabel.height;
    self.phoneTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth, textFieldHeight)];
    self.phoneTextField.delegate = self;
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.phoneTextField.backgroundColor = rgbColor(63, 183, 232);
    self.phoneTextField.font = FONT_SANSUMI(16);
    self.phoneTextField.textColor = rgbColor(255, 255, 255);
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.phoneTextField.leftView = paddingView4;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.layer.cornerRadius = 5.f;
    self.phoneTextField.layer.masksToBounds = YES;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.returnKeyType = UIReturnKeyNext;
    [self.scrollView addSubview:self.phoneTextField];
    
    top += self.phoneTextField.height;
    self.passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    self.passwordLabel.font = FONT_SANSUMI_BOLD(10);
    self.passwordLabel.textColor = rgbColor(73, 108, 148);
    self.passwordLabel.text = [TRANSLATE(@"Password") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.passwordLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.passwordLabel];
    
    top += self.passwordLabel.height;
    self.passwordTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, textFieldWidth/2 - 10, textFieldHeight)];
    self.passwordTextField.delegate = self;
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.backgroundColor = rgbColor(63, 183, 232);
    self.passwordTextField.font = FONT_SANSUMI(16);
    self.passwordTextField.textColor = rgbColor(255, 255, 255);
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.passwordTextField.leftView = paddingView5;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.layer.cornerRadius = 5.f;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    [self.scrollView addSubview:self.passwordTextField];
    
    self.confmPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 160, top - 15, labelWidth, labelHeight)];
    self.confmPasswordLabel.font = FONT_SANSUMI_BOLD(10);
    self.confmPasswordLabel.textColor = rgbColor(73, 108, 148);
    self.confmPasswordLabel.text = [TRANSLATE(@"Confirm Password") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.confmPasswordLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.confmPasswordLabel];
    
    self.confmPasswordTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 150, top, textFieldWidth/2 - 5, textFieldHeight)];
    self.confmPasswordTextField.delegate = self;
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.confmPasswordTextField.backgroundColor = rgbColor(63, 183, 232);
    self.confmPasswordTextField.font = FONT_SANSUMI(16);
    self.confmPasswordTextField.textColor = rgbColor(255, 255, 255);
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.confmPasswordTextField.leftView = paddingView6;
    self.confmPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.confmPasswordTextField.layer.cornerRadius = 5.f;
    self.confmPasswordTextField.layer.masksToBounds = YES;
    self.confmPasswordTextField.secureTextEntry = YES;
    self.confmPasswordTextField.returnKeyType = UIReturnKeyNext;
    [self.scrollView addSubview:self.confmPasswordTextField];
    

}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
   
    NSDictionary *param = @{@"User[email]" : self.professorRegisterInfoView.emailTextField.text,
                            @"User[fullName]" : self.professorRegisterInfoView.fullNameTextField.text,
                            @"User[password]" : self.professorRegisterInfoView.passwordTextField.text,
                            @"User[confirmPassword]" : self.professorRegisterInfoView.confmPasswordTextField.text,
                            @"User[birthDate]" : self.professorRegisterInfoView.dobDateTextField.text,
                            @"User[phoneNumber]" : self.professorRegisterInfoView.phoneTextField.text,
                            @"User[position]" : self.professorRegisterInfoView.positionTextField.text,
                            @"User[photo]" : self.professorRegisterInfoView.profilePhoto};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_SAVE_NEW_USER withHTTPMethodType:HTTP_POST withParameters:param
                                       callback:^(NSDictionary *responseDic, NSError *error) {
                                           [self.view showLoading:NO];
                                           if (!error) {
                                           DLog(@"success 1 fields");
                                           [self.navigationController popViewControllerAnimated:YES];
                                           } else {
//                                               [[RestClient sharedClient] showErrorMessage:responseDic];
                                               ALERT(@"Error with saving profile.");
                                           }
                                       }];
}
//- (IBAction)profileImageClicked:(id)sender {
//    HomeViewTabBarController *dateVC = [[HomeViewTabBarController alloc]initWithNibName:@"HomeViewTabBarController.xib" bundle:nil];
//    UINavigationController *destNav = [[UINavigationController alloc] initWithRootViewController:dateVC];/*Here dateVC is controller you want to show in popover*/
//    dateVC.preferredContentSize = CGSizeMake(280,200);
//    destNav.modalPresentationStyle = UIModalPresentationPopover;
//    _dateTimePopover8 = destNav.popoverPresentationController;
//    _dateTimePopover8.delegate = self;
//    _dateTimePopover8.sourceView = self.view;
////    _dateTimePopover8.sourceRect = sender.frame;
//    destNav.navigationBarHidden = YES;
//    [self presentViewController:destNav animated:YES completion:nil];
//}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}
-(void)hideIOS8PopOver
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PickerPopover

- (void)pickerPopover:(PickerPopover *)pickerPopover didSelectedItem:(id)item atIndex:(NSInteger)index {
    CustomTextField *customTextField = pickerPopover.tagObject;
    customTextField.text = [item name];
    customTextField.tagObject = item;
    customTextField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    customTextField.layer.borderWidth = 1.f;

}
- (void)pickerPopover:(PickerPopover *)pickerPopover didChoosedDate:(NSDate *)date {
    pickerPopover.dateFormatter.dateFormat = SHORT_DATE_FORMAT;
    CustomTextField *customTextField = pickerPopover.tagObject;
    customTextField.tagObject = date;
    customTextField.text = [pickerPopover.dateFormatter stringFromDate:date];
    customTextField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    customTextField.layer.borderWidth = 1.f;
    
    [self textFieldDidEndEditing:customTextField];
    
    
}
#pragma mark - ItemsPopoverDelegate

- (void)itemsPopover:(ItemsPopover *)popover didSaveClickedWithItem:(id)item atIndex:(NSInteger)index {
    CustomTextField *customTextField = popover.senderControl;
    customTextField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    customTextField.layer.borderWidth = 1.f;
    customTextField.tagObject = item;
    customTextField.text = [item name];
    customTextField.selectedIndex = @(index);
    
}
#pragma UIPickerViewDataSource

//Columns in picker views

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {
    return 1;
}
//Rows in each Column

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    return self.pickerData.count;
}

#pragma  UIPickerViewDelegate

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    //Write the required logic here that should happen after you select a row in Picker View.
}

#pragma mark Base Info View Cases

- (void)baseInfoView:(ProfessorRegistrationInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value {
    switch (actionType) {
        case 1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-160) animated:YES];
            break;
        case -1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-300) animated:YES];
            break;
        case -2:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-200) animated:YES];
            break;
        case -3:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-390) animated:YES];
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
