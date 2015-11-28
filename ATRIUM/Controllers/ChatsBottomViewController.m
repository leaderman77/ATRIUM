//
//  ChatsBottomViewController.m
//  ATRIUM
//
//  Created by Admin on 10/13/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "ChatsBottomViewController.h"
#import "SearchInChatCell.h"
#import "SearchGroupsCell.h"
#import "GroupDetailsController.h"

@interface ChatsBottomViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    BOOL isSearchTextFieldActive;
    BOOL isTableViewActive;
}
@property (nonatomic, strong) UITableView *chatsTableView;
@property (nonatomic, strong) UITableView *groupTableView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;

@property (strong, nonatomic) CustomTextField *searchContactsTextFiled;
@property (nonatomic, strong) CustomTextField *searchGroupsTextFiled;

@property (nonatomic, retain) NSMutableArray *userNames;
@property (nonatomic, retain) NSMutableArray *userPosition;

@property (nonatomic, retain) NSMutableArray *userPhoto;
@property (strong, nonatomic) NSArray *filteredNames;
@property (strong, nonatomic) NSArray *filteredGroupNames;
@property (nonatomic, retain) NSMutableArray *groupName;
@property (nonatomic, retain) NSMutableArray *groupFollowers;

@property (nonatomic, retain) NSArray *groupFollower;
@property (nonatomic, retain) NSMutableArray *groupPhoto;

@property (strong, nonatomic) NSArray *posts;
@property (strong, nonatomic) NSMutableArray *allCreatorID;
@property (strong, nonatomic) NSArray *creatorID;

@property (strong, nonatomic) NSArray *groupID;

@property (nonatomic, retain) UIButton *backButton;

@property (strong, nonatomic) NSArray *names;
//@property (strong, nonatomic) NSArray *filteredNames;

@property (strong, nonatomic) NSMutableArray *selectedNames;
@end

@implementation ChatsBottomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allCreatorID = [[NSMutableArray alloc]init];
    self.groupFollowers = [[NSMutableArray alloc]init];
    isTableViewActive = YES;
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)callApiMethods {
    [self.view showLoading:YES];
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_FIND_USERS withHTTPMethodType:HTTP_POST withParameters:nil callback:^(NSDictionary *responseDic, NSError *error) {
        [self.view showLoading:NO];
        if (!error && [responseDic[@"status"] integerValue] == 1 && responseDic[@"data"]) {
            DLog(@"success 1 fields");
            //                                                   self.titleArray = [responseDic valueForKey:@"title"];
            self.userNames = [[responseDic valueForKey:@"data"] valueForKey:@"fullName"];
            self.userPosition = [[responseDic valueForKey:@"data"] valueForKey:@"position"];
            self.userPhoto = [[responseDic valueForKey:@"data"] valueForKey:@"photo"];
            [self configureControls];
            [self callApiGroupMethods];
            [self.chatsTableView reloadData];
        } else {
            ALERT(@"Error with saving profile.");
        }
    }];
    
}
- (void)callApiGroupMethods {
    [self.view showLoading:YES];
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_ALL_GROUP withHTTPMethodType:HTTP_POST withParameters:nil callback:^(NSDictionary *responseDic, NSError *error) {
        [self.view showLoading:NO];
        if (!error && [responseDic[@"status"] integerValue] == 1 && responseDic[@"data"]) {
            DLog(@"success 1 fields");
            //                                                   self.titleArray = [responseDic valueForKey:@"title"];
            self.groupName = [[responseDic valueForKey:@"data"] valueForKey:@"title"];
            self.groupID = [[responseDic valueForKey:@"data"] valueForKey:@"id"];
            int count;
            for (count = 0; count < self.groupName.count; count++) {
                
                self.groupFollower = [[[[responseDic valueForKey:@"data"] objectAtIndex:count] valueForKey:@"members"] valueForKey:@"id"];
                [self.groupFollowers addObject:self.groupFollower];
                
                self.creatorID = [[[[responseDic valueForKey:@"data"] objectAtIndex:count] valueForKey:@"creator"] valueForKey:@"id"];
                if (self.creatorID == nil) {
                    [self.allCreatorID addObject:@""];
                } else {
                    [self.allCreatorID addObject:self.creatorID];
                }
                
            }
            self.groupPhoto = [[responseDic valueForKey:@"data"] valueForKey:@"photo"];
            self.posts = [[responseDic valueForKey:@"data"] valueForKey:@"news"];
            
            [self configureControls];
            
            [self.chatsTableView reloadData];
        } else {
            ALERT(@"Error with saving profile.");
        }
    }];
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
    titleButton.text = [TRANSLATE(@"Chat") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    [self.view addSubview:self.topView];
}
- (void)configureControls {
    self.view.backgroundColor = rgbColor(22, 168, 235);
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.height, self.view.bounds.size.width, 1.5)];
    self.lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.lineView.backgroundColor = rgbColorWithAlpha(255, 255, 255, 0.9);
    [self.view addSubview:self.lineView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(140, self.topView.height + 10, 40, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.backButton.width, self.backButton.height)];
    [imageView setImage:[UIImage imageNamed:@"messages_passive.png"]];
    //    imageView.layer.borderWidth = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.left = 0.5 * (imageView.width - imageView.width);
    imageView.top = 0.5 * (imageView.height - imageView.height);
    imageView.layer.borderWidth = 1.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.cornerRadius = 0.5 * imageView.width;
    imageView.layer.masksToBounds = YES;
    [self.backButton addSubview:imageView];
    [self.backButton addTarget:self action:@selector(cencelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topView.height + 60, self.view.bounds.size.width, self.view.bounds.size.height)];
//        self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(22, 168, 235);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.searchContactsTextFiled = [[CustomTextField alloc]initWithFrame:CGRectMake(10, 5, 300, 30)];
    self.searchContactsTextFiled.delegate = self;
    self.searchContactsTextFiled.font = FONT_SANSUMI(12);
    self.searchContactsTextFiled.textColor = [UIColor whiteColor];
    self.searchContactsTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[TRANSLATE(@"Search Contacts") uppercaseString] attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.searchContactsTextFiled.leftView = paddingView1;
    self.searchContactsTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.searchContactsTextFiled.layer.cornerRadius = 5.f;
    self.searchContactsTextFiled.layer.masksToBounds = YES;
    self.searchContactsTextFiled.returnKeyType = UIReturnKeyNext;
    [self.searchContactsTextFiled addBottomBorderWithHeight:0.5f andColor:rgbColorWithAlpha(255, 255, 255, 0.5)];
    [self.scrollView addSubview:self.searchContactsTextFiled];
    
    self.chatsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 50, self.searchContactsTextFiled.width, 120) style:UITableViewStylePlain];
    //    self.chatsTableView.layer.borderWidth = 2;
    self.chatsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.chatsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.chatsTableView.rowHeight = 35.f;
    self.chatsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatsTableView.delegate = self;
    self.chatsTableView.dataSource = self;
    self.chatsTableView.hidden = YES;
    self.chatsTableView.backgroundColor = rgbColor(22, 168, 235);
//    [self.chatsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.scrollView addSubview:self.chatsTableView];
    
    self.searchGroupsTextFiled = [[CustomTextField alloc]initWithFrame:CGRectMake(10, self.backButton.height + 140, 300, 30)];
    self.searchGroupsTextFiled.delegate = self;
    self.searchGroupsTextFiled.font = FONT_SANSUMI(12);
    self.searchGroupsTextFiled.textColor = [UIColor whiteColor];
    self.searchGroupsTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[TRANSLATE(@"Search Groups") uppercaseString] attributes:@{NSForegroundColorAttributeName : rgbColor(61, 116, 163)}];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.searchGroupsTextFiled.leftView = paddingView2;
    self.searchGroupsTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.searchGroupsTextFiled.layer.cornerRadius = 5.f;
    self.searchGroupsTextFiled.layer.masksToBounds = YES;
    self.searchGroupsTextFiled.returnKeyType = UIReturnKeyNext;
    [self.searchGroupsTextFiled addBottomBorderWithHeight:0.5f andColor:rgbColorWithAlpha(255, 255, 255, 0.5)];
    [self.scrollView addSubview:self.searchGroupsTextFiled];
    
    self.groupTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.backButton.height + 180, self.searchContactsTextFiled.width, 130) style:UITableViewStylePlain];
//    self.groupTableView.layer.borderWidth = 1;
    self.groupTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.groupTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.groupTableView.rowHeight = 35.f;
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.groupTableView.delegate = self;
    self.groupTableView.dataSource = self;
    self.groupTableView.hidden = YES;
    self.groupTableView.backgroundColor = rgbColor(22, 168, 235);
//    [self.groupTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.scrollView addSubview:self.groupTableView];
    
    self.scrollView.contentSize = CGSizeMake(0, 650);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (IBAction)cencelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.chatsTableView && isTableViewActive) {
        if (isSearchTextFieldActive) {
            return _filteredNames.count;
        } else {
            return self.userNames.count;
        }
    } else {
        if (isSearchTextFieldActive) {
            return _filteredGroupNames.count;
        } else {
            return self.groupName.count;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.chatsTableView && isTableViewActive) {
        SearchInChatCell *cell = [SearchInChatCell cellForTableView:tableView withItem:nil];
        cell.baseDelegate = self;
        cell.indexPath = indexPath;
        if (isSearchTextFieldActive) {
            cell.userName.text = [NSString stringWithFormat:@"%@", [self.filteredNames objectAtIndex:indexPath.row]];
//            cell.userPosition.text = [NSString stringWithFormat:@"%@", [self.userPosition objectAtIndex:indexPath.row]];
        } else {
            cell.userName.text = [NSString stringWithFormat:@"%@", [self.userNames objectAtIndex:indexPath.row]];
            cell.userPosition.text = [NSString stringWithFormat:@"%@", [self.userPosition objectAtIndex:indexPath.row]];
        }
        return cell;
    } else {
        SearchGroupsCell *cell = [SearchGroupsCell cellForTableView:tableView withItem:nil];
        cell.baseDelegate = self;
        cell.indexPath = indexPath;
        if (isSearchTextFieldActive) {
            DLog(@"%ld", (long)indexPath.row);
            cell.groupName.text = [NSString stringWithFormat:@"%@", self.filteredGroupNames[indexPath.row]];
//            cell.groupFollowers.text = [NSString stringWithFormat:@"%d %@", self.groupFollowers.count, [TRANSLATE(@"Followers") uppercaseString]];
        } else {
            cell.groupName.text = [NSString stringWithFormat:@"%@", [self.groupName objectAtIndex:indexPath.row]];
            NSArray *array = self.groupFollowers[indexPath.row];
            cell.groupFollowers.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)array.count, [TRANSLATE(@"Followers") uppercaseString]];
        }
        return cell;
    }
   

//    if ([self.selectedNames containsObject:name]) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.chatsTableView) {
        NSString *fullName = self.userNames[indexPath.row];
        NSString *position = self.userPosition[indexPath.row];
        NSURL *photo = self.userPhoto[indexPath.row];
        
        NSDictionary *dic = @{@"fullName" : fullName,
                              @"position" : position,
                              @"photo" : photo};
        
        // Posting notification from another object
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:nil userInfo:dic];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        GroupDetailsController *groupDetailsController = [[GroupDetailsController alloc]init];
        groupDetailsController.groupID = self.groupID[indexPath.row];
        groupDetailsController.groupName = self.groupName[indexPath.row];
        NSArray *array = self.groupFollowers[indexPath.row];
        groupDetailsController.groupFollowers = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        groupDetailsController.photoUrl = self.groupPhoto[indexPath.row];
        NSArray *grPosts = self.posts[indexPath.row];
        groupDetailsController.groupPosts = [NSString stringWithFormat:@"%lu", (unsigned long)grPosts.count];
        
        NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
        NSString *userId = [userdefaults2 objectForKey:@"userID"];
        
        if ([userId isEqualToString:self.groupID[indexPath.row]]) {
            groupDetailsController.userType = 0;
        } else if ([userId isEqualToString:self.allCreatorID[indexPath.row]]) {
            groupDetailsController.userType = 1;
        } else {
            groupDetailsController.userType = 2;
        }
        [self.navigationController pushViewController:groupDetailsController animated:YES];
    }
    
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.searchContactsTextFiled isEqual:textField]) {
        self.chatsTableView.frame = CGRectMake(10, 50, self.searchContactsTextFiled.width, 320);
        self.chatsTableView.hidden = NO;
        self.searchGroupsTextFiled.hidden = YES;
        isSearchTextFieldActive = YES;
        isTableViewActive = YES;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self beginswith[cd] %@", textField.text];
        self.filteredNames = [self.userNames filteredArrayUsingPredicate:predicate];
        
        //        NSString *substring = [NSString stringWithString:textField.text];
        //        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        //        [self searchAutocompleteEntriesWithSubstring:substring];
        [self.chatsTableView reloadData];
    }
    
    if ([string isEqualToString:@""]) {
        self.searchGroupsTextFiled.hidden = NO;
        isSearchTextFieldActive = NO;
        self.chatsTableView.hidden = NO;
        [self.chatsTableView reloadData];
    }
    if ([self.searchGroupsTextFiled isEqual:textField]) {
        self.groupTableView.hidden = NO;
        isTableViewActive = NO;
        
        
        isSearchTextFieldActive = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self beginswith[cd] %@", self.searchGroupsTextFiled.text];
        self.filteredGroupNames = [self.groupName filteredArrayUsingPredicate:predicate];
        [self.groupTableView reloadData];
    }
    
    if ([string isEqualToString:@""]) {
        isSearchTextFieldActive = NO;
        self.groupTableView.hidden = NO;
        
        [self.groupTableView reloadData];
    }

    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.searchGroupsTextFiled) {
        _chatsTableView.hidden = YES;
        self.groupTableView.frame = CGRectMake(10, self.backButton.height + 180, self.searchContactsTextFiled.width, 320);
        [self.scrollView setContentOffset:CGPointMake(0, self.searchGroupsTextFiled.center.y-20) animated:YES];
    } else if (textField == self.searchContactsTextFiled) {
        _groupTableView.hidden = YES;
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.searchContactsTextFiled isEqual:textField]) {
        [self.searchContactsTextFiled resignFirstResponder];
    } else if ([self.searchGroupsTextFiled isEqual:textField]) {
        [self.searchGroupsTextFiled resignFirstResponder];
    }
    
    return YES;
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
