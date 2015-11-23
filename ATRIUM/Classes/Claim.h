//
// Created by Sanch0 on 4/24/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MobileTreatment;

@interface Claim : BaseObject

@property (nonatomic, strong) NSNumber *orderedDate;
@property (nonatomic, strong) NSString *requestName;
@property (nonatomic, strong) NSString *patientInsuranceCardNumber;
@property (nonatomic, strong) NSString *authorizationId;
@property (nonatomic, strong) SelectItem *dentist;
@property (nonatomic, strong) NSMutableArray <MobileTreatment> *treatmentList;
@property (nonatomic, strong) NSMutableArray <SelectItem> *diagnosis;
@property (nonatomic, strong) NSNumber *appointmentId;
//@property (nonatomic, assign) NSInteger treatmentCodesCount;
//@property (nonatomic, strong) NSMutableArray <MobileTreatment> *uniqueTreatmentList;

- (SelectItem *)primaryDiagnosis;
@end