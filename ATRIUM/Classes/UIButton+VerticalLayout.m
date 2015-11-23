//
// Created by Sanch0 on 11/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "UIButton+VerticalLayout.h"

//const int kTextTopPadding = 2;

@implementation UIButton (VerticalLayout)

- (void)centerVerticallyWithPadding:(float)padding
{
    CGSize imageSize = self.imageView.frame.size;
//    CGSize titleSize = self.titleLabel.frame.size;
    CGSize titleSize = CGSizeZero;
    if ([self.titleLabel.text respondsToSelector:@selector(sizeWithAttributes:)]) {
        titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    }
//        else {
//        [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
//    }

    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);

    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
            0.0f,
            0.0f,
            - titleSize.width);

    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
            - imageSize.width,
            - (totalHeight - titleSize.height),
            0.0f);

}


- (void)centerVertically
{
    const CGFloat kDefaultPadding = 6.0f;

    [self centerVerticallyWithPadding:kDefaultPadding];
}

- (void)layoutVertically {
   /* self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

    CGRect titleLabelFrame = self.titleLabel.frame;
    CGSize labelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

    CGRect imageFrame = self.imageView.frame;

    CGSize fitBoxSize = (CGSize){.height = labelSize.height + kTextTopPadding +  imageFrame.size.height, .width = MAX(imageFrame.size.width, labelSize.width)};

    CGRect fitBoxRect = CGRectInset(self.bounds, (self.bounds.size.width - fitBoxSize.width)/2, (self.bounds.size.height - fitBoxSize.height)/2);

    imageFrame.origin.y = fitBoxRect.origin.y;
    imageFrame.origin.x = CGRectGetMidX(fitBoxRect) - (imageFrame.size.width/2);
    self.imageView.frame = imageFrame;

    // Adjust the label size to fit the text, and move it below the image

    titleLabelFrame.size.width = labelSize.width;
    titleLabelFrame.size.height = labelSize.height;
    titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.width / 2);
    titleLabelFrame.origin.y = fitBoxRect.origin.y + imageFrame.size.height + kTextTopPadding;
    self.titleLabel.frame = titleLabelFrame;*/

}


@end