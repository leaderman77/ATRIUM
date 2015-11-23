//
// Created by Sanch0 on 3/23/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DiagnosisCode;


@interface DiagnosisesForPrescription : NSObject

@property (nonatomic, strong) DiagnosisCode *primaryDiagnosis;
@property (nonatomic, strong) NSMutableArray <SelectItem> *secondaryDiagnosises;
@property (nonatomic, strong) NSMutableSet *selectedSecondaryDiagnosisCodes;

- (BOOL)secondaryDiagnosisesContains:(DiagnosisCode *)diagnosisCode;

- (void)addSecondaryDiagnosisCode:(DiagnosisCode *)diagnosisCode;

- (void)removeSecondaryDiagnosisCode:(DiagnosisCode *)diagnosisCode;

@end