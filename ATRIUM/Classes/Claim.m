//
// Created by Sanch0 on 4/24/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "Claim.h"


@implementation Claim {

}

- (NSMutableArray <SelectItem> *)diagnosis {
    if (!_diagnosis) {
        _diagnosis = (NSMutableArray <SelectItem> *) [[NSMutableArray alloc] init];
    }
    return _diagnosis;
}

- (id)copyWithZone:(NSZone *)zone {
    Claim *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.orderedDate = self.orderedDate;
        copy.requestName = self.requestName;
        copy.patientInsuranceCardNumber = self.patientInsuranceCardNumber;
        copy.authorizationId = self.authorizationId;
        copy.dentist = [self.dentist copy];
        copy.treatmentList = [self.treatmentList mutableCopy];
        copy.diagnosis = [self.diagnosis mutableCopy];
    }

    return copy;
}


- (SelectItem *)primaryDiagnosis {
    __block SelectItem *primaryDiagnosis = nil;
    [self.diagnosis enumerateObjectsUsingBlock:^(SelectItem *selectItem, NSUInteger idx, BOOL *stop) {
        if (selectItem.selected.boolValue) {
            primaryDiagnosis = selectItem;
            *stop = YES;
        }
    }];
    return primaryDiagnosis;
}

@end