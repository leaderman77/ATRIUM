//
// Created by Sanch0 on 3/11/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "RadioCircleBtn.h"



@implementation RadioCircleBtn {

//    UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(id)title {
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.borderWidth = 1.f;
        self.title = title;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        UIImage *activeImage = [UIImage imageNamed:@"follow_up_radiobutton_active.png"];
        UIImage *inactiveImage = [UIImage imageNamed:@"follow_up_radiobutton.png"];
        CGFloat left = activeImage.size.width + 20;
        _btnTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, self.width - left - 2, self.height)];
        if ([title isKindOfClass:[NSAttributedString class]]) {
            _btnTitleLabel.attributedText = title;
        } else if ([title isKindOfClass:[NSString class]]) {
            _btnTitleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withFontSize:14.f];
        }

        [self setImage:activeImage forState:UIControlStateSelected];
        [self setImage:inactiveImage forState:UIControlStateNormal];
        _btnTitleLabel.userInteractionEnabled = NO;
        [self addSubview:_btnTitleLabel];
    }

    return self;
}

@end