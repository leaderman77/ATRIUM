//
// Created by Sanch0 on 10/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "PatientForLogin.h"


@implementation PatientForLogin


- (NSDate *)birthDate {
    if (_dateOfBirth && ![_dateOfBirth isEqual:[NSNull null]]) {
        _birthDate = [NSDate dateFromServerDateLong:self.dateOfBirth];
    }
    return _birthDate;
}

@end