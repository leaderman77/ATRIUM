//
// Created by Sanch0 on 11/19/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "PatientForList.h"
#import "CompanyPatientPersonalDetails.h"
#import "PatientForAppointment.h"
#import "Photo.h"


@implementation PatientForList {

}

- (CompanyPatientPersonalDetails *)toCompanyPatient {
    CompanyPatientPersonalDetails *companyPatient = [[CompanyPatientPersonalDetails alloc] init];
    companyPatient.patientKey = self.patientKey;
    companyPatient.chartNumber = self.chartNumber;
    companyPatient.dateOfBirth = self.dateOfBirth;
    companyPatient.lastName = self.lastName;
    companyPatient.firstName = self.firstName;
    companyPatient.email = self.email;
    companyPatient.homePhoneNumber = self.homePhoneNumber;
    companyPatient.workPhoneNumber = self.workPhoneNumber;
    companyPatient.mobilePhoneNumber = self.mobilePhoneNumber;
    if (self.photoUrl) {
        companyPatient.photo = [[Photo alloc] init];
        companyPatient.photo.url = self.photoUrl;
    }

    return companyPatient;
}

- (PatientForAppointment *)toPatientForAppoinment {
    PatientForAppointment *patient = [[PatientForAppointment alloc] init];
    patient.patientKey = self.patientKey;
    patient.chartNumber = self.chartNumber;
    patient.dateOfBirth = self.dateOfBirth;
    patient.lastName = self.lastName;
    patient.firstName = self.firstName;
    patient.email = self.email;
    patient.mobilePhoneNumber = self.mobilePhoneNumber;

    return patient;
}

@end