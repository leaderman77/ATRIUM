//
//  SearchAnnouncementsController.h
//  ATRIUM
//
//  Created by Admin on 10/15/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@interface SearchAnnouncementsController : BaseController

@property (nonatomic, retain) NSMutableArray *announceNames;
@property (nonatomic, retain) NSMutableArray *announceDescription;
@property (nonatomic, retain) NSMutableArray *createdDate;
@property (nonatomic, retain) NSMutableArray *announcePhoto;

- (void)callApiMethods;
@end
