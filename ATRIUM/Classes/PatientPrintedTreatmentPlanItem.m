//
// Created by Sanch0 on 5/5/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientPrintedTreatmentPlanItem.h"


@implementation PatientPrintedTreatmentPlanItem {

}
- (NSDate <Ignore> *)createdDateLocal {
    if (!_createdDateLocal) {
        _createdDateLocal = [NSDate dateFromServerDateLong:self.createdDate];
    }
    return _createdDateLocal;
}

@end