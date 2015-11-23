//
// Created by Sanch0 on 6/26/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientPaymentOptions.h"


@implementation PatientPaymentOptions {

}

- (BOOL)hasPatientInsuranceAndNeedPreApproval {
    return self.insuranceCompanyCount.integerValue > 0 && self.needPreApproval.boolValue;
}

@end