//
// Created by Sanch0 on 11/7/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "PatientPersonalDetails.h"
#import "Address.h"
#import "Photo.h"
#import "PatientHouseHold.h"

@implementation PatientPersonalDetails {

}

- (id)copyWithZone:(NSZone *)zone {
    PatientPersonalDetails *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.lastName = self.lastName;
        copy.firstName = self.firstName;
        copy.middleName = self.middleName;
        copy.maritalStatus = [self.maritalStatus copy];
        copy.dateOfBirth = self.dateOfBirth;
        copy.gender = [self.gender copy];
        copy.email = self.email;
        copy.homePhoneNumber = self.homePhoneNumber;
        copy.workPhoneNumber = self.workPhoneNumber;
        copy.mobilePhoneNumber = self.mobilePhoneNumber;
        copy.student = self.student;
        copy.address = [self.address copy];
        copy.photo = [self.photo copy];

        copy.documentSocialSecurityNumber = self.documentSocialSecurityNumber;
        copy.documentDriverLicenseNumber = self.documentDriverLicenseNumber;
        copy.documentSocialInsuranceNumber = self.documentSocialInsuranceNumber;
        copy.documentPasswordNumber = self.documentPasswordNumber;
        copy.documentNationalIdNumber = self.documentNationalIdNumber;
        copy.patientHouseHold = self.patientHouseHold;
        copy.chartNumber = self.chartNumber;
        copy.patientKey = self.patientKey;
        copy.signature = self.signature;
    }

    return copy;
}

- (Address *)address {
    if (_address == nil) {
        _address = [Address new];
    }
    return _address;
}

- (SelectItem *)maritalStatus {
    if (_maritalStatus == nil) {
        _maritalStatus = [[SelectItem alloc] init];
    }
    return _maritalStatus;
}

- (NSString <Ignore> *)fullName {
    NSMutableString *fullName = [[NSMutableString alloc] initWithString:self.firstName ? self.firstName : @""];
    if (self.lastName) {
        if (fullName.length > 0) {
            [fullName appendString:@" "];
        }
        [fullName appendString:self.lastName];
    }
    return fullName;
}


@end