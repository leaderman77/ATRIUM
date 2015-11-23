//
//  GroupDetailsController.h
//  ATRIUM
//
//  Created by Admin on 11/11/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@class GroupDetailsController;

@protocol GroupDetailsDelegate <NSObject>

-(void)callApiChatsRefreashMethod;
@end

@interface GroupDetailsController : BaseController
@property (nonatomic, strong) NSString *groupID;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *groupFollowers;
@property (nonatomic, strong) NSString *groupPosts;
@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic) NSInteger userType;

@property (nonatomic, weak) id <GroupDetailsDelegate> delegate;
@end
