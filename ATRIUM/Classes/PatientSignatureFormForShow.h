//
// Created by Sanch0 on 11/5/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PatientPersonalDetails;
@class PatientMedicalAlerts;
@class PatientMedicationAlerts;

@interface PatientSignatureFormForShow : BaseObject

@property (nonatomic, strong) SelectItem *type;
@property (nonatomic, strong) NSString *footer;
@property (nonatomic, strong) NSString *header;

@property (nonatomic, strong) NSMutableArray <SelectItem> *mandatoryFields;
@property (nonatomic, strong) NSMutableArray <SelectItem> *units;
@property (nonatomic, strong) NSMutableArray <SelectItem> *alerts;
@property (nonatomic, strong) PatientPersonalDetails *patient;
@property (nonatomic, strong) NSString *chartNumber;

@property (nonatomic, strong) PatientMedicalAlerts *medicalAlerts;
@property (nonatomic, strong) PatientMedicationAlerts *medicationAlerts;


@end