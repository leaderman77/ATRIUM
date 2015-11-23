//
//  AddGroupChatController.h
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@class AddGroupChatController;

@protocol AddGroupChatDelegate <NSObject>

-(void)callAppMethodOfGroupChatLists;
@end

@interface AddGroupChatController : BaseController
@property (nonatomic, weak) id <AddGroupChatDelegate> delegate;
@end
