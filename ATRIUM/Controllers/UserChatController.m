//
//  UserChatController.m
//  ATRIUM
//
//  Created by Admin on 10/26/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "UserChatController.h"
#import "UserChatCell.h"
#import "MessageCell.h"
#import "TableArray.h"
#import "Inputbar.h"
#import "DAKeyboardControl.h"
#import "MessageComposerView.h"

@interface UserChatController ()<UITableViewDelegate, UITableViewDataSource, InputbarDelegate, UserChatCellDelegate, MessageComposerViewDelegate> {
    CGFloat cellRowheight;
    BOOL isMySelf;
}
@property (nonatomic, strong) UIView *top;
@property (nonatomic, strong) UITableView *chatTableView;

@property (nonatomic, strong) NSMutableArray *previousChats;
@property (nonatomic, strong) NSMutableArray *todaysChats;

@property (strong, nonatomic) Inputbar *inputbar;
@property (strong, nonatomic) TableArray *tableArray;

@property (nonatomic, strong) NSString *string;

@end

@implementation UserChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self callApiMethods];
    [self configureNavigationBar];
//    [self setInputbar];
    [self configureControls];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.tabBarController.tabBar removeFromSuperview];
    
}
- (void)callApiMethods {
    NSDictionary *param = @{@"groupchat" : self.groupChatID};
    [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_GROUP_CHAT_MESSAGE withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   NSArray *array = [responseDic valueForKey:@"data"];
                                                   if (array.count == 0) {
                                                       return;
                                                   } else {
                                                       DLog(@"success 1 fields");
                                                       Message *message1 = [[Message alloc] init];
                                                       message1.text = [[[responseDic valueForKey:@"data"] valueForKey:@"text"] objectAtIndex:0];
                                                       message1.date = [NSDate date];
                                                       message1.sender = MessageSenderSomeone;
                                                       //    message.chat_id = _chat.identifier;
                                                       message1.heigh = 30;
                                                       isMySelf = NO;
                                                       //Store Message in memory
                                                       [self.tableArray addObject:message1];
                                                       
                                                       //Insert Message in UI
                                                       NSIndexPath *indexPath = [self.tableArray indexPathForMessage:message1];
                                                       [self.chatTableView beginUpdates];
                                                       if ([self.tableArray numberOfMessagesInSection:indexPath.section] == 1)
                                                           [self.chatTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                                                             withRowAnimation:UITableViewRowAnimationNone];
                                                       [self.chatTableView insertRowsAtIndexPaths:@[indexPath]
                                                                                 withRowAnimation:UITableViewRowAnimationBottom];
                                                       [self.chatTableView endUpdates];
                                                       
                                                       [self.chatTableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
                                                                                 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                                                       
                                                       [self.chatTableView reloadData];
                                                   }
                                                   
                                               } else {
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];

}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    self.previousChats = [[NSMutableArray alloc]initWithObjects:@"Mical Scofiled", @"Mical Scofiled", nil];
    self.todaysChats = [[NSMutableArray alloc]initWithObjects:@"Scofield.png", nil];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(@"Mical Scofiled") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(16);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    [self.view addSubview:self.topView];
}
- (void)configureControls {
    self.tableArray = [[TableArray alloc] init];
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 125) style:UITableViewStyleGrouped];
//    self.chatTableView.layer.borderWidth = 2;
    self.chatTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.chatTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.chatTableView.rowHeight = 60.f;
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.chatTableView setDataSource:self];
    [self.chatTableView setDelegate:self];
    self.chatTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,self.view.frame.size.width, 10.0f)];
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatTableView.backgroundColor = [UIColor clearColor];
    [self.chatTableView registerClass:[UserChatCell class] forCellReuseIdentifier: @"UserChatCell"];
    [self.view addSubview:self.chatTableView];
    
    MessageComposerView *message = [[MessageComposerView alloc]initWithFrame:CGRectMake(0, 420, self.view.width, 60) andKeyboardOffset:-20 andMaxHeight:60];
//    message.layer.borderWidth = 1;
    message.delegate = self;
    message.navigationController = self.navigationController;
    message.viewController = self;
    message.isKeyBoardShow = YES;
    [self.view addSubview:message];
}
- (void)messageComposerSendMessageClickedWithMessage:(NSString *)message {
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    NSDictionary *param = @{@"message[user]" : userId,
                            @"message[groupchat]" : self.groupChatID,
                            @"message[text]" : message,
                            @"group" : self.groupChatID};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_SEND_GROUP_CHAT_MESSAGE withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   NSArray *array = [responseDic valueForKey:@"data"];
                                                   if (array.count == 0) {
                                                       return;
                                                   } else {
                                                       DLog(@"success 1 fields");
                                                       Message *message1 = [[Message alloc] init];
                                                       message1.text = [[[responseDic valueForKey:@"data"] valueForKey:@"text"] objectAtIndex:0];;
                                                       message1.date = [NSDate date];
                                                       //    message.chat_id = _chat.identifier;
                                                       message1.sender = MessageSenderMyself;
                                                       message1.heigh = 40;
                                                       isMySelf = YES;
                                                       //Store Message in memory
                                                       [self.tableArray addObject:message1];
                                                       
                                                       //Insert Message in UI
                                                       NSIndexPath *indexPath = [self.tableArray indexPathForMessage:message1];
                                                       [self.chatTableView beginUpdates];
                                                       if ([self.tableArray numberOfMessagesInSection:indexPath.section] == 1)
                                                           [self.chatTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                                                                             withRowAnimation:UITableViewRowAnimationNone];
                                                       [self.chatTableView insertRowsAtIndexPaths:@[indexPath]
                                                                                 withRowAnimation:UITableViewRowAnimationBottom];
                                                       [self.chatTableView endUpdates];
                                                       
                                                       [self.chatTableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
                                                                                 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                                                       
                                                       [self.chatTableView reloadData];
                                                   }
                                                   
                                               } else {
                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];

    
//    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
//    NSString *userId = [userdefaults2 objectForKey:@"userID"];
//    NSDictionary *param = @{@"Message[from][id]" : userId,
//                            @"Message[to][id]" : userId,
//                            @"Message[text]" : message};
//    
//    [[RestClient sharedFormClient] callMethodByPath:METHOD_SEND_MESSAGE withHTTPMethodType:HTTP_POST withParameters:param
//                                           callback:^(NSDictionary *responseDic, NSError *error) {
//                                               [self.view showLoading:NO];
//                                               if (!error) {
//                                                   DLog(@"success 1 fields");
//                                                   Message *message1 = [[Message alloc] init];
//                                                   message1.text = message;
//                                                   message1.date = [NSDate date];
//                                                   //    message.chat_id = _chat.identifier;
//                                                   message1.sender = MessageSenderMyself;
//                                                   message1.heigh = 40;
//                                                   isMySelf = YES;
//                                                   //Store Message in memory
//                                                   [self.tableArray addObject:message1];
//                                                   
//                                                   //Insert Message in UI
//                                                   NSIndexPath *indexPath = [self.tableArray indexPathForMessage:message1];
//                                                   [self.chatTableView beginUpdates];
//                                                   if ([self.tableArray numberOfMessagesInSection:indexPath.section] == 1)
//                                                       [self.chatTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]
//                                                                         withRowAnimation:UITableViewRowAnimationNone];
//                                                   [self.chatTableView insertRowsAtIndexPaths:@[indexPath]
//                                                                             withRowAnimation:UITableViewRowAnimationBottom];
//                                                   [self.chatTableView endUpdates];
//                                                   
//                                                   [self.chatTableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
//                                                                             atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//                                                   
//                                                   [self.chatTableView reloadData];
//                                               } else {
//                                                   ALERT(@"Error with saving profile.");
//                                               }
//                                           }];

    
}
- (void)messageComposerSendPhotoClickedWithPhoto:(UIImage *)image {
    Message *message1 = [[Message alloc] init];
    message1.text = [NSString stringWithFormat:@"%@", image];
    message1.date = [NSDate date];
    //    message.chat_id = _chat.identifier;
    
    //Store Message in memory
    [self.tableArray addObject:message1];
    
    //Insert Message in UI
    NSIndexPath *indexPath = [self.tableArray indexPathForMessage:message1];
    [self.chatTableView beginUpdates];
    if ([self.tableArray numberOfMessagesInSection:indexPath.section] == 1)
        [self.chatTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                          withRowAnimation:UITableViewRowAnimationNone];
    [self.chatTableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationBottom];
    [self.chatTableView endUpdates];
    
    [self.chatTableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
                              atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -

-(void)setInputbar
{
    self.inputbar = [[Inputbar alloc]initWithFrame:CGRectMake(0, 420, self.view.bounds.size.width, 60)];
    self.inputbar.clipsToBounds = YES;
//    self.inputbar.layer.borderWidth = 1;
    self.inputbar.placeholder = TRANSLATE(@"Start typing...");
    self.inputbar.delegate = self;
//    self.inputbar.rightButtonImage = [UIImage imageNamed:@"send.png"];
//    self.inputbar.rightButtonText = @"Send";
//    self.inputbar.rightButtonTextColor = [UIColor colorWithRed:0 green:124/255.0 blue:1 alpha:1];
    self.inputbar.backgroundColor = rgbColor(236, 243, 251);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.inputbar.width, 15)];
    view.backgroundColor = [UIColor whiteColor];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 2, 30, 5)];
    [imageView setImage:[UIImage imageNamed:@"Dots2.png"]];
    //    imageView.layer.borderWidth = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;;
    [view addSubview:imageView];
    [self.inputbar addSubview:view];
    
    [self.view addSubview:self.inputbar];
}
#pragma mark - Actions

- (IBAction)userDidTapScreen:(id)sender
{
    [_inputbar resignFirstResponder];
}
- (void)rowHeight:(CGFloat)height {
    cellRowheight = height;
}
#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableArray numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableArray numberOfMessagesInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"MessageCell";
//    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell)
//    {
//        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    cell.message = [self.tableArray objectAtIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"UserChatCell";
    UserChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UserChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.heightDelegate = self;
    if (isMySelf) {
        cell.message.sender = MessageSenderMyself;
        cell.message = [self.tableArray objectAtIndexPath:indexPath];
    } else {
        cell.message.sender = MessageSenderSomeone;
        cell.message = [self.tableArray objectAtIndexPath:indexPath];
    }
    
    
//    cell.firstUserLabel.text = self.string;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *message = [self.tableArray objectAtIndexPath:indexPath];
    message.heigh = cellRowheight;
    NSLog(@"%f", message.heigh);
    return message.heigh + 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.tableArray titleForSection:section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, tableView.frame.size.width, 40);
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    UILabel *label = [[UILabel alloc] init];
//    label.layer.borderWidth = 2;
    NSString *string = [NSString stringWithFormat:@"%@", [self tableView:tableView titleForHeaderInSection:section]];
    label.text = [TRANSLATE(string) uppercaseString];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_SANSUMI_BOLD(20);
    [label sizeToFit];
    label.center = view.center;
    label.font = FONT_SANSUMI_BOLD(16);
    label.textColor = rgbColor(37, 66, 97);
    label.backgroundColor = [UIColor clearColor];  //[UIColor colorWithRed:207/255.0 green:220/255.0 blue:252.0/255.0 alpha:1];
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    label.autoresizingMask = UIViewAutoresizingNone;
    [view addSubview:label];
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, label.height/2 + 7, 80, 2)];
    [leftImageView setImage:[UIImage imageNamed:@"Dots.png"]];
//            leftImageView.layer.borderWidth = 1;
    leftImageView.contentMode = UIViewContentModeScaleAspectFill;;
    [view addSubview:leftImageView];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(95 + leftImageView.width + label.width, label.height/2 + 7, 8, 2)];
    [rightImageView setImage:[UIImage imageNamed:@"Dots.png"]];
    //        imageView.layer.borderWidth = 1;
    rightImageView.contentMode = UIViewContentModeScaleAspectFill;;
    [view addSubview:rightImageView];
    
    return view;
}
- (void)tableViewScrollToBottomAnimated:(BOOL)animated
{
    NSInteger numberOfSections = [self.tableArray numberOfSections];
    NSInteger numberOfRows = [self.tableArray numberOfMessagesInSection:numberOfSections-1];
    if (numberOfRows)
    {
        [self.chatTableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
                          atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}
#pragma mark - InputbarDelegate

-(void)inputbarDidPressRightButton:(Inputbar *)inputbar
{
    Message *message = [[Message alloc] init];
    message.text = inputbar.text;
    message.date = [NSDate date];
    //    message.chat_id = _chat.identifier;
    
    //Store Message in memory
    [self.tableArray addObject:message];
    
    //Insert Message in UI
    NSIndexPath *indexPath = [self.tableArray indexPathForMessage:message];
    [self.chatTableView beginUpdates];
    if ([self.tableArray numberOfMessagesInSection:indexPath.section] == 1)
        [self.chatTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                      withRowAnimation:UITableViewRowAnimationNone];
    [self.chatTableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationBottom];
    [self.chatTableView endUpdates];
    
    [self.chatTableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
                          atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    //Send message to server
    //    [self.gateway sendMessage:message];
}
- (void)inputbarDidPressTakePhotButton:(Inputbar *)inputbar {
    Message *message = [[Message alloc] init];
    message.text = inputbar.text;
    message.date = [NSDate date];
    //    message.chat_id = _chat.identifier;
    
    //Store Message in memory
    [self.tableArray addObject:message];
    
    //Insert Message in UI
    NSIndexPath *indexPath = [self.tableArray indexPathForMessage:message];
    [self.chatTableView beginUpdates];
    if ([self.tableArray numberOfMessagesInSection:indexPath.section] == 1)
        [self.chatTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                          withRowAnimation:UITableViewRowAnimationNone];
    [self.chatTableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationBottom];
    [self.chatTableView endUpdates];
    
    [self.chatTableView scrollToRowAtIndexPath:[self.tableArray indexPathForLastMessage]
                              atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)inputbarDidPressLeftButton:(Inputbar *)inputbar
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Left Button Pressed"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}
-(void)inputbarDidChangeHeight:(CGFloat)new_height
{
    //Update DAKeyboardControl
    self.view.keyboardTriggerOffset = new_height;
}
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 2;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40.0f;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
//    //    view.layer.borderWidth = 2;
//    [view setBackgroundColor:rgbColor(236, 243, 251)];
//    if (section == 1) {
//        UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 100, 30, 30)];
//        headerLabel.backgroundColor = [UIColor redColor];
//        headerLabel.text = [TRANSLATE(@"Today") uppercaseString];
//        headerLabel.textColor = rgbColor(37, 66, 97);
//        [view addSubview:headerLabel];
//        return view;
//    }
//    return nil;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    if (section == 0) {
//        return self.previousChats.count;
//    } else {
//        return self.todaysChats.count;
//    }
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    static NSString *CellIdentifier = @"LBLeftSideViewCell";
//    //
//    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    //    if (cell == nil) {
//    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    //    }
//    //    //    cell.contentView.layer.borderWidth = 2;
//    
//    UserChatCell *cell = [UserChatCell cellForTableView:tableView withItem:nil];
//    cell.baseDelegate = self;
//    cell.indexPath = indexPath;
//    cell.firstUserLabel.text = self.previousChats[indexPath.row];
//    cell.secondUserLabel.text = self.previousChats[indexPath.row];
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UserChatController *userChatController = [[UserChatController alloc]init];
//    [self.navigationController pushViewController:userChatController animated:YES];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
