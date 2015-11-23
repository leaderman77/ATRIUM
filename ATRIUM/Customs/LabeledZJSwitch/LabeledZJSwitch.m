//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "LabeledZJSwitch.h"

#define SWITCH_WIDTH 80.f
#define SWITCH_HEIGHT 30.f

@implementation LabeledZJSwitch


- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.borderWidth = 1.f;

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width - SWITCH_WIDTH - 5, self.height)];
        self.titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withFontSize:14.f];
        [self addSubview:self.titleLabel];

        CGFloat top = 0.5 * (self.height - SWITCH_HEIGHT);
        self.zjSwitch = [[ZJSwitch alloc] initWithFrame:CGRectMake(self.titleLabel.width + 5, top, SWITCH_WIDTH, SWITCH_HEIGHT)];
        self.zjSwitch.style = ZJSwitchStyleNoBorder;
        self.zjSwitch.onTintColor = UIColorFromRGB(0xBEC945);
        self.zjSwitch.textFont = FONT_SANSUMI_BOLD(12.f);
        self.zjSwitch.onText = TRANSLATE(@"YES");
        self.zjSwitch.offText = TRANSLATE(@"NO");
//        self.zjSwitch.on = alertItem.selected;

        [self addSubview:self.zjSwitch];
    }

    return self;
}




@end