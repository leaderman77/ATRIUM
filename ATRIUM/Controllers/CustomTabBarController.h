//
//  CustomTabBarController.h
//  ATRIUM
//
//  Created by Admin on 10/16/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatsController.h"
#import "AnnouncementsController.h"
#import "NewsController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)
#define addHeight 88


@protocol tabbarDelegate <NSObject>

-(void)touchBtnAtIndex:(NSInteger)index;

@end

@class tabbarView;


@interface CustomTabBarController : UIViewController<tabbarDelegate>

@property(nonatomic,strong) tabbarView *tabbar;
@property(nonatomic,strong) NSArray *arrayViewcontrollers;
@property (nonatomic, strong) ChatsController *chatsController;
@end
