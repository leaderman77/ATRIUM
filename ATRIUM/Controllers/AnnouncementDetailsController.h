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
@property (nonatomic, strong) NSString *announceTitle;
@property (nonatomic, strong) NSString *announceCreateBy;
@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, assign) BOOL isViewMode;

- (void)setIsViewMode:(BOOL)isViewMode;
@end
