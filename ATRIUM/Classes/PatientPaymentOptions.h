//
// Created by Sanch0 on 6/26/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PatientPaymentOptions : BaseObject

@property (nonatomic, strong) NSNumber *insuranceCompanyCount;
@property (nonatomic, strong) NSNumber *houseHoldPatientId;
@property (nonatomic, strong) NSNumber *needPreApproval;
@property (nonatomic, strong) NSNumber *treatmentId;

- (BOOL)hasPatientInsuranceAndNeedPreApproval;

@end