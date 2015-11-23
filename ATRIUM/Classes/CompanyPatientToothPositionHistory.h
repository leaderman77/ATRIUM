//
// Created by Sanch0 on 6/4/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseToothConditionState.h"


@interface CompanyPatientToothPositionHistory : BaseToothConditionState

@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *treatment;
@property (nonatomic, strong) SelectItem *diagnosisCode;
@property (nonatomic, strong) NSNumber *appointmentId;
@property (nonatomic, strong) NSNumber *dentalTransactionId;
@property (nonatomic, strong) SelectItem *creator; //dentist

@end