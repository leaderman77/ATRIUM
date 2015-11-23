//
//  GroupNewsDetailsController.h
//  ATRIUM
//
//  Created by Admin on 11/23/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@interface GroupNewsDetailsController : BaseController
@property (nonatomic, strong) NSString *groupNewsTitle;
@property (nonatomic, strong) NSString *groupNewstext;
@property (nonatomic, strong) NSURL *photoUrl;
@end
