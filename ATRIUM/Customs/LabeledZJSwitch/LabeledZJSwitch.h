//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJSwitch.h"


@interface LabeledZJSwitch : UIView

@property (nonatomic, strong) ZJSwitch *zjSwitch;
@property (nonatomic, strong) UILabel *titleLabel;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

@end