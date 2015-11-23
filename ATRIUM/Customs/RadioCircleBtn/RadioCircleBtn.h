//
// Created by Sanch0 on 3/11/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RadioCircleBtn : CustomBtn

@property (nonatomic, strong) id title;
@property (nonatomic, strong, readonly) UILabel *btnTitleLabel;
- (instancetype)initWithFrame:(CGRect)frame withTitle:(id)title;

@end