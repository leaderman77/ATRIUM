//
//  AddGroupChatController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AddGroupChatController.h"
#import "GroupChatInfoView.h"

@interface AddGroupChatController ()<UITableViewDelegate, UITableViewDataSource, BaseInfoViewDelegate>
@property (nonatomic, strong) UITableView *groupTableView;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, retain) NSMutableArray *announcementTypes;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *activeTextField;
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (retain, nonatomic) UILabel *chatTitleLabel;
@property (strong, nonatomic) CustomTextField *chatTitleTextField;

@property (retain, nonatomic) UILabel *addMemberLabel;
@property (strong, nonatomic) CustomTextField *positionTextField;

@property (retain, nonatomic) UILabel *emailNameLabel;
@property (strong, nonatomic) CustomTextField *nameTextField;

@property (nonatomic, strong) GroupChatInfoView *groupChatInfoView;
@property (nonatomic, strong) NSString *groupID;
@end

@implementation AddGroupChatController

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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(255, 255, 255);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(@"New chat group") uppercaseString];
    titleButton.titleColor = rgbColor(37, 66, 97);
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
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
//        self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(255, 255, 255);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
//    self.announcementTypes = [[NSMutableArray alloc]initWithObjects:@"James Bont", @"Abrahm Lincoln", nil];
    
    //create faculty member select button
    CGFloat left = 10.f;
    CGFloat top = 0.f;
    
    self.groupChatInfoView = [[GroupChatInfoView alloc] initWithFrame:CGRectMake(left, top, 300, self.scrollView.height + 150)];
//        self.groupChatInfoView.layer.borderWidth = 2;
    self.groupChatInfoView.baseDelegate = self;
    self.groupChatInfoView.navigationController = self.navigationController;
    self.groupChatInfoView.viewController = self;
    [self.groupChatInfoView createAndLayoutSubviews];
    [self.scrollView addSubview:self.groupChatInfoView];
    
    self.scrollView.contentSize = CGSizeMake(0, 700);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
//    CGFloat left = 15.f;
//    
//    self.profileImageBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(left + 60, 0, 150, 150)];
//    //    self.profileImageBtn.layer.borderWidth = 2;
//    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.profileImageBtn.width, self.profileImageBtn.height)];
//    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.profileImageView.left = 0.5 * (self.profileImageBtn.width - self.profileImageView.width);
//    self.profileImageView.top = 0.5 * (self.profileImageBtn.height - self.profileImageView.height);
//    self.profileImageView.layer.cornerRadius = 0.5 * self.profileImageView.width;
//    self.profileImageView.layer.masksToBounds = YES;
//    //    self.profileImageView.layer.borderWidth = 1.0f;
//    //    self.profileImageView.layer.borderColor = [UIColor blueColor].CGColor;
//    self.profileImageView.backgroundColor = [UIColor whiteColor];
//    self.profileImageView.image = [UIImage imageNamed:@"add_photo_student.png"];
//    //    [self.profileImageView sd_setImageWithURL:self.patientPersonalDetails.photo.url placeholderImage:[UIImage imageNamed:@"addimage.png"]];
//    [self.profileImageBtn addSubview:self.profileImageView];
//    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
//    self.profileImageBtn.backgroundColor = [UIColor clearColor];
//    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    //    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
//    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
//    [self.profileImageBtn addTarget:self action:@selector(profileImageClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:self.profileImageBtn];
//
//    
//    [self createView];
}
- (void)createView {
    CGFloat left = 10.f;
    CGFloat top = 155.f;
    CGFloat labelWidth = 200;
    CGFloat labelHeight = 20.f;
    CGFloat textFieldWidth = 280;
    CGFloat textFieldHeight = 40.f;
    
    self.chatTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
    //    self.fullNameLabel.layer.borderWidth = 2;
    self.chatTitleLabel.font = FONT_SANSUMI_BOLD(15);
    self.chatTitleLabel.textColor = rgbColor(37, 66, 97);
    self.chatTitleLabel.text = [TRANSLATE(@"Group chat title") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.chatTitleLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.chatTitleLabel];
    
    self.chatTitleTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top + 25, textFieldWidth, textFieldHeight)];
    self.chatTitleTextField.delegate = self;
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.chatTitleTextField.backgroundColor = rgbColor(237, 244, 250);
    self.chatTitleTextField.font = FONT_SANSUMI(20);
    self.chatTitleTextField.textColor = rgbColor(121, 143, 172);
    //    self.fullNameTextField.placeholder = [TRANSLATE(@"Type in your full name") uppercaseString];
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.chatTitleTextField.leftView = paddingView1;
    self.chatTitleTextField.leftViewMode = UITextFieldViewModeAlways;
    self.chatTitleTextField.layer.cornerRadius = 5.f;
    self.chatTitleTextField.layer.masksToBounds = YES;
    self.chatTitleTextField.returnKeyType = UIReturnKeyNext;
    [self.scrollView addSubview:self.chatTitleTextField];
    
    self.addMemberLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top + 70, labelWidth, labelHeight)];
    //    self.fullNameLabel.layer.borderWidth = 2;
    self.addMemberLabel.font = FONT_SANSUMI_BOLD(15);
    self.addMemberLabel.textColor = rgbColor(37, 66, 97);
    self.addMemberLabel.text = [TRANSLATE(@"Add members") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.addMemberLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.addMemberLabel];
    
    self.groupTableView = [[UITableView alloc] initWithFrame:CGRectMake(left, top + 90, textFieldWidth, 80) style:UITableViewStyleGrouped];
//    self.tableView.layer.borderWidth = 2;
    self.groupTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.groupTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.groupTableView.rowHeight = 50.f;
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.groupTableView.delegate = self;
    self.groupTableView.dataSource = self;
    self.groupTableView.backgroundColor = rgbColor(255, 255, 255);
    [self.scrollView addSubview:self.groupTableView];
    
    self.nameTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top + 185, textFieldWidth, textFieldHeight)];
    self.nameTextField.delegate = self;
    //    self.emailTextField.placeholder = [TRANSLATE(@"Sample@email.com") uppercaseString];
    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.nameTextField.backgroundColor = rgbColor(237, 244, 250);
    self.nameTextField.font = FONT_SANSUMI(20);
    self.nameTextField.textColor = rgbColor(121, 143, 172);
    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.nameTextField.leftView = paddingView2;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.nameTextField.layer.cornerRadius = 5.f;
    self.nameTextField.layer.masksToBounds = YES;
    self.nameTextField.returnKeyType = UIReturnKeyNext;
    self.nameTextField.placeholder = [TRANSLATE(@"Enter name") uppercaseString];
    self.nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.scrollView addSubview:self.nameTextField];
    
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
    
    NSDictionary *param = @{@"Groupchat[title]" : self.groupChatInfoView.chatTitleTextField.text,
                            @"Groupchat[creator]" : userId,
                            @"Groupchat[photo]" : self.groupChatInfoView.profilePhoto};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_ADD_GROUP_CHAT withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                           DLog(@"success 1 fields");
                                           [self.view showLoading:NO];
                                           if (!error && [responseDic[@"status"] integerValue] == 1) {
                                               self.groupID = [[responseDic valueForKey:@"data"] valueForKey:@"id"];
                                               self.groupChatInfoView.groupID = self.groupID;
                                               if ([self.delegate respondsToSelector:@selector(callAppMethodOfGroupChatLists)]) {
                                                   [self.delegate callAppMethodOfGroupChatLists];
                                               }
                                               
//                                               [self.navigationController popViewControllerAnimated:YES];
                                               
                                           } else {
                                               [[RestClient sharedClient] showErrorMessage:responseDic];
//                                               ALERT(@"Error with saving profile.");
                                           }
                                       }];
    
    
}
- (IBAction)profileImageClicked:(id)sender {
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.announcementTypes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBLeftSideViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //    cell.contentView.layer.borderWidth = 2;
    cell.textLabel.text = self.announcementTypes[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark Base Info View Cases

- (void)baseInfoView:(GroupChatInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value {
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
            [self.scrollView setContentOffset:CGPointMake(0, self.activeTextField.center.y-250) animated:YES];
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
