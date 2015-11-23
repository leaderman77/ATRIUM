//
//  PatientHouseHold.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/25/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientHouseHold.h"
#import "PatientForList.h"

@implementation PatientHouseHold

- (id)initWithPatientForList:(PatientForList *)patient {
    self = [super init];
    if(self) {
        self.patientKey = patient.patientKey;
        self.chartNumber = patient.chartNumber;
        self.firstName = patient.firstName;
        self.lastName = patient.lastName;
        self.dateOfBirth = patient.dateOfBirth;
        self.mobilePhoneNumber = patient.mobilePhoneNumber;
    }
    return self;
}

@end
