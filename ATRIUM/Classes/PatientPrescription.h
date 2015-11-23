//
// Created by Sanch0 on 3/11/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Prescription;
@protocol Prescription;

@interface PatientPrescription : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSURL *pdfUrl;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *prescriptionTemplate;
@property (nonatomic, strong) Prescription *prescription;
@property (nonatomic, strong) SelectItem *dentist;
@property (nonatomic, strong) SelectItem *principalDiagnosis;
@property (nonatomic, strong) NSMutableArray <SelectItem> *secondaryDiagnosis;

@property (nonatomic, strong) NSDate *createdDatePrescription;

@property (nonatomic, strong) NSMutableArray <Prescription> *prescriptions;
@end