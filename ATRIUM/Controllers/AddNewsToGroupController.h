//
//  AddNewsToGroupController.h
//  ATRIUM
//
//  Created by Admin on 11/23/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"
@class AddNewsToGroupController;

@protocol AddNewsToGroupDelegate <NSObject>

-(void)callApiGroupRefreshMethod;
@end
@interface AddNewsToGroupController : BaseController
@property (nonatomic, weak) id <AddNewsToGroupDelegate> delegate;
@property (nonatomic, retain) NSString *groupID;
@end
