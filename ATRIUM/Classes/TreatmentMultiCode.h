//
// Created by Sanch0 on 2/12/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TreatmentItem;


@interface TreatmentMultiCode : BaseObject

@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) SelectItem *area;
@property (nonatomic, assign) NSInteger maxCodeCount;
@property (nonatomic, strong) TreatmentItem *treatmentCode1;
@property (nonatomic, strong) TreatmentItem *treatmentCode2;
@property (nonatomic, strong) TreatmentItem *treatmentCode3;
@property (nonatomic, strong) TreatmentItem *treatmentCode4;
@property (nonatomic, strong) TreatmentItem *treatmentCode5;
@property (nonatomic, strong) TreatmentItem *treatmentCode6;
@property (nonatomic, assign) BOOL system;

@property (nonatomic, strong) NSDictionary <Ignore> *maxCodesDic;


@end