//
//  StudentAccountController.m
//  ATRIUM
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "StudentAccountController.h"
#import "StudentProfileInfoView.h"
#import "AuthorizationController.h"

@interface StudentAccountController () <UIAlertViewDelegate, BaseInfoViewDelegate, StudentProfileInfoViewDelegate>
@property (nonatomic, strong) UIView *top;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *approveButton;

@property (nonatomic, strong) UIImageView *approveImageView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) StudentProfileInfoView *studentProfileInfoView;

@property (strong, nonatomic) UIButton *logoutButton;
@property (nonatomic, strong) UITextField *activeTextField;
@end

@implementation StudentAccountController
@synthesize isViewMode = _isViewMode;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    
    [self.studentProfileInfoView populateProfessorProfileDetails];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360, 60)];
    self.topView.backgroundColor = rgbColor(255, 255, 255);
    
    NSUserDefaults *loginDetails = [NSUserDefaults standardUserDefaults];
    NSString *fullName = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"fullName"];
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(fullName) uppercaseString];
    titleButton.titleColor = rgbColor(0, 65, 107);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    self.approveButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 25, 30, 30)];
    self.approveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.approveButton.width, self.approveButton.height)];
    [self.approveImageView setImage:self.isViewMode ? [UIImage imageNamed:@"navig_bar_edit.png"] : [UIImage imageNamed:@"navig_bar_save_changes.png"]];
    self.approveImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.approveButton addSubview:self.approveImageView];
    [self.approveButton addTarget:self action:@selector(isEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.approveButton];
    
    [self.view addSubview:self.topView];
}
- (void)setIsViewMode:(BOOL)isViewMode {
    _isViewMode = isViewMode;
     self.studentProfileInfoView.isViewMode = _isViewMode;
}
- (void)configureControls {
//    [super configureControls];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height + 10)];
//        self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(255, 255, 255);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    CGFloat top = 0;
    CGFloat left = 10;
    
    self.studentProfileInfoView = [[StudentProfileInfoView alloc] initWithFrame:CGRectMake(left, top, 300, 300)];
//    self.studentProfileInfoView.layer.borderWidth = 2;
    self.studentProfileInfoView.baseDelegate = self;
    self.studentProfileInfoView.navigationController = self.navigationController;
    self.studentProfileInfoView.viewController = self;
    self.studentProfileInfoView.studentProfileInfoViewDelegate = self;
    self.studentProfileInfoView.isViewMode = self.isViewMode;
    [self.studentProfileInfoView createAndLayoutSubviews];
    [self.scrollView addSubview:self.studentProfileInfoView];
    
    CGFloat buttonWidth = 150;
    CGFloat buttonHeight = 40;
    
    self.logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(left + 70, self.studentProfileInfoView.height, buttonWidth, buttonHeight)];
    self.logoutButton.layer.cornerRadius = 5.f;
    self.logoutButton.backgroundColor = rgbColor(21, 170, 236);
    self.logoutButton.titleColor = rgbColor(255, 255, 255);
    self.logoutButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    self.logoutButton.title = [TRANSLATE(@"Log out") uppercaseString];
    self.logoutButton.enabled = YES;
    [self.logoutButton addTarget:self action:@selector(logoutButtonCLicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.logoutButton];
    
    self.scrollView.contentSize = CGSizeMake(0, 550);
    self.scrollView.scrollEnabled = !self.isViewMode;
//    [self.scrollView setContentOffset:CGPointMake(0, 600) animated:YES];

}
- (void)isEditButtonClicked:(id)sender {
    if (_isViewMode) {
        self.isViewMode = NO;
        self.studentProfileInfoView.isViewMode = NO;
        [self configureNavigationBar];
    } else {
        self.isViewMode = YES;
        [self configureNavigationBar];
        [self.approveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
     self.scrollView.scrollEnabled = !self.isViewMode;
}
- (void)presentImagePickerController:(UIImagePickerController *)imagePickerController {
    //    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    if ([self.studentProfileDelegate respondsToSelector:@selector(presentController:)]) {
        [self.studentProfileDelegate presentController:imagePickerController];
    }
}
- (void)dismissImagePickerController:(UIImagePickerController *)pickerController {
    if ([self.studentProfileDelegate respondsToSelector:@selector(dismissController:)]) {
        [self.studentProfileDelegate dismissController:pickerController];
    }
}

- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
    NSDictionary *param = @{@"User[email]" : self.studentProfileInfoView.emailTextField.text,
                            @"User[birthDate]" : self.studentProfileInfoView.dobDateTextField.text,
                            @"User[phoneNumber]" : self.studentProfileInfoView.phoneTextField.text,
                            @"User[position]" : @"Student",
                            @"User[position]" : self.studentProfileInfoView.profilePhoto};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_CHANGE_PROFESSOR_PROFILE withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   self.studentProfileInfoView.isViewMode = YES;
                                                   NSArray *array = [[NSArray alloc]init];
                                                   array = [[[responseDic objectForKey:@"data"] objectAtIndex:0] objectForKey:@"position"];
                                                   
                                                   NSString *position = [NSString stringWithFormat:@"%@", array];
                                                   NSUserDefaults *positionUserDefaults = [NSUserDefaults standardUserDefaults];
                                                   [positionUserDefaults setObject:position forKey:@"position"];
                                                   [positionUserDefaults synchronize];
                                                   
                                                   
                                                   NSArray *array1 = [[NSArray alloc]init];
                                                   array1 = [[responseDic objectForKey:@"data"] objectAtIndex:0];
                                                   
                                                   DLog(@"%@", array1);
                                                   
                                                   NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                                   [userDefaults setObject:array1 forKey:@"loginDetails"];
                                                   [userDefaults synchronize];
                                                   
                                                   [self.studentProfileInfoView populateProfessorProfileDetails];
                                               } else {
                                                   [[RestClient sharedClient] showErrorMessage:responseDic];
                                                   //                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];
    
}
- (void)logoutButtonCLicked:(id)sender {
    DLog(@"Log Out Button Clicked!");
    
    //    ALERT_TITLE_AND_MESSAGE(@"Logging out", @"Are you sure you want to log out?");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:TRANSLATE(@"Logging out")
                                                        message:TRANSLATE(@"Are you sure you want to log out?")
                                                       delegate:self
                                              cancelButtonTitle:[TRANSLATE(@"Cancel") uppercaseString]
                                              otherButtonTitles:[TRANSLATE(@"Ok") uppercaseString], nil];
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    } else {
        NSUserDefaults *userDefault4 = [NSUserDefaults standardUserDefaults];
        [userDefault4 removeObjectForKey:@"userID"];
        
        NSUserDefaults *userDefault5 = [NSUserDefaults standardUserDefaults];
        [userDefault5 removeObjectForKey:@"position"];
        
        AuthorizationController *authorizationController = [[AuthorizationController alloc]init];
        if ([self.studentProfileDelegate respondsToSelector:@selector(backController:)]) {
            [self.studentProfileDelegate backController:authorizationController];
        }
    }
}

#pragma mark Base Info View Cases

- (void)baseInfoView:(StudentProfileInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value {
    switch (actionType) {
        case 1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-160) animated:YES];
            break;
        case -1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-230) animated:YES];
            break;
        case -2:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-270) animated:YES];
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
