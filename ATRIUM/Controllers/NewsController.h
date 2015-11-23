//
//  NewsController.h
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@class NewsDetailsController;

@protocol NewsTypeDelegate <NSObject>

-(void)openNewsDetailsController:(NewsDetailsController*)newsDetailsController;

@end

@interface NewsController : BaseController
@property (nonatomic, weak) id <NewsTypeDelegate> newsDelegate;
@end
