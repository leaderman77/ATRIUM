//
//  PeriodontalToothActionView.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/12/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PeriodontalToothView.h"
#import "PeriodontalToothWithPolyline.h"
//#import "ToothDetailsType.h"
#import "ToothItem.h"

@interface PeriodontalToothView () {
    UIImageView *toothImageView;
}

@end

@implementation PeriodontalToothView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)createAndLayoutSubviews {
    toothImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 18, self.width, 122)];
    
    [self addSubview:toothImageView];
    _periodontalToothWithPolyline = [[PeriodontalToothWithPolyline alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [_periodontalToothWithPolyline setToothItem:self.toothItem];
     _periodontalToothWithPolyline.isTop = self.isTop;
    [_periodontalToothWithPolyline createAndLayoutSubviews];
    [self addSubview:_periodontalToothWithPolyline];
    if([self isTop]) {
        toothImageView.top = 18;
        toothImageView.contentMode = UIViewContentModeBottom;
    } else {
        toothImageView.top = 3;
        toothImageView.contentMode = UIViewContentModeTop;
    }
    toothImageView.image = self.toothItem.toothDetailsType.toothImage;
}

- (void)setIsFromToothDetailsView:(BOOL)isFromToothDetailsView {
    if(isFromToothDetailsView) {
        self.periodontalToothWithPolyline.toothWidth = 60;
        self.periodontalToothWithPolyline.polyLinePadding = 20;
        self.periodontalToothWithPolyline.padding = 5;
    }
    _isFromToothDetailsView = isFromToothDetailsView;
}

//- (void)setToothItem:(ToothItem *)toothItem {
//    _toothItem = toothItem;
//}

- (void)setIsTop:(BOOL)isTop {
    if(_isTop != isTop) {
         _isTop = isTop;
        if([self isTop]) {
            toothImageView.top = 18;
            toothImageView.contentMode = UIViewContentModeBottom;
        } else {
            toothImageView.top = 3;
            toothImageView.contentMode = UIViewContentModeTop;
        }
        [self setNeedsDisplay];
    }
   
}

- (void)drawToothWithConditions {
   
    [_periodontalToothWithPolyline setNeedsDisplay];

//    toothImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_1.png", self.toothItem.toothDetailsType.numeric2.integerValue]];
}

- (void)reloadView:(ToothItem *)toothItem {
    self.toothItem = toothItem;
    _periodontalToothWithPolyline.isTop = self.isTop;
    [_periodontalToothWithPolyline reloadView:toothItem];
    toothImageView.image = self.toothItem.toothDetailsType.toothImage;

}

- (void)drawRect:(CGRect)rect {
    CGFloat left = 0;
    CGFloat width = self.width - left;
    CGFloat top = (self.isTop) ? 5 : 45;
    CGFloat padding = 5;
    for (int i = 1; i <= 20; i++) {
        UIBezierPath *aPath = [UIBezierPath bezierPath];
        [aPath moveToPoint:CGPointMake(left, top)];
        [aPath addLineToPoint:CGPointMake(width, top)];
        
        aPath.lineWidth = 1;
        [[UIColor blueColor] setStroke];
        [aPath stroke];
        top += padding;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
