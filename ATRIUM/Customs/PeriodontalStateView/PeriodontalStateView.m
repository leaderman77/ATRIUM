//
//  PeriodontalStateView.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/13/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PeriodontalStateView.h"
#import "ToothItem.h"
#import "PerioExam.h"

#define kLabelsFontSize           15.0

@implementation PeriodontalStateView
//60x96
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        CGFloat height = self.height / 3.0;
        _pdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
        _gmLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height , self.width, height)];
        _caLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height * 2, self.width, height)];
//        _pdLabel.font = _gmLabel.font = _caLabel.font = [UIFont systemFontOfSize:kLabelsFontSize];
        _pdLabel.textColor = _gmLabel.textColor = _caLabel.textColor = rgbColor(71, 69, 76);
        _pdLabel.textAlignment = _gmLabel.textAlignment = _caLabel.textAlignment = NSTextAlignmentCenter;
        [_pdLabel addBottomBorderWithHeight:1 andColor:kStatusViewBorderColor];
        [_gmLabel addBottomBorderWithHeight:1 andColor:kStatusViewBorderColor];
        _pdLabel.attributedText = _gmLabel.attributedText = [self attraibutedString:0 withcenter:0 withRight:0];
        _caLabel.attributedText = [self attraibutedString:0 withcenter:0 withRight:0];
        _caLabel.textColor = rgbColor(34, 34, 43);
        _caLabel.font = FONT_SANSUMI_BOLD(15);
        [self addSubview:_pdLabel];
        [self addSubview:_gmLabel];
        [self addSubview:_caLabel];
        _caLabel.minimumScaleFactor = 0.5;
        [self addRightBorderWithWidth:1 andColor:kStatusViewBorderColor];
    }
    return self;
}

- (NSAttributedString *)attraibutedString:(NSInteger)left withcenter:(NSInteger)center withRight:(NSInteger)right {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithTitle:[NSString stringWithFormat:@"%i", left] withTextColor:[self colorState:left] withBoldFontSize: (left > 9) ? kLabelsFontSize - 1.5 : kLabelsFontSize]];
    [attrStr appendAttributedString:[NSAttributedString attributedStringWithTitle:[NSString stringWithFormat:@"%i", center] withTextColor:[self colorState:center] withBoldFontSize:(center > 9) ? kLabelsFontSize - 1.5 : kLabelsFontSize]];
    [attrStr appendAttributedString:[NSAttributedString attributedStringWithTitle:[NSString stringWithFormat:@"%i", right] withTextColor:[self colorState:right] withBoldFontSize:(right > 9) ? kLabelsFontSize - 1.5 : kLabelsFontSize]];
    return attrStr;
}

- (NSAttributedString *)attachmentAtrubutedString:(NSInteger)left withcenter:(NSInteger)center withRight:(NSInteger)right {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithTitle:[NSString stringWithFormat:@"%i", left] withTextColor:rgbColor(34, 34, 43) withBoldFontSize:(left > 9) ? kLabelsFontSize - 2.5 : kLabelsFontSize]];
    [attrStr appendAttributedString:[NSAttributedString attributedStringWithTitle:[NSString stringWithFormat:@"%i", center] withTextColor:rgbColor(34, 34, 43) withBoldFontSize:(center > 9) ? kLabelsFontSize - 2.5 : kLabelsFontSize]];
    [attrStr appendAttributedString:[NSAttributedString attributedStringWithTitle:[NSString stringWithFormat:@"%i", right] withTextColor:rgbColor(34, 34, 43) withBoldFontSize:(right > 9) ? kLabelsFontSize - 2.5 : kLabelsFontSize]];
    return attrStr;
}

- (UIColor *)colorState:(NSInteger)state {
     return (state >= 0 && state <= 3) ? [UIColor greenColor] : (state >= 4 && state <= 6) ? [UIColor orangeColor] : [UIColor redColor];
}

- (void)drawViewWith:(ToothItem *)toothItem {
    PerioExam *perioExam = toothItem.perioExam;
    _pdLabel.attributedText = [self attraibutedString:perioExam.probingDepthDistal.integerValue  withcenter:perioExam.probingDepthCentral.integerValue withRight:perioExam.probingDepthMesial.integerValue];
    _gmLabel.attributedText = [self attraibutedString:perioExam.gingivalMarginDistal.integerValue withcenter:perioExam.gingivalMarginCentral.integerValue withRight:perioExam.gingivalMarginMesial.integerValue];
//    _caLabel.text = [[self attachmentAtrubutedString:perioExam.clinicalAttachmentDistal.integerValue withcenter:perioExam.clinicalAttachmentCentral.integerValue withRight:perioExam.clinicalAttachmentMesial.integerValue] string];
    _caLabel.text = [NSString stringWithFormat:@"%i%i%i",perioExam.clinicalAttachmentDistal.integerValue, perioExam.clinicalAttachmentCentral.integerValue, perioExam.clinicalAttachmentMesial.integerValue];
    _caLabel.minimumScaleFactor = 0.9;
}

- (instancetype)initForTitleCaptionsWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        CGFloat height = self.height / 3.0;
        _pdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
        _gmLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height , self.width, height)];
        _caLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height * 2, self.width, height)];
        _pdLabel.font = _gmLabel.font = _caLabel.font = FONT_SANSUMI(16);//[UIFont systemFontOfSize:16];
        _pdLabel.textColor = _gmLabel.textColor = _caLabel.textColor = rgbColor(71, 69, 76);
        _pdLabel.textAlignment = _gmLabel.textAlignment = _caLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pdLabel];
        [self addSubview:_gmLabel];
        [self addSubview:_caLabel];
        _pdLabel.text = TRANSLATE(@"PD");
        _gmLabel.text = TRANSLATE(@"GM");
        _caLabel.text = TRANSLATE(@"CA");
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
