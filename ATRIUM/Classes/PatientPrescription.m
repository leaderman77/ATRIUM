//
// Created by Sanch0 on 3/11/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientPrescription.h"


@implementation PatientPrescription {

}

- (NSDate *)createdDatePrescription {
    if (!_createdDatePrescription) {
        _createdDatePrescription = [NSDate dateFromServerDateLong:self.createdDate];
    }
    return _createdDatePrescription;
}

@end