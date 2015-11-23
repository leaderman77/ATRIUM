//
//  PeriodontalToothActionView.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/12/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToothItem, PeriodontalToothWithPolyline;
@interface PeriodontalToothView : UIView
@property (nonatomic, assign) BOOL isTop;
@property (nonatomic, strong) ToothItem *toothItem;
@property (nonatomic, strong) PeriodontalToothWithPolyline *periodontalToothWithPolyline;
@property (nonatomic, assign) BOOL isFromToothDetailsView;;
@property (nonatomic, strong) UIImage *toothImage;
    
- (void)reloadView:(ToothItem *)toothItem;
@end
