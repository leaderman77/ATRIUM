//
//  ProfessorAccountController.m
//  ATRIUM
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "ProfessorAccountController.h"
#import "AuthorizationController.h"
#import "ProfessorProfileInfoView.h"

@interface ProfessorAccountController () <BaseInfoViewDelegate, UIAlertViewDelegate, ProfessorProfileInfoViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ProfessorProfileInfoView *professorProfileInfoView;
@property (nonatomic, strong) UITextField *activeTextField;

@property (nonatomic, strong) UIButton *approveButton;
@property (strong, nonatomic) UIButton *logoutButton;
@end

@implementation ProfessorAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    [self.professorProfileInfoView populateProfessorProfileDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    NSUserDefaults *loginDetails = [NSUserDefaults standardUserDefaults];
    NSString *fullName = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"fullName"];
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 25, 230, 30)];
    titleButton.text = [TRANSLATE(fullName) uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
//    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
//    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
//    backImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [backButton addSubview:backImageView];
//    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.topView addSubview:backButton];
    
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
- (void)configureControls {
//    [super configureControls];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height + 30)];
//        self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(22, 168, 235);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    CGFloat top = 0;
    CGFloat left = 10;
    
    self.professorProfileInfoView = [[ProfessorProfileInfoView alloc] initWithFrame:CGRectMake(left, top, 300, 317)];
    //    self.studentProfileInfoView.layer.borderWidth = 2;
    self.professorProfileInfoView.baseDelegate = self;
    self.professorProfileInfoView.navigationController = self.navigationController;
    self.professorProfileInfoView.viewController = self;
    self.professorProfileInfoView.professorProfileInfoViewDelegate = self;
    self.professorProfileInfoView.isViewMode = self.isViewMode;
    [self.professorProfileInfoView createAndLayoutSubviews];
    [self.scrollView addSubview:self.professorProfileInfoView];
    
    CGFloat buttonWidth = 150;
    CGFloat buttonHeight = 40;
    
    self.logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(left + 70, self.professorProfileInfoView.height, buttonWidth, buttonHeight)];
    self.logoutButton.layer.cornerRadius = 5.f;
    self.logoutButton.backgroundColor = rgbColor(255, 255, 255);
    self.logoutButton.titleColor = rgbColor(22, 168, 235);
    self.logoutButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    self.logoutButton.title = [TRANSLATE(@"Log out") uppercaseString];
    self.logoutButton.enabled = YES;
    [self.logoutButton addTarget:self action:@selector(logoutButtonCLicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.logoutButton];
    
    self.scrollView.contentSize = CGSizeMake(0, 550);
    self.scrollView.scrollEnabled = YES;
    //    [self.scrollView setContentOffset:CGPointMake(0, 600) animated:YES];
}
- (void)presentImagePickerController:(UIImagePickerController *)imagePickerController {
//    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    if ([self.professorProfileDelegate respondsToSelector:@selector(presentController:)]) {
        [self.professorProfileDelegate presentController:imagePickerController];
    }
}
- (void)dismissImagePickerController:(UIImagePickerController *)pickerController {
    if ([self.professorProfileDelegate respondsToSelector:@selector(dismissController:)]) {
        [self.professorProfileDelegate dismissController:pickerController];
    }
}
- (void)isEditButtonClicked:(id)sender {
    if (_isViewMode) {
        self.isViewMode = NO;
        self.professorProfileInfoView.isViewMode = NO;
        [self configureNavigationBar];
    } else {
        self.isViewMode = YES;
        [self configureNavigationBar];
        self.professorProfileInfoView.isViewMode = YES;
        
    }
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    
    [self.view showLoading:YES];
    
    NSDictionary *param = @{@"User[email]" : self.professorProfileInfoView.emailTextField.text,
                            @"User[birthDate]" : self.professorProfileInfoView.dobDateTextField.text,
                            @"User[phoneNumber]" : self.professorProfileInfoView.phoneTextField.text,
                            @"User[position]" : self.professorProfileInfoView.positionTextField.text,
                            @"User[photo]" : self.professorProfileInfoView.profilePhoto};

    [[RestClient sharedFormClient] callMethodByPath:METHOD_CHANGE_PROFESSOR_PROFILE withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   self.professorProfileInfoView.isViewMode = YES;
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
                                                   
                                                   self.isViewMode = YES;
                                                   [self configureNavigationBar];
                                                   [self.professorProfileInfoView populateProfessorProfileDetails];
                                                   
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
        NSUserDefaults *userDefault3 = [NSUserDefaults standardUserDefaults];
        [userDefault3 removeObjectForKey:@"userID"];
        
        NSUserDefaults *userDefault6 = [NSUserDefaults standardUserDefaults];
        [userDefault6 removeObjectForKey:@"position"];
        
        AuthorizationController *authorizationController = [[AuthorizationController alloc]init];
        if ([self.professorProfileDelegate respondsToSelector:@selector(backController:)]) {
            [self.professorProfileDelegate backController:authorizationController];
        }
    }
}
#pragma mark Base Info View Cases

- (void)baseInfoView:(ProfessorProfileInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value {
    switch (actionType) {
        case 1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-160) animated:YES];
            break;
        case -1:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-252) animated:YES];
            break;
        case -2:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-170) animated:YES];
            break;
        case -3:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-295) animated:YES];
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
