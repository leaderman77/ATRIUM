//
//  CustomTabBarController.m
//  ATRIUM
//
//  Created by Admin on 10/16/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "CustomTabBarController.h"
#import "tabbarView.h"
#import "ChatsBottomViewController.h"
#import "NewTypeController.h"
#import "SearchAnnouncementsController.h"
#import "UserChatController.h"
#import "AddGroupChatController.h"
#import "AddGroupController.h"
#import "AddAnnouncementController.h"
#import "NewsDetailsController.h"
#import "AnnouncementDetailsController.h"
#import "ProfessorAccountController.h"
#import "StudentAccountController.h"
#import "GroupDetailsController.h"

#define SELECTED_VIEW_CONTROLLER_TAG 98456345

@interface CustomTabBarController () <SearchChatsDelegate, NewsTypeDelegate, SearchAnnounceDelegate, ProfessorProfileDelegate, StudentProfileDelegate, tabBarSearchDelegate>
@end

@implementation CustomTabBarController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    CGFloat orginHeight = self.view.frame.size.height- 60;
//    if (iPhone5) {
//        orginHeight = self.view.frame.size.height- 60 + addHeight;
//    }
    _tabbar = [[tabbarView alloc]initWithFrame:CGRectMake(0,  orginHeight, self.view.bounds.size.width, 60)];
//    _tabbar.layer.borderWidth = 2;
    _tabbar.delegate = self;
    _tabbar.tabBarSearchDelegate = self;
    [self.view addSubview:_tabbar];
    
    _arrayViewcontrollers = [self getViewcontrollers];
    [self touchBtnAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    NSDictionary* data = [_arrayViewcontrollers objectAtIndex:index];
    
    UIViewController *viewController = data[@"viewController"];
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height- 50);
    
    [self.view insertSubview:viewController.view belowSubview:_tabbar];
}

-(NSArray *)getViewcontrollers
{
    NSArray* tabBarItems = nil;
    
    NSUserDefaults *positionUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *position = [positionUserDefaults objectForKey:@"position"];
    StudentAccountController *first1 = [[StudentAccountController alloc]init];
    ProfessorAccountController *first2 = [[ProfessorAccountController alloc]init];
    
    
    BOOL isFirst;
    if ([position isEqualToString:@"Student"]) {
        isFirst = YES;
        first1.isViewMode = YES;
        first1.studentProfileDelegate = self;
    } else {
        first2.isViewMode = YES;
        first2.professorProfileDelegate = self;
        isFirst = NO;
    }

    
    self.chatsController = [[ChatsController alloc]init];
    self.chatsController.searchDelegate = self;
    [self.chatsController callApiMethods];
    
    NewsController *third = [[NewsController alloc]init];
    third.newsDelegate = self;
    AnnouncementsController *fourth = [[AnnouncementsController alloc]init];
    fourth.announceDelegate = self;
    [fourth callApiListAnnouncementMethods];
    
    tabBarItems = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", isFirst ? first1 : first2, @"viewController",@"account",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", self.chatsController, @"viewController",@"chats",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", third, @"viewController",@"news",@"title", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"tabicon_home", @"image",@"tabicon_home", @"image_locked", fourth, @"viewController",@"announcements",@"title", nil],nil];
    
    return tabBarItems;
    
}
- (void)openNextController:(ChatsBottomViewController *)chatsViewController {
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:chatsViewController];
    [chatsViewController callApiMethods];
    [self.navigationController presentViewController:navController animated:YES completion:NULL];
}
- (void)openNewsTypeController:(NewTypeController *)newsTypeController {
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newsTypeController];
    [self.navigationController presentViewController:navController animated:YES completion:NULL];
}
- (void)openNewsDetailsController:(NewsDetailsController *)newsDetailsController {
    [self.navigationController pushViewController:newsDetailsController animated:YES];
}
- (void)openSearchAnnounceController:(SearchAnnouncementsController *)searchAnnounceController {
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:searchAnnounceController];
    [searchAnnounceController callApiMethods];
    [self.navigationController presentViewController:navController animated:YES completion:NULL];
}
- (void)openUserChatController:(UserChatController *)userChatController {
    [self.navigationController pushViewController:userChatController animated:YES];
}
- (void)openAddGroupChatController:(AddGroupChatController *)addGroupChatController
{
    [self.navigationController pushViewController:addGroupChatController animated:YES];
}
- (void)openAddGroupController:(AddGroupController *)addGroupController {
    [self.navigationController pushViewController:addGroupController animated:YES];
}
- (void)openAddAnnounceController:(AddAnnouncementController *)addAnnounceController {
    [self.navigationController pushViewController:addAnnounceController animated:YES];
}
- (void)openAnnounceDetailsController:(AnnouncementDetailsController *)announceDetailsController {
     [self.navigationController pushViewController:announceDetailsController animated:YES];
}
- (void)backController:(AuthorizationController *)authorizationController {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"loginDetails"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)presentController:(UIImagePickerController *)imagePickerController {
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)dismissController:(UIImagePickerController *)pickerController {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)openGroupDetailsController:(GroupDetailsController *)groupDetailsController {
    [self.navigationController pushViewController:groupDetailsController animated:YES];
}
@end
