//
//  AnnouncementsController.m
//  ATRIUM
//
//  Created by Admin on 10/13/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AnnouncementsController.h"
#import "ChatsController.h"
#import "NewsController.h"
#import "AnnouncementDetailsController.h"
#import "AddAnnouncementController.h"
#import "SearchAnnouncementsController.h"
#import "AnnounceList.h"
#import "AddAnnouncementController.h"

@interface AnnouncementsController ()<AddAnnounceDelegate>
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *announceListTableView;
@property (nonatomic, retain) UIButton *titleViewButton;

@property (retain, nonatomic) UILabel *sectionLabel;
@property (nonatomic, retain) NSMutableArray *announcementTypes;

@property (nonatomic, retain) NSMutableArray *announceDescribtionTypes;

@property (nonatomic, retain) NSMutableArray *listSection;
@property (nonatomic, retain) UIToolbar *toolbar;

@property (nonatomic, retain) NSArray *titleArray;
@property (nonatomic, retain) NSArray *fullNameArray;

@property (nonatomic, retain) UIButton *announceSearchButton;
@property (nonatomic, retain) AnnounceList *announceList;
@property (nonatomic, retain) AddAnnouncementController *addAnnounceController;
@end

@implementation AnnouncementsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgbColor(255, 255, 255);
    // Do any additional setup after loading the view.
    self.myAnnounceTitle = [[NSMutableArray alloc]init];
    self.myAnnounceCreatedDate = [[NSMutableArray alloc]init];
    self.myAnnouncePhotos = [[NSMutableArray alloc]init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"MyAnnouncements"
                                               object:nil];

    
    [self configureNavigationBar];
    [self callAppMethodOfAnnounce];
    [self.announceListTableView reloadData];
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    self.myAnnounceTitle = [[NSMutableArray alloc]init];
    self.myAnnounceCreatedDate = [[NSMutableArray alloc]init];
    self.myAnnouncePhotos = [[NSMutableArray alloc]init];
    
    NSString *title = [notification.userInfo valueForKey:@"title"];
    NSString *date = [notification.userInfo valueForKey:@"date"];
    NSURL *photo = [notification.userInfo valueForKey:@"photo"];
    int count = self.myAnnounceTitle.count;
    
    
    [self.myAnnounceTitle insertObject:title atIndex:count];
    [self.myAnnounceCreatedDate insertObject:date atIndex:count];
    [self.myAnnouncePhotos insertObject:photo atIndex:count];
    
    if ([[notification name] isEqualToString:@"MyAnnouncements"])
        NSLog (@"Successfully received the test notification!");
    [self.announceListTableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)callAppMethodOfAnnounce {
    [self callApiListAnnouncementMethods];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(255, 255, 255);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(55, 25, 230, 30)];
    titleButton.text = [TRANSLATE(@"Announcements") uppercaseString];
    titleButton.titleColor = rgbColor(37, 66, 97);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    [self.view addSubview:self.topView];
}
- (void)callApiListAnnouncementMethods {
    [self.view showLoading:YES];

    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_LISTOFANNOUNCEMENTS withHTTPMethodType:HTTP_POST withParameters:nil callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error && [responseDic[@"status"] integerValue] == 1 && responseDic[@"data"]) {
                                                   DLog(@"success 1 fields");
//                                                   self.titleArray = [responseDic valueForKey:@"title"];
                                                   self.titleArray = nil; //[[responseDic valueForKey:@"data"] valueForKey:@"title"];
                                                   self.fullNameArray = nil; //[[[[responseDic valueForKey:@"data"] valueForKey:@"user"] objectAtIndex:5] valueForKey:@"fullName"];
//                                                   self.announceList = [[AnnounceList alloc]initWithDictionary:responseDic[@"data"] error:nil];

                                                   [self configureControls];
                                                   [self callApiAnnouncementMethod];
                                                   [self.announceListTableView reloadData];
                                               } else {
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];
}
- (void)callApiAnnouncementMethod {
    [self.view showLoading:YES];
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    
    NSDictionary *param = @{@"user" : userId};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_ANNOUNCEMENTS withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   NSArray *array = [responseDic valueForKey:@"data"];
                                                   if (array.count != 0) {
                                                       self.myAnnounceTitle = [[responseDic valueForKey:@"data"] valueForKey:@"title"];
                                                       self.myAnnounceCreatedDate = [[responseDic valueForKey:@"data"] valueForKey:@"createdAt"];
                                                       self.myAnnounceText = [[responseDic valueForKey:@"data"] valueForKey:@"text"];
                                                       self.myAnnouncePhotos = [[responseDic valueForKey:@"data"] valueForKey:@"photo"];
                                                       
                                                       //                                                   self.announceList = [[AnnounceList alloc]initWithDictionary:responseDic[@"data"] error:nil];
                                                       
                                                       [self configureControls];
                                                       [self.announceListTableView reloadData];
                                                   } else {
                                                       self.myAnnounceTitle = nil;
                                                       self.myAnnounceCreatedDate = nil;
                                                       self.myAnnounceText = nil;
                                                   }
                                                   
                                               } else {
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];
}
- (void)configureControls {
    
    self.listSection = [[NSMutableArray alloc]initWithObjects:[TRANSLATE(@"Trending") uppercaseString], [TRANSLATE(@"My announcements") uppercaseString], nil];
    
    self.announceListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 60) style:UITableViewStyleGrouped];
    [self.announceListTableView setDelegate:self];
    [self.announceListTableView setDataSource:self];
//    [self.announceListTableView setContentOffset:CGPointZero animated:YES];
//    self.announceListTableView.layer.borderWidth = 2;
    self.announceListTableView.allowsSelectionDuringEditing = YES;
    self.announceListTableView.rowHeight = 40;
    self.announceListTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.announceListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.announceListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.announceListTableView.backgroundColor = rgbColor(255, 255, 255);
    [self.view addSubview:self.announceListTableView];
}

- (void)insertAnnounceObject:(NSString *)anounceName withAnnounceCreatedDate:(NSString *)date withAnnouncePhoto:(NSURL *)photoURL atIndex:(NSUInteger)index {
    [self.myAnnounceNames addObject:anounceName];
    [self.announceListTableView reloadData];
}
- (IBAction)newsButtonClicked:(id)sender {
    NewsController *newsController = [[NewsController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newsController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}
- (IBAction)chatsButtonClicked:(id)sender {
    ChatsController *chatsController = [[ChatsController alloc]init];
    CustomNavigationController *navController = [[CustomNavigationController alloc]initWithRootViewController:chatsController];
    //    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:chatsController];
    [self.navigationController presentViewController:navController animated:YES completion:NULL];
}
- (IBAction)addNewAnnouncementClicked:(id)sender {
    AddAnnouncementController *addNewAnnouncement = [[AddAnnouncementController alloc]init];
    addNewAnnouncement.delegate = self;
    if ([self.announceDelegate respondsToSelector:@selector(openAddAnnounceController:)]) {
        [self.announceDelegate openAddAnnounceController:addNewAnnouncement];
    }
//    [self.navigationController pushViewController:addNewAnnouncement animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
//    view.layer.borderWidth = 2;
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, tableView.frame.size.width, 30)];
    [label setFont:FONT_SANSUMI_BOLD(14)];
    label.textColor = rgbColor(73, 108, 148);
    NSString *string = [self.listSection objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:rgbColor(236, 243, 251)];
    if (section == 1) {
        UIButton *addAnnouncment = [[UIButton alloc] initWithFrame:CGRectMake(285, 8, 25, 25)];
        //    self.signInBtn.layer.borderWidth = 1.f;
        addAnnouncment.layer.cornerRadius = 5.f;
        addAnnouncment.backgroundColor = [UIColor clearColor];
        addAnnouncment.image = [UIImage imageNamed:@"navig_bar_add.png"];
        addAnnouncment.enabled = YES;
        [addAnnouncment addTarget:self action:@selector(addNewAnnouncementClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:addAnnouncment];
    }
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return self.titleArray.count;
    } else {
        return self.myAnnounceTitle.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementsListCell *cell = [AnnouncementsListCell cellForTableView:tableView withItem:nil];
    cell.baseDelegate = self;
    cell.indexPath = indexPath;
    if ((indexPath.section == 0) && (self.titleArray != nil) && (self.fullNameArray == nil))  {     //&& (self.titleArray != nil) && (self.fullNameArray != nil))
        cell.announceNameLabel.text = [NSString stringWithFormat:@"%@", [self.titleArray objectAtIndex:indexPath.row]];
        cell.announceDescLabel.text = [NSString stringWithFormat:@"%@", [self.fullNameArray objectAtIndex:indexPath.row]];
    } else if ((indexPath.section == 1) &&(self.myAnnounceTitle != nil) && (self.myAnnounceCreatedDate != nil)) {
        self.photoUrl = self.myAnnouncePhotos[indexPath.row];
        [cell.announceImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                                          usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.announceNameLabel.text = [NSString stringWithFormat:@"%@", [self.myAnnounceTitle objectAtIndex:indexPath.row]];
        NSString *string = [NSString stringWithFormat:@"%@", [self.myAnnounceCreatedDate objectAtIndex:indexPath.row]];
        NSString *stringDate = [string substringToIndex:[string length] - 14];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:stringDate];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"dd.MM.yyyy"];
        
        cell.announceDescLabel.text = [formatter1 stringFromDate:date];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementDetailsController *announcementDetailsController = [[AnnouncementDetailsController alloc]init];
    self.photoUrl = self.myAnnouncePhotos[indexPath.row];
    announcementDetailsController.isViewMode = YES;
    announcementDetailsController.photoUrl = self.photoUrl;
    announcementDetailsController.myAnnounceText = self.myAnnounceText[indexPath.row];
    announcementDetailsController.announceTitle = self.myAnnounceTitle[indexPath.row];
    if ([self.announceDelegate respondsToSelector:@selector(openAnnounceDetailsController:)]) {
        [self.announceDelegate openAnnounceDetailsController:announcementDetailsController];
    }
//    [self.navigationController pushViewController:announcementDetailsController animated:YES];
}
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (indexPath.section == 0) ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you really want to delete this task?"
                                                       delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
        [alert show];
    } else if(editingStyle == UITableViewCellEditingStyleInsert){
        
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
