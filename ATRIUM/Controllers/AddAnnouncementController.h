//
//  AddAnnouncementController.h
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@class AddAnnouncementController;

@protocol AddAnnounceDelegate <NSObject>

-(void)callAppMethodOfAnnounce;
@end


@interface AddAnnouncementController : BaseController
@property (nonatomic, weak) id <AddAnnounceDelegate> delegate;
@end
