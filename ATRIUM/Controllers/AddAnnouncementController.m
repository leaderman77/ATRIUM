//
//  AddAnnouncementController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AddAnnouncementController.h"
#import "AnnouncementInfoView.h"

@interface AddAnnouncementController () <BaseInfoViewDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (retain, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) CustomTextField *titleTextField;

@property (retain, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UITextView *descriptionTextView;

@property (nonatomic, strong) AnnouncementInfoView *announcementInfoView;
@property (nonatomic, strong) UITextField *activeTextField;
@end

@implementation AddAnnouncementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureControls];
    [self configureNavigationBar];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

//    self.navigationController.navigationBar.barTintColor = rgbColor(255, 255, 255);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(@"New announcement") uppercaseString];
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
    
    
    
    UIButton *approveButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 25, 30, 30)];
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 55, self.view.bounds.size.width, self.view.bounds.size.height)];
//    self.scrollView.layer.borderWidth = 2;
//    self.scrollView.top = kPortraitNavbarHeight + 50;
//    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(255, 255, 255);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    //create faculty member select button
    CGFloat left = 10.f;
    CGFloat top = 0.f;
    
    self.announcementInfoView = [[AnnouncementInfoView alloc] initWithFrame:CGRectMake(left, top, 300, self.scrollView.height)];
    //    self.professorRegisterInfoView.layer.borderWidth = 2;
    self.announcementInfoView.baseDelegate = self;
    self.announcementInfoView.navigationController = self.navigationController;
    self.announcementInfoView.viewController = self;
    [self.announcementInfoView createAndLayoutSubviews];
    [self.scrollView addSubview:self.announcementInfoView];
    
    self.scrollView.contentSize = CGSizeMake(0, 650);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (IBAction)backButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(callAppMethodOfAnnounce)]) {
        [self.delegate callAppMethodOfAnnounce];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
    
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    
    [paramsDic addEntriesFromDictionary:@{@"Ad[title]" : self.announcementInfoView.titleTextField.text,
                                          @"Ad[text]" : self.announcementInfoView.descriptionTextView.text,
                                          @"Ad[photo]" : self.announcementInfoView.profilePhoto,
                                          @"user" : userId}];
    //
    [[RestClient sharedFormClient] callMethodByPath:METHOD_ADD_ANNOUNCEMENT withHTTPMethodType:HTTP_POST withParameters:paramsDic
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   if ([self.delegate respondsToSelector:@selector(callAppMethodOfAnnounce)]) {
                                                       [self.delegate callAppMethodOfAnnounce];
                                                   }
                                                   [self.navigationController popViewControllerAnimated:YES];
                                               } else {
                                                   //                                               [[RestClient sharedClient] showErrorMessage:responseDic];
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];
    
}

- (IBAction)profileImageClicked:(id)sender {
    
}
#pragma mark Base Info View Cases

- (void)baseInfoView:(AnnouncementInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value {
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
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-320) animated:YES];
            break;
        case -3:
            self.activeTextField = value;
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-200) animated:YES];
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
