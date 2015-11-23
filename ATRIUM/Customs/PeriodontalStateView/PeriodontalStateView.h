//
//  PeriodontalStateView.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/13/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kStatusViewBorderColor      rgbColor(70, 68, 75)

@interface PeriodontalStateView : UIView
@property (nonatomic, strong) UILabel *pdLabel;
@property (nonatomic, strong) UILabel *gmLabel;
@property (nonatomic, strong) UILabel *caLabel;
- (void)drawViewWith:(id)toothItem;
- (instancetype)initForTitleCaptionsWithFrame:(CGRect)frame;

@end
