//
//  GroupDetailsController.m
//  ATRIUM
//
//  Created by Admin on 11/11/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "GroupDetailsController.h"
#import "GroupDetailsCell.h"
#import "ChatsBottomViewController.h"

@interface GroupDetailsController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UITableView *detailsTableView;

@property (nonatomic, strong) NSMutableArray *detailsCell;
@property (nonatomic, strong) NSMutableArray *dateCell;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) CustomBtn *profileImageBtn;

@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UILabel *postsLabel;
@property (nonatomic, strong) UILabel *followersLabel;

@property (nonatomic, strong) UITextField *activeTextField;
@end

@implementation GroupDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureNavigationBar];
    [self configureControls];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController.tabBar removeFromSuperview];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(self.groupName) uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 16, 20)];
//    backButton.layer.borderWidth = 1;
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
//    backImageView.layer.borderWidth = 1;
    [backImageView setImage:[UIImage imageNamed:@"arrow_icon.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    UIButton *approveButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 25, 25, 30)];
    UIImageView *approveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, approveButton.width - 10, approveButton.height)];
    [approveImageView setImage:[UIImage imageNamed:@"add.png"]];
    approveImageView.contentMode = UIViewContentModeScaleAspectFill;
    [approveButton addSubview:approveImageView];
    [approveButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:approveButton];
    
    [self.view addSubview:self.topView];
}

- (void)configureControls {
    
    //create faculty member select button
    CGFloat left = 0.f;
    CGFloat top = 60.f;
    
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(left, top, self.view.bounds.size.width, 140)];
    self.mainView.backgroundColor = rgbColor(22, 168, 235);
    [self.view addSubview:self.mainView];
    
    left = 20;
    top = 10;
    
    self.profileImageBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(left, top, 90, 90)];
    //        self.profileImageBtn.layer.borderWidth = 2;
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.profileImageBtn.width, self.profileImageBtn.height)];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.left = 0.5 * (self.profileImageBtn.width - self.profileImageView.width);
    self.profileImageView.top = 0.5 * (self.profileImageBtn.height - self.profileImageView.height);
    self.profileImageView.layer.cornerRadius = 0.5 * self.profileImageView.width;
    self.profileImageView.layer.masksToBounds = YES;
    //    self.profileImageView.layer.borderWidth = 1.0f;
    //    self.profileImageView.layer.borderColor = [UIColor blueColor].CGColor;
    self.profileImageView.backgroundColor = rgbColor(22, 168, 235);
//    self.profileImageView.image = [UIImage imageNamed:@"rained-red-rose-flowers-34592998-960-639.jpg"];
    [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]];
    [self.profileImageBtn addSubview:self.profileImageView];
    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
    self.profileImageBtn.backgroundColor = rgbColor(22, 168, 235);
    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
//    [self.profileImageBtn addTarget:self action:@selector(addPhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.profileImageBtn];
    
    self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(left + 120, top, 100, 40)];
    UIImageView *followImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _followButton.width, _followButton.height)];
    if (self.userType == 0) {
        [followImageView setImage:[UIImage imageNamed:@"admin_button_never_active.png"]];
        self.followButton.enabled = NO;
    } else if (self.userType == 1) {
        [followImageView setImage:[UIImage imageNamed:@"unfollow_group_button.png"]];
    } else {
        [followImageView setImage:[UIImage imageNamed:@"follow_group_button.png"]];
    }
    
    followImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.followButton addSubview:followImageView];
    [self.followButton addTarget:self action:@selector(followButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.followButton];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + 106, top + 40, 200, 50)];
//    self.textLabel.layer.borderWidth = 1;
    self.textLabel.numberOfLines = 0.f;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.layer.cornerRadius = 0.5;
    self.textLabel.layer.masksToBounds = YES;
    
    NSString *title = @"What is going on with the play";
    NSMutableAttributedString *facultyTitle = [[NSMutableAttributedString alloc]
                                               initWithAttributedString:[NSAttributedString attributedStringWithTitle:title
                                                                                                        withTextColor:rgbColor(37, 66, 97) withFontSize:10]];
    NSString *additionalTitle = @" \nwe are rehearsing?";
    NSMutableAttributedString *facultyTitle2 = [[NSMutableAttributedString alloc]
                                                initWithAttributedString:[NSAttributedString attributedStringWithTitle:additionalTitle
                                                                                                         withTextColor:rgbColor(37, 66, 97) withFontSize:10]];
    [facultyTitle appendAttributedString:facultyTitle2];
    self.textLabel.attributedText = facultyTitle;

    self.textLabel.backgroundColor = [UIColor clearColor];
//    self.textLabel.font = FONT_SANSUMI(10);
//    self.textLabel.textColor = rgbColor(37, 66, 97);
    [self.mainView addSubview:self.textLabel];
    
    self.postsLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top + 90, 100, 30)];
//    self.postsLabel.layer.borderWidth = 1;
    self.postsLabel.layer.cornerRadius = 0.5;
    self.postsLabel.layer.masksToBounds = YES;
    self.postsLabel.backgroundColor = [UIColor clearColor];
    
    NSString *postNumString = TRANSLATE(self.groupPosts);
    NSMutableAttributedString *postNum = [[NSMutableAttributedString alloc]
                                               initWithAttributedString:[NSAttributedString attributedStringWithTitle:postNumString withTextColor:[UIColor whiteColor] withBoldFontSize:15]];
    NSString *postString = [TRANSLATE(@" Posts") uppercaseString];
    NSMutableAttributedString *postText = [[NSMutableAttributedString alloc]
                                                initWithAttributedString:[NSAttributedString attributedStringWithTitle:postString withTextColor:[UIColor whiteColor] withBoldFontSize:13]];
    [postNum appendAttributedString:postText];
    self.postsLabel.attributedText = postNum;
    
//    self.postsLabel.text = [TRANSLATE(@"250 Posts") uppercaseString];
//    self.postsLabel.font = FONT_SANSUMI_BOLD(12);
//    self.postsLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:self.postsLabel];
    
    self.followersLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + 170, top + 90, 130, 30)];
//    self.followersLabel.layer.borderWidth = 1;
    self.followersLabel .layer.cornerRadius = 0.5;
    self.followersLabel .layer.masksToBounds = YES;
    self.followersLabel .backgroundColor = [UIColor clearColor];
    NSString *followersString = TRANSLATE(self.groupFollowers);
    NSMutableAttributedString *followersNum = [[NSMutableAttributedString alloc]
                                          initWithAttributedString:[NSAttributedString attributedStringWithTitle:followersString withTextColor:[UIColor whiteColor] withBoldFontSize:15]];
    NSString *followersTring2 = [TRANSLATE(@" Followers") uppercaseString];
    NSMutableAttributedString *followersText = [[NSMutableAttributedString alloc]
                                           initWithAttributedString:[NSAttributedString attributedStringWithTitle:followersTring2 withTextColor:[UIColor whiteColor] withBoldFontSize:13]];
    [followersNum appendAttributedString:followersText];
    self.followersLabel.attributedText = followersNum;
    
//    self.followersLabel .text = [TRANSLATE(@"25 Followers") uppercaseString];
//    self.followersLabel .font = FONT_SANSUMI_BOLD(12);
//    self.followersLabel .textColor = [UIColor whiteColor];         //colorWithRGB(25, 94, 180);
    [self.mainView addSubview:self.followersLabel ];
    
//    self.dateCell = [[NSMutableArray array] initWithObjects:@"12.12.1992", @"12.12.1992", nil];
//    self.detailsCell = [[NSMutableArray alloc]initWithObjects:@"Text", @"Text", nil];
    //create table vew
    self.detailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 125) style:UITableViewStyleGrouped];
    //    self.chatTableView.layer.borderWidth = 2;
    self.detailsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.detailsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.detailsTableView.rowHeight = 60.f;
    self.detailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.detailsTableView setDataSource:self];
    [self.detailsTableView setDelegate:self];
    self.detailsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.view.frame.size.width, 10.0f)];
    self.detailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detailsTableView.backgroundColor = [UIColor clearColor];
    [self.detailsTableView registerClass:[GroupDetailsCell class] forCellReuseIdentifier: @"GroupDetailsCell"];
    [self.view addSubview:self.detailsTableView];
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addButtonClicked:(id)sender {
    
}
- (void)followButtonClicked:(id)sender {
    DLog(@"group add member method clicked");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
    
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    if (self.userType == 1) {
        NSDictionary *param = @{@"id" : self.groupID,
                                @"user" : userId};
        
        [[RestClient sharedFormClient] callMethodByPath:METHOD_REMOVE_GROUP_MEMBER withHTTPMethodType:HTTP_POST withParameters:param
                                               callback:^(NSDictionary *responseDic, NSError *error) {
                                                   DLog(@"success 1 fields");
                                                   [self.view showLoading:NO];
                                                   if (!error && [responseDic[@"status"] integerValue] == 1) {
                                                       self.userType = 2;
                                                       [self configureControls];
                                                   } else {
                                                       [[RestClient sharedClient] showErrorMessage:responseDic];
                                                       //                                               ALERT(@"Error with saving profile.");
                                                   }
                                               }];

    } else {
        NSDictionary *param = @{@"id" : self.groupID,
                                @"user" : userId};
        
        [[RestClient sharedFormClient] callMethodByPath:METHOD_ADD_GROUP_MEMBER withHTTPMethodType:HTTP_POST withParameters:param
                                               callback:^(NSDictionary *responseDic, NSError *error) {
                                                   DLog(@"success 1 fields");
                                                   [self.view showLoading:NO];
                                                   if (!error && [responseDic[@"status"] integerValue] == 1) {
                                                       self.userType = 1;
                                                       [self configureControls];
                                                   } else {
                                                       [[RestClient sharedClient] showErrorMessage:responseDic];
                                                       //                                               ALERT(@"Error with saving profile.");
                                                   }
                                               }];

    }
    if ([self.delegate respondsToSelector:@selector(callApiChatsRefreashMethod)]) {
        [self.delegate callApiChatsRefreashMethod];
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.detailsCell.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupDetailsCell *cell = [GroupDetailsCell cellForTableView:tableView withItem:nil];
    cell.baseDelegate = self;
    cell.indexPath = indexPath;
    cell.dateLabel.text = self.dateCell[indexPath.row];
    cell.detailsLabel.text = self.detailsCell[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AnnouncementDetailsController *announcementDetailsController = [[AnnouncementDetailsController alloc]init];
//    if ([self.announceDelegate respondsToSelector:@selector(openAnnounceDetailsController:)]) {
//        [self.announceDelegate openAnnounceDetailsController:announcementDetailsController];
//    }
    //    [self.navigationController pushViewController:announcementDetailsController animated:YES];
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
