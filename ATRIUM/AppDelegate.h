//
//  AppDelegate.h
//  ATRIUM
//
//  Created by Admin on 10/9/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CustomNavigationController *navigationController;
@property (weak, nonatomic) id<BaseProtocol> loaderView;


@end

