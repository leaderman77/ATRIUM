//
// Created by Sanch0 on 4/21/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ToothConditionLayer.h"

@interface ToothConditionLayer ()

@property (nonatomic, weak) UIView *superView;
@end

@implementation ToothConditionLayer {

}

+ (ToothConditionLayer *)toothConditionLayerWithImage:(UIImage *)image onView:(UIView *)view {
    ToothConditionLayer *conditionLayer = [[ToothConditionLayer alloc] init];
    conditionLayer.frame = CGRectMake(0.5 * (view.width - image.size.width), 0, image.size.width, image.size.height);
    conditionLayer.contents = (id) image.CGImage;
    [view.layer addSublayer:conditionLayer];
    conditionLayer.superView = view;
    return conditionLayer;
}

+ (ToothConditionLayer *)toothConditionLayerWithImage:(UIImage *)image onView:(UIView *)view withLayerPosition:(LayerPosition)layerPosition {
    ToothConditionLayer *conditionLayer = [[ToothConditionLayer alloc] initWithImage:image onView:view withLayerPosition:layerPosition];
//    conditionLayer.borderWidth = 1.f;
    return conditionLayer;
}


- (instancetype)initWithImage:(UIImage *)image onView:(UIView *)view withLayerPosition:(LayerPosition)layerPosition {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.5 * (view.width - image.size.width), 0, image.size.width, image.size.height);
        self.contents = (id) image.CGImage;
        self.superView = view;
        self.layerPosition = layerPosition;
        [self.superView.layer addSublayer:self];
    }
    return self;
}


- (void)setLayerPosition:(LayerPosition)layerPosition {
    _layerPosition = layerPosition;
    switch (layerPosition) {
        case LayerPositionTop: {
            self.frame = CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height);
        };
            break;
        case LayerPositionBottom: {
            self.frame = CGRectMake(self.frame.origin.x, self.superView.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        };
            break;
    }
}


@end