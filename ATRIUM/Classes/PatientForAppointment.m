//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "PatientForAppointment.h"
#import "Photo.h"


@implementation PatientForAppointment {

    
    
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

- (NSString <Ignore> *)fullNameForSearch {
    if (_fullNameForSearch == nil) {
        NSMutableString *fullName = [[NSMutableString alloc] initWithString:self.firstName ? self.firstName : @""];
        if (self.lastName) {
            if (fullName.length > 0) {
                [fullName appendString:@" "];
            }
            [fullName appendString:self.lastName];
        }
        if (self.middleName) {
            if (fullName.length > 0) {
                [fullName appendString:@" "];
            }
            [fullName appendString:self.fullName];
        }
        _fullNameForSearch = fullName;
    }

    return _fullNameForSearch;
}


- (id)copyWithZone:(NSZone *)zone {
    PatientForAppointment *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.chartNumber = self.chartNumber;
        copy.patientKey = self.patientKey;
        copy.firstName = self.firstName;
        copy.lastName = self.lastName;
        copy.middleName = self.middleName;
        copy.email = self.email;
        copy.dateOfBirth = self.dateOfBirth;
        copy.gender = [self.gender copy];
        copy.mobilePhoneNumber = self.mobilePhoneNumber;
        copy.homePhoneNumber = self.homePhoneNumber;
        copy.photo = [self.photo copy];
    }

    return copy;
}




@end