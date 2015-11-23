//
// Created by Sanch0 on 4/21/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ToothDetailsType;
@class ToothConditionLayer;
@class PatientToothConditions;
@class PatientToothConditionWithChanges;
@class OrderedDictionary;


@interface ToothImageView : UIImageView

@property (nonatomic, strong) PatientToothConditions *toothConditions;
@property (nonatomic, strong) PatientToothConditionWithChanges *toothConditionWithChanges;
@property (nonatomic, strong, readonly) OrderedDictionary *toothConditionsLayers;
@property (nonatomic, assign) BOOL isSurfaceView;
@property (nonatomic, strong) UIImageView *arrow;

//@property (nonatomic, weak) ToothDetailsType *toothDetailsType;

//+ (ToothImageView *)toothImageViewWithInstance:(ToothImageView *)toothImageView;

- (void)removeAllConditions;

- (void)addToothConditionsLayer:(ToothConditionLayer *)toothConditionLayer;
//- (void)removeToothConditionsLayer:(ToothConditionLayer *)toothConditionLayer;

@end