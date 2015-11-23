//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "CompanyPatientInsurance.h"
#import "Photo.h"


@implementation CompanyPatientInsurance {

}

- (void)copyValues:(CompanyPatientInsurance *)insurance {
    [self copyValues:insurance withType:YES];
}

- (void)copyValues:(CompanyPatientInsurance *)insurance withType:(BOOL)flag {
    self.objectId = insurance.objectId;
    self.name = insurance.name;
    self.cardNumber = insurance.cardNumber;
    self.relation = insurance.relation;
    self.insuranceCompany = insurance.insuranceCompany;
    self.insurancePlan = insurance.insurancePlan;
    self.division = insurance.division;
    self.dependentCode = insurance.dependentCode;
    self.broker = insurance.broker;
    self.groupNumber = insurance.groupNumber;
    self.maxUsageAmount = insurance.maxUsageAmount;
    self.cardSequence = insurance.cardSequence;
    self.subscriberId = insurance.subscriberId;
    self.subscriberName = insurance.subscriberName;
    self.patientKey = insurance.patientKey;
    self.documentScreen = [insurance.documentScreen copy];

    if (flag) {
        self.type = insurance.type;
    }
}

@end