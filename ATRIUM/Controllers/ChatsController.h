//
//  ChatsController.h
//  ATRIUM
//
//  Created by Admin on 10/13/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"
#import "ChatsListCell.h"


@class UserChatController;
@class AddGroupChatController;
@class AddGroupController;
@class GroupDetailsController;

@protocol SearchChatsDelegate <NSObject>

-(void)openUserChatController:(UserChatController*)userChatController;
-(void)openAddGroupChatController:(AddGroupChatController*)addGroupChatController;
-(void)openAddGroupController:(AddGroupController*)addGroupController;
-(void)openGroupDetailsController:(GroupDetailsController*)groupDetailsController;

@end

@interface ChatsController : BaseController
@property (nonatomic, weak) id <SearchChatsDelegate> searchDelegate;

- (void)callApiMethods;
@end
