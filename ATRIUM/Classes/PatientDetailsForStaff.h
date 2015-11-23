//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CompanyPatientPersonalDetails;
@class PatientMedicalAlerts;
@class PatientMedicationAlerts;
@class NoteList;
@class ClinicAppoinmentList;
@class CompanyPatientInsuranceList;
@class BaseNeedSignFormList;
@class ClinicAppointment;
@class PatientAccessModules;

@interface PatientDetailsForStaff : BaseObject

@property (nonatomic, strong) CompanyPatientPersonalDetails *patientDetails;
@property (nonatomic, strong) PatientMedicalAlerts *medicalAlerts;
@property (nonatomic, strong) PatientMedicationAlerts *medicationAlerts;
@property (nonatomic, strong) NoteList *patientNotes;
@property (nonatomic, strong) ClinicAppoinmentList *appointments;
@property (nonatomic, strong) CompanyPatientInsuranceList *insurances;
@property (nonatomic, strong) BaseNeedSignFormList *signatueForms;
@property (nonatomic, strong) ClinicAppointment *currentAppointment;
@property (nonatomic, strong) ClinicAppointment *checkedInAppointment;
@property (nonatomic, strong) PatientAccessModules *patientAccessModules;
@property (nonatomic, strong) NSNumber *currentTime;

@end