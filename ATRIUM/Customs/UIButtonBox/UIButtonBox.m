//
// Created by Sanch0 on 11/26/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "UIButtonBox.h"


@implementation UIButtonBox

const int kTextTopPadding = 2;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

    CGRect titleLabelFrame = self.titleLabel.frame;
    CGSize labelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

    CGRect imageFrame = self.imageView.frame;
    NSInteger topPadding = self.padding > 0 ? self.padding : kTextTopPadding;

    CGSize fitBoxSize = (CGSize) {.height = labelSize.height + topPadding + imageFrame.size.height, .width = MAX(imageFrame.size.width, labelSize.width)};

    CGRect fitBoxRect = CGRectInset(self.bounds, (self.bounds.size.width - fitBoxSize.width) / 2, (self.bounds.size.height - fitBoxSize.height) / 2);

    imageFrame.origin.y = fitBoxRect.origin.y;
    imageFrame.origin.x = CGRectGetMidX(fitBoxRect) - (imageFrame.size.width / 2);
    self.imageView.frame = imageFrame;

    // Adjust the label size to fit the text, and move it below the image

    titleLabelFrame.size.width = labelSize.width;
    titleLabelFrame.size.height = labelSize.height;
    titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.width / 2);
    titleLabelFrame.origin.y = fitBoxRect.origin.y + imageFrame.size.height + topPadding;
    self.titleLabel.frame = titleLabelFrame;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
