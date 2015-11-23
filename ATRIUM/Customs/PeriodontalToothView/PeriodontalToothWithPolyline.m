//
//  PeriodontalActionsView.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/12/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PeriodontalToothWithPolyline.h"
#import "ToothItem.h"
#import "PerioExam.h"
#import "CALayer+Additions.h"

#define ORANGE_RED_LINE_WIDTH 3.f

@interface PeriodontalToothWithPolyline ()
{
    CALayer *fucationLayer;
    CALayer *leftDropLayer;
    CALayer *centerDropLayer;
    CALayer *rightDropLayer;
}


@end


@implementation PeriodontalToothWithPolyline


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)createAndLayoutSubviews {
    self.backgroundColor = [UIColor clearColor];
    fucationLayer = [CALayer layer];
    UIImage *image = [UIImage imageNamed:@"fucation-1.png"];
    fucationLayer.frame = CGRectMake(0.5 * (self.width - image.size.width), (self.isTop) ? 60 : 60, image.size.width, image.size.height);
    
    UIImage *dropImage = [UIImage imageNamed:@"perio_exam_4_drops_red.png"];
    CGFloat padding = 5;
    CGFloat top = (self.isTop) ? 90 : 45;
    //        CGFloat toothWidth = 40;
    CGFloat width = roundf(dropImage.size.width);
    CGFloat height = roundf(dropImage.size.height);
    CGFloat left = 0.5 * (self.width - 3 * width - 2 * padding);
    leftDropLayer = [CALayer layer];
    centerDropLayer = [CALayer layer];
    rightDropLayer = [CALayer layer];
    
    leftDropLayer.frame = CGRectMake(left, top, width, height);
    leftDropLayer.hidden = YES;
    left += width + padding;
    centerDropLayer.frame = CGRectMake(left, top, width, height);
    centerDropLayer.hidden = YES;
    left += width + padding;
    rightDropLayer.frame = CGRectMake(left, top, width, height);
    rightDropLayer.hidden = YES;
    [self.layer addSublayer:leftDropLayer];
    [self.layer addSublayer:centerDropLayer];
    [self.layer addSublayer:rightDropLayer];
    self.padding = 5;
    self.polyLinePadding = 5;
    self.toothWidth = 45;
}

- (UIImage *)imageByDropState:(DropState)dropState {
    UIImage *image = nil;
    switch (dropState) {
        case kBleedingRedState:
            image = [UIImage imageNamed:@"perio_exam_4_drops_red.png"];
            break;
        case kSupporationYellowState:
            image = [UIImage imageNamed:@"perio_exam_4_drops_yellow.png"];
            break;
        case kBleedSupporationPinkState:
            image = [UIImage imageNamed:@"perio_exam_4_drops_pink.png"];
            break;
        default:
            break;
    }
    return image;
}

- (UIImage *)imageByBleding:(BOOL)isBleding withSupparation:(BOOL)isSupparation {
    UIImage *image = nil;
    if(isBleding && isSupparation) {
        image = [UIImage imageNamed:@"perio_exam_4_drops_pink.png"];
    } else if(isBleding) {
        image = [UIImage imageNamed:@"perio_exam_4_drops_red.png"];
    } else if(isSupparation) {
        image = [UIImage imageNamed:@"perio_exam_4_drops_yellow.png"];
    }
//    if(!self.isTop) {
//        image = [[UIImage alloc] initWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationDown];
//    }
    return image;
}

- (void)setIsTop:(BOOL)isTop {
    if(_isTop != isTop) {
        leftDropLayer.top = centerDropLayer.top = rightDropLayer.top = (isTop) ? 90 : 45;
        fucationLayer.top = (isTop) ? 60 : 80;
    }
    _isTop = isTop;
    
}

- (void)setToothItem:(ToothItem *)toothItem {
    PerioExam *oldPerioExam = _toothItem.perioExam;
    PerioExam *perioExam = toothItem.perioExam;
    if(1 || (perioExam.bleedingDistal != oldPerioExam.bleedingDistal && perioExam.suppurationDistal != oldPerioExam.suppurationDistal)) {
        UIImage *image = [self imageByBleding:perioExam.bleedingDistal withSupparation:perioExam.suppurationDistal];
        leftDropLayer.contents = (id) image.CGImage;
        leftDropLayer.hidden = image ? NO : YES;
    }
    
    if(1 || (perioExam.bleedingCentral != oldPerioExam.bleedingCentral && perioExam.suppurationCentral != oldPerioExam.suppurationCentral)) {
        UIImage *image = [self imageByBleding:perioExam.bleedingCentral withSupparation:perioExam.suppurationCentral];
        centerDropLayer.contents = (id) image.CGImage;
        centerDropLayer.hidden = image ? NO : YES;
    }
    if(1 || (perioExam.bleedingMesial != oldPerioExam.bleedingMesial && perioExam.suppurationMesial != oldPerioExam.suppurationMesial)) {
        UIImage *image = [self imageByBleding:perioExam.bleedingMesial withSupparation:perioExam.suppurationMesial];
        rightDropLayer.contents = (id) image.CGImage;
        rightDropLayer.hidden = image ? NO : YES;
    }
    if(1 || ![perioExam.furcationStatus isEqualToNumber:oldPerioExam.furcationStatus]) {
        if(perioExam.furcationStatus) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fucation-%ld", (long) perioExam.furcationStatus.integerValue]];
            fucationLayer.contents = (id) image.CGImage;
            [self.layer addSublayer:fucationLayer];
        } else {
            [fucationLayer removeFromSuperlayer];
        }
    }
//    leftDropLayer.affineTransform = centerDropLayer.affineTransform = rightDropLayer.affineTransform = (self.isTop) ? CGAffineTransformMakeRotation(0) :  CGAffineTransformMakeRotation(M_PI / 2.0);;
    _toothItem = toothItem;
}

- (void)reloadView:(ToothItem *)toothItem {
    self.toothItem = toothItem;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    PerioExam *perioExam = _toothItem.perioExam;
    CGFloat left = 0;
    CGFloat width = self.width - left;
    CGFloat top = self.isTop ? 5 : 45;
    CGFloat padding = self.padding;
    CGFloat toothWidth = self.toothWidth;
    CGFloat polyLinePadding = self.polyLinePadding;
    UIBezierPath *greenPath = [UIBezierPath bezierPath];
    if(self.isTop) {
        top = 20 * 5;
//        CGFloat toothWidth = self.toothWidth;
//        CGFloat polyLinePadding = self.polyLinePadding;
//        UIBezierPath *greenPath = [UIBezierPath bezierPath];
        [greenPath moveToPoint:CGPointMake(left, top)];
        
        left = 0.5 * (self.width - toothWidth) - polyLinePadding;
        [greenPath addLineToPoint:CGPointMake(left, top)];
        
        left += polyLinePadding;
        [greenPath addLineToPoint:CGPointMake(left, top - padding * perioExam.clinicalAttachmentDistal.integerValue)];
        [greenPath addLineToPoint:CGPointMake(left + toothWidth / 2, top - padding * perioExam.clinicalAttachmentCentral.integerValue)];
        [greenPath addLineToPoint:CGPointMake(left + toothWidth, top - padding * perioExam.clinicalAttachmentMesial.integerValue)];
        left += polyLinePadding + toothWidth;
        
        [greenPath addLineToPoint:CGPointMake(left, top)];
        [greenPath addLineToPoint:CGPointMake(width, top)];
        
        greenPath.lineWidth = ORANGE_RED_LINE_WIDTH;
        [[UIColor greenColor] setStroke];
        [greenPath stroke];
        left = 0;
        UIBezierPath *redPath = [UIBezierPath bezierPath];
        [redPath moveToPoint:CGPointMake(left, top)];
        
        left = 0.5 * (self.width - toothWidth) - polyLinePadding;
        [redPath addLineToPoint:CGPointMake(left, top)];
        
        left += polyLinePadding;
        [redPath addLineToPoint:CGPointMake(left, top - padding * perioExam.probingDepthDistal.integerValue)];
        [redPath addLineToPoint:CGPointMake(left + toothWidth / 2, top - padding * perioExam.probingDepthCentral.integerValue)];
        [redPath addLineToPoint:CGPointMake(left + toothWidth, top - padding * perioExam.probingDepthMesial.integerValue)];
        left += polyLinePadding + toothWidth;
        
        [redPath addLineToPoint:CGPointMake(left, top)];
        [redPath addLineToPoint:CGPointMake(width, top)];
        
        redPath.lineWidth = ORANGE_RED_LINE_WIDTH;
        [[UIColor redColor] setStroke];
        [redPath stroke];
        
        //    top += padding;
        left = 0 ;
       
        UIBezierPath *orangePath = [UIBezierPath bezierPath];
        [orangePath moveToPoint:CGPointMake(left, top)];
        left = 0.5 * (self.width - toothWidth) - polyLinePadding;
        [orangePath addLineToPoint:CGPointMake(left, top)];
        
        left += polyLinePadding;
        [orangePath addLineToPoint:CGPointMake(left, top - padding * (perioExam.probingDepthDistal.integerValue + perioExam.gingivalMarginDistal.integerValue))];
        [orangePath addLineToPoint:CGPointMake(left + toothWidth / 2, top - padding * (perioExam.probingDepthCentral.integerValue + perioExam.gingivalMarginCentral.integerValue))];
        [orangePath addLineToPoint:CGPointMake(left + toothWidth, top - padding * (perioExam.probingDepthMesial.integerValue + perioExam.gingivalMarginMesial.integerValue))];
        left += polyLinePadding + toothWidth;
        
        [orangePath addLineToPoint:CGPointMake(left, top)];
        [orangePath addLineToPoint:CGPointMake(width, top)];
        
        orangePath.lineWidth = ORANGE_RED_LINE_WIDTH;
        [[UIColor orangeColor] setStroke];
        [orangePath stroke];
    } else {
        top = 45;
//        CGFloat toothWidth = self.toothWidth;
//        CGFloat polyLinePadding = self.polyLinePadding;
//        UIBezierPath *greenPath = [UIBezierPath bezierPath];
        [greenPath moveToPoint:CGPointMake(left, top)];
        
        left = 0.5 * (self.width - toothWidth) - polyLinePadding;
        [greenPath addLineToPoint:CGPointMake(left, top)];
        
        left += polyLinePadding;
        [greenPath addLineToPoint:CGPointMake(left, top + padding * perioExam.clinicalAttachmentDistal.integerValue)];
        [greenPath addLineToPoint:CGPointMake(left + toothWidth / 2, top + padding * perioExam.clinicalAttachmentCentral.integerValue)];
        [greenPath addLineToPoint:CGPointMake(left + toothWidth, top + padding * perioExam.clinicalAttachmentMesial.integerValue)];
        left += polyLinePadding + toothWidth;
        
        [greenPath addLineToPoint:CGPointMake(left, top)];
        [greenPath addLineToPoint:CGPointMake(width, top)];
        
        greenPath.lineWidth = ORANGE_RED_LINE_WIDTH;
        [[UIColor greenColor] setStroke];
        [greenPath stroke];
        left = 0;
        UIBezierPath *redPath = [UIBezierPath bezierPath];
        [redPath moveToPoint:CGPointMake(left, top)];
        
        left = 0.5 * (self.width - toothWidth) - polyLinePadding;
        [redPath addLineToPoint:CGPointMake(left, top)];
        
        left += polyLinePadding;
        [redPath addLineToPoint:CGPointMake(left, top + padding * perioExam.probingDepthDistal.integerValue)];
        [redPath addLineToPoint:CGPointMake(left + toothWidth / 2, top + padding * perioExam.probingDepthCentral.integerValue)];
        [redPath addLineToPoint:CGPointMake(left + toothWidth, top + padding * perioExam.probingDepthMesial.integerValue)];
        left += polyLinePadding + toothWidth;
        
        [redPath addLineToPoint:CGPointMake(left, top)];
        [redPath addLineToPoint:CGPointMake(width, top)];
        
        redPath.lineWidth = ORANGE_RED_LINE_WIDTH;
        [[UIColor redColor] setStroke];
        [redPath stroke];
        
        //    top += padding;
        left = 0 ;
        
        UIBezierPath *orangePath = [UIBezierPath bezierPath];
        [orangePath moveToPoint:CGPointMake(left, top)];
        left = 0.5 * (self.width - toothWidth) - polyLinePadding;
        [orangePath addLineToPoint:CGPointMake(left, top)];
        
        left += polyLinePadding;
        [orangePath addLineToPoint:CGPointMake(left, top + padding * (perioExam.probingDepthDistal.integerValue + perioExam.gingivalMarginDistal.integerValue))];
        [orangePath addLineToPoint:CGPointMake(left + toothWidth / 2, top + padding * (perioExam.probingDepthCentral.integerValue + perioExam.gingivalMarginCentral.integerValue))];
        [orangePath addLineToPoint:CGPointMake(left + toothWidth, top + padding * (perioExam.probingDepthMesial.integerValue + perioExam.gingivalMarginMesial.integerValue))];
        left += polyLinePadding + toothWidth;
        
        [orangePath addLineToPoint:CGPointMake(left, top)];
        [orangePath addLineToPoint:CGPointMake(width, top)];
        
        orangePath.lineWidth = ORANGE_RED_LINE_WIDTH;
        [[UIColor orangeColor] setStroke];
        [orangePath stroke];
    }
    
    return;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
