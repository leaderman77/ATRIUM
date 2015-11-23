//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "CompanyPatientPersonalDetails.h"
#import "PatientForAppointment.h"


@implementation CompanyPatientPersonalDetails

- (id)initWithPatientForAppointment:(PatientForAppointment *)patientForAppointment {
    self = [super init];
    if (self && patientForAppointment) {
        self.name = patientForAppointment.fullName;
        self.patientKey = patientForAppointment.patientKey;
        self.chartNumber = patientForAppointment.chartNumber;
        self.mobilePhoneNumber = patientForAppointment.mobilePhoneNumber;
        self.email = patientForAppointment.email;
        self.firstName = patientForAppointment.firstName;
        self.lastName = patientForAppointment.lastName;
        self.gender = patientForAppointment.gender;
        self.dateOfBirth = patientForAppointment.dateOfBirth;
        self.middleName = patientForAppointment.middleName;
        self.photo = patientForAppointment.photo;
    }
    return self;
}


- (PatientForAppointment *)toPatientForAppointment {
    PatientForAppointment *patientForAppointment = [[PatientForAppointment alloc] init];
    patientForAppointment.patientKey = self.patientKey;
    patientForAppointment.chartNumber = self.chartNumber;
    patientForAppointment.mobilePhoneNumber = self.mobilePhoneNumber;
    patientForAppointment.email = self.email;
    patientForAppointment.firstName = self.firstName;
    patientForAppointment.lastName = self.lastName;
    patientForAppointment.gender = self.gender;
    patientForAppointment.dateOfBirth = self.dateOfBirth;
    patientForAppointment.middleName = self.middleName;
    patientForAppointment.photo = self.photo;

    return patientForAppointment;
}


@end