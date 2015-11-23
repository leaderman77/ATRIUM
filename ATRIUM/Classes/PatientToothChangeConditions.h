//
// Created by Sanch0 on 7/13/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseToothConditionState.h"

@protocol PatientToothChangeConditions

@end


@interface PatientToothChangeConditions : BaseToothConditionState

@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *treatment;
@property (nonatomic, strong) SelectItem *existingTreatment;
@property (nonatomic, strong) SelectItem *diagnosisCode;
@property (nonatomic, strong) NSNumber *appointmentId;
@property (nonatomic, strong) NSNumber *dentalTransactionId;
@property (nonatomic, strong) SelectItem *creator;
@property (nonatomic, assign) BOOL revert;


@end