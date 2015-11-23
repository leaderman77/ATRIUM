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
#import "AddNewsToGroupController.h"
#import "GroupNewsDetailsController.h"

@interface GroupDetailsController ()<UITableViewDataSource, UITableViewDelegate, AddNewsToGroupDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UITableView *detailsTableView;

@property (nonatomic, strong) NSArray *newsTitle;


@property (nonatomic, strong) NSArray *newsText;

@property (nonatomic, strong) NSArray *newsAllDate;

@property (nonatomic, strong) NSArray *newsPhoto;


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
- (void)callApiMethods {
    DLog(@"group details call api method called");
    //todo add signature validating before submit!!
    
    [self.view showLoading:YES];
    NSDictionary *param = @{@"id" : self.groupID};
    [[RestClient sharedFormClient] callMethodByPath:METHOD_GROUP_BY_ID withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               DLog(@"success 1 fields");
                                               [self.view showLoading:NO];
                                               if (!error && [responseDic[@"status"] integerValue] == 1) {
                                                   self.news = [[responseDic valueForKey:@"data"] valueForKey:@"news"];
                                                   self.newsAllDate = [[responseDic valueForKey:@"data"] valueForKey:@"updatedAt"];
                                                   int count;
                                                   for (count = 0; count < self.news.count; count++) {
                                                       self.newsTitle = [[[[responseDic valueForKey:@"data"] valueForKey:@"news"] objectAtIndex:count] valueForKey:@"title"];
                                                    
                                                       
                                                       self.newsText = [[[[responseDic valueForKey:@"data"] valueForKey:@"news"] objectAtIndex:count] valueForKey:@"text"];
                                                       
                                                       
                                                       self.newsPhoto = [[[[responseDic valueForKey:@"data"] valueForKey:@"news"] objectAtIndex:count] valueForKey:@"image"];
                                                       
                                                   }
                                                   
                                                   [self configureControls];
                                               } else {
                                                   [[RestClient sharedClient] showErrorMessage:responseDic];
                                                   //                                               ALERT(@"Error with saving profile.");
                                               }
                                           }];
    
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
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width - 15, backButton.height - 10)];
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
    NSString *posts = [NSString stringWithFormat:@"%lu",(unsigned long)self.newsTitle.count];
    NSString *postNumString = TRANSLATE(posts);
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
    
    
    //create table vew
    self.detailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 280) style:UITableViewStylePlain];
//    self.detailsTableView.layer.borderWidth = 2;
    self.detailsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.detailsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.detailsTableView.rowHeight = 60.f;
    self.detailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.detailsTableView setDataSource:self];
    [self.detailsTableView setDelegate:self];
    self.detailsTableView.backgroundColor = [UIColor clearColor];
//    [self.detailsTableView registerClass:[GroupDetailsCell class] forCellReuseIdentifier: @"GroupDetailsCell"];
    [self.view addSubview:self.detailsTableView];
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addButtonClicked:(id)sender {
    AddNewsToGroupController *addNewsToGroupController = [[AddNewsToGroupController alloc]init];
    addNewsToGroupController.groupID = self.groupID;
    addNewsToGroupController.delegate = self;
    [self.navigationController pushViewController:addNewsToGroupController animated:YES];
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
    return 0.0001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.newsTitle.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupDetailsCell *cell = [GroupDetailsCell cellForTableView:tableView withItem:nil];
    cell.baseDelegate = self;
    cell.indexPath = indexPath;
    NSString *string = [NSString stringWithFormat:@"%@", [self.newsAllDate objectAtIndex:0]];
    NSString *stringDate = [string substringToIndex:[string length] - 14];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:stringDate];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"dd.MM.yyyy"];
    cell.dateLabel.text = [formatter1 stringFromDate:date];
    cell.detailsLabel.text = self.newsTitle[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupNewsDetailsController *groupNewsDetailsController = [[GroupNewsDetailsController alloc]init];
    self.photoUrl = self.newsPhoto[indexPath.row];
    groupNewsDetailsController.photoUrl = self.photoUrl;
    groupNewsDetailsController.groupNewsTitle = self.newsTitle[indexPath.row];
    groupNewsDetailsController.groupNewstext = self.newsText[indexPath.row];
    [self.navigationController pushViewController:groupNewsDetailsController animated:YES];
}
- (void)callApiGroupRefreshMethod {
    [self callApiMethods];
    [self configureControls];
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
