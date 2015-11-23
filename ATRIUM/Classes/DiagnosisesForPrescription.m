//
// Created by Sanch0 on 3/23/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DiagnosisesForPrescription.h"
#import "DiagnosisCode.h"


@implementation DiagnosisesForPrescription {

}

- (NSMutableSet *)selectedSecondaryDiagnosisCodes {
    if (!_selectedSecondaryDiagnosisCodes) {
        _selectedSecondaryDiagnosisCodes = [[NSMutableSet alloc] init];
    }
    return _selectedSecondaryDiagnosisCodes;
}


- (BOOL)secondaryDiagnosisesContains:(DiagnosisCode *)diagnosisCode {
    return diagnosisCode.objectId && [self.selectedSecondaryDiagnosisCodes containsObject:diagnosisCode.objectId];
}

- (void)addSecondaryDiagnosisCode:(DiagnosisCode *)diagnosisCode {
    [_selectedSecondaryDiagnosisCodes addObject:diagnosisCode.objectId];
}

- (void)removeSecondaryDiagnosisCode:(DiagnosisCode *)diagnosisCode {
    [_selectedSecondaryDiagnosisCodes removeObject:diagnosisCode.objectId];
}

@end