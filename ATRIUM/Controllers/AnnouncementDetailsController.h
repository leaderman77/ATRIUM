//
//  AnnouncementDetailsController.h
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"
@class AnnouncementDetailsController;

@protocol AnnounceDetailsControllerDelegate <NSObject>

-(void)callAppMethodOfAnnounce;
@end

@interface AnnouncementDetailsController : BaseController
@property (nonatomic, weak) id <AnnounceDetailsControllerDelegate> delegate;
@property (nonatomic, strong) NSString *myAnnounceText;
@property (nonatomic, strong) NSURL *photoUrl;
@end
