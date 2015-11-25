//
//  AnnouncementsController.h
//  ATRIUM
//
//  Created by Admin on 10/13/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"
#import "AnnouncementsListCell.h"

@class AddAnnouncementController;
@class AnnouncementDetailsController;

@protocol SearchAnnounceDelegate <NSObject>

-(void)openAddAnnounceController:(AddAnnouncementController*)addAnnounceController;
-(void)openAnnounceDetailsController:(AnnouncementDetailsController*)announceDetailsController;
@end

@interface AnnouncementsController : BaseController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id <SearchAnnounceDelegate> announceDelegate;
@property (nonatomic, strong) NSMutableArray *myAnnounceText;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableArray *myAnnouncePhotos;
@property (nonatomic, strong) NSString *photos;
@property (nonatomic, strong) NSURL *photoUrl;

@property (nonatomic, strong) NSMutableArray *myAnnounceNames;

- (void)callApiListAnnouncementMethods;
@end
