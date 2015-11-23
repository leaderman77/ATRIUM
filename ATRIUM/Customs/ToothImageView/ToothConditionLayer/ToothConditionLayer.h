//
// Created by Sanch0 on 4/21/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LayerPosition) {
    LayerPositionTop,
    LayerPositionBottom,
};

@interface ToothConditionLayer : CALayer

@property (nonatomic, assign) LayerPosition layerPosition;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *conditionCode;

//@property (nonatomic, weak) UIImage *image;

+ (ToothConditionLayer *)toothConditionLayerWithImage:(UIImage *)image onView:(UIView *)view;

+ (ToothConditionLayer *)toothConditionLayerWithImage:(UIImage *)image onView:(UIView *)view withLayerPosition:(LayerPosition)layerPosition;

- (instancetype)initWithImage:(UIImage *)image onView:(UIView *)view withLayerPosition:(LayerPosition)layerPosition;

@end