//
//  ChatsController.m
//  ATRIUM
//
//  Created by Admin on 10/13/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "ChatsController.h"
#import "ChatsBottomView.h"
#import "BaseRightSearchView.h"
#import "ChatsBottomViewController.h"
#import "AddGroupChatController.h"
#import "AddGroupController.h"
#import "UserChatController.h"
#import "GroupDetailsController.h"

@interface ChatsController ()<UITableViewDelegate, UITableViewDataSource, BaseRightSearchViewDelegate, AddGroupDelegate, AddGroupChatDelegate, GroupDetailsDelegate>
@property (nonatomic, strong) UITableView *chatsListTableView;
@property (nonatomic, strong) UIView *topView;

@property (retain, nonatomic) UILabel *sectionLabel;

@property (nonatomic, retain) NSMutableArray *chatsTypes;

@property (nonatomic, retain) NSMutableArray *avatarTypes;
@property (nonatomic, retain) NSMutableArray *occupation;

@property (nonatomic, retain) NSMutableArray *listSection;
@property (nonatomic, retain) UIToolbar *toolbar;

@property (nonatomic, strong) ChatsBottomView *chatsView;
@property (nonatomic, strong) NSMutableArray *rightSearchViews;

@property (nonatomic, retain) UIButton *chatsSearchButton;
@property (nonatomic, retain) NSArray *groupChatID;
@property (nonatomic, retain) NSArray *groupChatTitle;
@property (nonatomic, retain) NSArray *groupChatNumOfMembers;
@property (nonatomic, retain) NSMutableArray *groupChatAllMembers;
@property (nonatomic, retain) NSArray *groupTitle;
@property (nonatomic, retain) NSMutableArray *allCreatorID;
@property (nonatomic, retain) NSArray *creatorID;
@property (nonatomic, retain) NSArray *groupPhoto;
@property (nonatomic, retain) NSArray *groupChatPhoto;
@property (nonatomic, strong) NSURL *photoUrl;


@property (nonatomic, retain) NSMutableArray *groupFollowers;
@property (nonatomic, retain) NSArray *groupFollower;
@property (strong, nonatomic) NSArray *groupID;
@property (strong, nonatomic) NSArray *posts;

@property (nonatomic, strong) NSString *userID;
@end

@implementation ChatsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgbColor(255, 255, 255);
    
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    self.userID = [userdefaults2 objectForKey:@"userID"];
    
    // Do any additional setup after loading the view.
    self.chatsTypes = [[NSMutableArray alloc]init];
    self.occupation = [[NSMutableArray alloc]init];
    self.avatarTypes = [[NSMutableArray alloc]init];
    self.allCreatorID = [[NSMutableArray alloc]init];
    self.groupFollowers = [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    
    [self configureControls];
    [self configureNavigationBar];
    
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSString *fullName = [notification.userInfo valueForKey:@"fullName"];
    NSString *position = [notification.userInfo valueForKey:@"position"];
    NSURL *photo = [notification.userInfo valueForKey:@"photo"];
    
    [self.chatsTypes addObject:fullName];
    [self.occupation addObject:position];
    [self.avatarTypes addObject:photo];
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
    [self.chatsListTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self callAppMethodOfGroupChatLists];
    [self callAppMethodOfChatLists];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)callApiMethods {
    [self.view showLoading:YES];
    
    NSDictionary *param = @{@"user" : self.userID};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_GROUP_CHAT withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   NSArray *array = [responseDic valueForKey:@"data"];
                                                   if (array.count == 0) {
                                                       return;
                                                   } else {
                                                       self.groupChatID = [[responseDic valueForKey:@"data"] valueForKey:@"id"];
                                                       self.groupChatAllMembers = [[NSMutableArray alloc]init];
                                                       self.groupChatTitle = [[responseDic valueForKey:@"data"] valueForKey:@"title"];
                                                       int count;
                                                       for (count = 0; count < self.groupChatTitle.count; count++) {
                                                           self.groupChatNumOfMembers = [[[[responseDic valueForKey:@"data"] objectAtIndex:count] valueForKey:@"members"] valueForKey:@"id"];
                                                           [self.groupChatAllMembers addObject:self.groupChatNumOfMembers];
                                                       }
                                                       self.groupChatPhoto = [[responseDic valueForKey:@"data"] valueForKey:@"photo"];
                                                       //                                                   self.announceList = [[AnnounceList alloc]initWithDictionary:responseDic[@"data"] error:nil];
                                                       
                                                       [self configureControls];
                                                       [self configureNavigationBar];
                                                       [self getGroups];
                                                       [self.chatsListTableView reloadData];
                                                   }
                                                   
                                               } else {
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];

}
- (void)getGroups {
    [self.view showLoading:YES];
    
    NSDictionary *param = @{@"user" :  self.userID};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_GROUP withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               NSArray *array = [responseDic valueForKey:@"data"];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   if (array.count == 0) {
                                                       return;
                                                   } else {
                                                       self.groupTitle = [[responseDic valueForKey:@"data"] valueForKey:@"title"];
                                                       self.groupID = [[responseDic valueForKey:@"data"] valueForKey:@"id"];
                                                       int count;
                                                       for (count = 0; count < self.groupTitle.count; count++) {
                                                           self.creatorID = [[[[responseDic valueForKey:@"data"] objectAtIndex:count] valueForKey:@"creator"] valueForKey:@"id"];
                                                           if (!self.creatorID) {
                                                               [self.allCreatorID addObject:@""];
                                                           } else {
                                                               [self.allCreatorID addObject:self.creatorID];
                                                           }
                                                           
                                                           self.groupFollower = [[[[responseDic valueForKey:@"data"] objectAtIndex:count] valueForKey:@"members"] valueForKey:@"id"];
                                                           [self.groupFollowers addObject:self.groupFollower];
                                                       }
                                                       
                                                       self.posts = [[responseDic valueForKey:@"data"] valueForKey:@"news"];
                                                       
                                                       self.groupPhoto = [[responseDic valueForKey:@"data"] valueForKey:@"photo"];
                                                       
                                                       [self configureControls];
                                                       [self configureNavigationBar];
                                                       [self.chatsListTableView reloadData];
                                                   }
                                                   
                                               } else {
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];

}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(@"Chat") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    [self.view addSubview:self.topView];
}
- (void)configureControls {
    
    self.listSection = [[NSMutableArray alloc]initWithObjects:[TRANSLATE(@"Chats") uppercaseString], [TRANSLATE(@"Group Chats") uppercaseString], [TRANSLATE(@"Groups") uppercaseString], nil];
    
    self.chatsListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, self.view.bounds.size.width, self.view.bounds.size.height - 20) style:UITableViewStyleGrouped];
//        self.chatsListTableView.layer.borderWidth = 2;
    self.chatsListTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.chatsListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.chatsListTableView.rowHeight = 60.f;
    self.chatsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.chatsListTableView setDataSource:self];
    [self.chatsListTableView setDelegate:self];
//    [self.chatsListTableView setContentOffset:CGPointMake(0, 50) animated:YES];
    self.chatsListTableView.backgroundColor = rgbColor(255, 255, 255);
    [self.view addSubview:self.chatsListTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, tableView.frame.size.width, 30)];
    [label setFont:FONT_SANSUMI_BOLD(14)];
    label.textColor = rgbColor(73, 108, 148);
    NSString *string = [self.listSection objectAtIndex:section];
    [label setText:string];
    [view addSubview:label];
    if (section == 0 || section == 1) {
        [view setBackgroundColor:rgbColor(236, 243, 251)];
    } else if (section == 2) {
        [view setBackgroundColor:rgbColor(120, 158, 191)];
    }
    
    if (section == 1) {
        label.textColor = rgbColor(73, 108, 148);
        
        UIButton *addGroupChats = [[UIButton alloc] initWithFrame:CGRectMake(270, 5, 30, 30)];
        //    self.signInBtn.layer.borderWidth = 1.f;
        addGroupChats.layer.cornerRadius = 5.f;
        addGroupChats.backgroundColor = [UIColor clearColor];
        addGroupChats.image = [UIImage imageNamed:@"navig_bar_add.png"];
        addGroupChats.enabled = YES;
        [addGroupChats addTarget:self action:@selector(addGroupChats:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addGroupChats];
    } else if (section == 2) {
        label.textColor = rgbColor(255, 255, 255);
        UIButton *addGroups = [[UIButton alloc] initWithFrame:CGRectMake(270, 5, 30, 30)];
        //    self.signInBtn.layer.borderWidth = 1.f;
        addGroups.layer.cornerRadius = 5.f;
        addGroups.backgroundColor = [UIColor clearColor];
        addGroups.image = [UIImage imageNamed:@"add.png"];
        addGroups.enabled = YES;
        [addGroups addTarget:self action:@selector(addGroups:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addGroups];
    }
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return self.chatsTypes.count;
    } else if (section == 1) {
        return self.groupChatTitle.count;
    } else if (section == 2) {
        return self.groupTitle.count;
    } else return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatsListCell *cell = [ChatsListCell cellForTableView:tableView withItem:nil];
    cell.baseDelegate = self;
    cell.indexPath = indexPath;
    
    cell.announceNameLabel.textColor = indexPath.row % 2 == 0 ? rgbColor(1, 175, 233) : rgbColor(37, 66, 97);
    cell.announceDescLabel.textColor = indexPath.row % 2 == 0 ? rgbColor(1, 175, 233) : rgbColor(37, 66, 97);
    
    if (indexPath.section == 0) {
        cell.announceNameLabel.text = self.chatsTypes[indexPath.row];
        self.photoUrl = self.avatarTypes[indexPath.row];
        [cell.announceImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.announceDescLabel.text = self.occupation[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.announceNameLabel.text = self.groupChatTitle[indexPath.row];
        self.photoUrl = self.groupChatPhoto[indexPath.row];
        [cell.announceImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        NSArray *array = self.groupChatAllMembers[indexPath.row];
        cell.announceDescLabel.text = [NSString stringWithFormat:@"%lu members", (unsigned long)array.count];
    } else if (indexPath.section == 2) {
        cell.announceNameLabel.text = self.groupTitle[indexPath.row];
        self.photoUrl = self.groupPhoto[indexPath.row];
        [cell.announceImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        if ([self.userID isEqualToString:self.allCreatorID[indexPath.row]]) {
            cell.announceDescLabel.text = TRANSLATE(@"I'm admin of this group");
        } else {
            cell.announceDescLabel.text = TRANSLATE(@"I'm user of this group");
        }

    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        UserChatController *userChatController = [[UserChatController alloc]init];
        userChatController.groupChatID = self.groupChatID[indexPath.row];
        if ([self.searchDelegate respondsToSelector:@selector(openUserChatController:)]) {
            [self.searchDelegate openUserChatController:userChatController];
        }
    } else if (indexPath.section == 2) {
        GroupDetailsController *groupDetailsController = [[GroupDetailsController alloc]init];
        groupDetailsController.delegate = self;
        groupDetailsController.groupID = self.groupID[indexPath.row];
        self.photoUrl = self.groupPhoto[indexPath.row];
        groupDetailsController.photoUrl = self.photoUrl;
        groupDetailsController.groupName = self.groupTitle[indexPath.row];
        NSArray *array = self.groupFollowers[indexPath.row];
        groupDetailsController.groupFollowers = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        NSArray *grPosts = self.posts[indexPath.row];
        groupDetailsController.groupPosts = [NSString stringWithFormat:@"%lu", (unsigned long)grPosts.count];
        [groupDetailsController callApiMethods];
        
        if ([self.userID isEqualToString:self.allCreatorID[indexPath.row]]) {
            groupDetailsController.userType = 0;
        } else {
            groupDetailsController.userType = 1;
        }
        
        if ([self.searchDelegate respondsToSelector:@selector(openGroupDetailsController:)]) {
            [self.searchDelegate openGroupDetailsController:groupDetailsController];
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        cell.backgroundColor = rgbColor(65, 104, 145);
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
}
- (IBAction)addGroupChats:(id)sender {
    AddGroupChatController *addGroupChatsController = [[AddGroupChatController alloc]init];
    addGroupChatsController.delegate = self;
    if ([self.searchDelegate respondsToSelector:@selector(openAddGroupChatController:)]) {
        [self.searchDelegate openAddGroupChatController:addGroupChatsController];
    }
    //    [self.navigationController pushViewController:addGroupChatsController animated:YES];
}
- (IBAction)addGroups:(id)sender {
    AddGroupController *addGroupController = [[AddGroupController alloc]init];
    addGroupController.delegate = self;
    if ([self.searchDelegate respondsToSelector:@selector(openAddGroupController:)]) {
        [self.searchDelegate openAddGroupController:addGroupController];
    }
    //    [self.navigationController pushViewController:addGroupController animated:YES];
}

#pragma mark Group Chat Lists Delegate methods

- (void)callAppMethodOfGroupChatLists {
    [self callApiMethods];
}
#pragma mark Chat Lists Delegate methods

- (void)callAppMethodOfChatLists {
    [self callApiMethods];
}

#pragma mark GroupDetailsController Delegate methods

- (void)callApiChatsRefreashMethod {
    [self callApiMethods];
}

- (void)windowViewTapped:(id)sender {
    [super windowViewTapped:sender];
    [self.chatsView removeFromSuperview];
    [self.rightSearchViews enumerateObjectsUsingBlock:^(BaseRightSearchView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.rightSearchViews removeAllObjects];
}
- (ChatsBottomView *)chatsView {
    if (!_chatsView) {
        _chatsView = [[ChatsBottomView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - 65)];
//        [_chatsView createAndLayoutTopNavigationView];
        [_chatsView createAndLayoutSubviews];
    }
    _chatsView.baseDelegate = self;
    [self showRightSearchView:_chatsView];
    return _chatsView;
}

#pragma mark BaseSettingsRightView Delegate methods

- (void)showRightSearchView:(BaseRightSearchView *)rightSearchView {
    rightSearchView.bottom = 698;
    [self.windowView addSubview:rightSearchView];
    [rightSearchView reloadData];
    //    self.windowView.alpha = self.windowView.alpha == 0 ? 1.f : 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.windowView.alpha = 1.f;
        rightSearchView.bottom = 698 - 30;
    }                completion:^(BOOL finished) {
        [self.rightSearchViews addObject:rightSearchView];
        
    }];
}

- (void)showRightSearchView:(BaseRightSearchView *)rightSearchView withCallback:(void (^)(BaseRightSearchView *rightSearchView))callback {
    if (callback) {
        callback(rightSearchView);
    }
    rightSearchView.bottom = 320;
    [self.windowView addSubview:rightSearchView];
    //    self.windowView.alpha = self.windowView.alpha == 1 ? 0.f : 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.windowView.alpha = 1.f;
        rightSearchView.bottom = 320 - rightSearchView.width;
    }                completion:^(BOOL finished) {
        [self.rightSearchViews addObject:rightSearchView];
        [rightSearchView reloadData];
    }];
}
- (void)removeFromWindowAllSubViews {
    [self.rightSearchViews enumerateObjectsUsingBlock:^(BaseRightSearchView *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.rightSearchViews removeAllObjects];
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
