//
//  PeriodontalActionsView.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/12/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToothItem;

@interface PeriodontalToothWithPolyline : UIView

@property (nonatomic, strong) ToothItem *toothItem;
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, assign) CGFloat toothWidth;
@property (nonatomic, assign) CGFloat polyLinePadding;
@property (nonatomic, assign) CGFloat padding;
- (void)reloadView:(ToothItem*)toothItem;


@end
