//
// Created by Sanch0 on 7/13/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PatientToothConditions;
@protocol PatientToothChangeConditions;


@interface PatientToothConditionWithChanges : BaseObject

@property (nonatomic, strong) NSString *toothPositionCode;
@property (nonatomic, strong) PatientToothConditions *toothConditions;
@property (nonatomic, strong) NSMutableArray <PatientToothChangeConditions> *toothChangeConditions;
@end