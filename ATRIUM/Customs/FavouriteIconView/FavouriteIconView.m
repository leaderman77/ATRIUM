//
// Created by Sanch0 on 7/14/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "FavouriteIconView.h"

#define ICON_LABEL_HEIGHT 20

@interface FavouriteIconView ()


@property (nonatomic, strong) UILabel *iconLabel;

@end

@implementation FavouriteIconView {

}

+ (FavouriteIconView *)iconViewWithFrame:(CGRect)frame withIconImage:(UIImage *)image withBottomTitle:(NSString *)title {
    FavouriteIconView *iconView = [[FavouriteIconView alloc] initWithFrame:frame];
    iconView.iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, iconView.width - 20, iconView.height - ICON_LABEL_HEIGHT- 10)];
//    iconView.iconBtn.layer.cornerRadius = 5.f;
//    iconView.iconBtn.layer.borderWidth = 1.f;
    [iconView makeBorderWithCornerRadius];
    iconView.iconBtn.userInteractionEnabled = NO;
    iconView.userInteractionEnabled = YES;
//    iconView.iconBtn.image = image ? image : [UIImage imageNamed:@"fav-icon1.png"];
    iconView.backgroundImage = [UIImage imageFromColor:[UIColor whiteColor]];
    [iconView addSubview:iconView.iconBtn];

    UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconView.iconBtn.height + 12, iconView.width, ICON_LABEL_HEIGHT)];
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withFontSize:12];
    [iconView addSubview:iconLabel];
    iconView.iconLabel = iconLabel;

    return iconView;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [super addTarget:target action:action forControlEvents:controlEvents];
//    [_iconBtn addTarget:target action:action forControlEvents:controlEvents];
}


- (NSString *)bottomTitle {
    return _iconLabel.text;
}

- (void)setBottomTitle:(NSString *)bottomTitle {
    _iconLabel.attributedText = [NSAttributedString attributedStringWithTitle:bottomTitle withFontSize:12];
}

- (UIImage *)iconImage {
    return _iconBtn.image;
}

- (void)setIconImage:(UIImage *)iconImage {
    _iconBtn.image = iconImage;
}


@end