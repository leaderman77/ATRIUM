//
// Created by Sanch0 on 7/14/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FavouriteIconView : CustomBtn

@property (nonatomic, strong) NSString *bottomTitle;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIButton *iconBtn;
+ (FavouriteIconView *)iconViewWithFrame:(CGRect)frame withIconImage:(UIImage *)image withBottomTitle:(NSString *)title;


@end