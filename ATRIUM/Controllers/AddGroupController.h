//
//  AddGroupController.h
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@class AddGroupController;

@protocol AddGroupDelegate <NSObject>

-(void)callAppMethodOfChatLists;
@end

@interface AddGroupController : BaseController
@property (nonatomic, weak) id <AddGroupDelegate> delegate;
@end
