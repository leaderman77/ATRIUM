//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatientPersonalDetails.h"

@class PatientForAppointment;


@interface CompanyPatientPersonalDetails : PatientPersonalDetails

@property (nonatomic, strong) NSNumber *registerPersonalDetail;
@property (nonatomic, strong) NSNumber *registerMedicalAlerts;
@property (nonatomic, strong) NSNumber *registerMedicationAlerts;


- (id)initWithPatientForAppointment:(PatientForAppointment *)patientForAppointment;

- (PatientForAppointment *)toPatientForAppointment;

@end