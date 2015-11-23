//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatientInsuranceInfoView.h"

@class Photo;

@protocol CompanyPatientInsurance

@end


@interface CompanyPatientInsurance : BaseObject

//@property (nonatomic, strong) SelectItem *patient;
@property (nonatomic, strong) SelectItem *relation;
//@property (nonatomic, strong) SelectItem *relationParent;
//@property (nonatomic, strong) SelectItem *relationInsurance;
@property (nonatomic, strong) SelectItem *insuranceCompany;
@property (nonatomic, strong) SelectItem *insurancePlan;
@property (nonatomic, strong) SelectItem *type;//--depend relation
@property (nonatomic, strong) SelectItem *broker;//--depend insurance company
@property (nonatomic, strong) NSNumber *expireDate;//--
@property (nonatomic, strong) NSMutableArray <SelectItem> *mandatoryFields;

@property (nonatomic, strong) NSString *cardNumber;//--depend relation       +
@property (nonatomic, strong) NSString *division;  //--depend relation         -
@property (nonatomic, strong) NSString *dependentCode;//--depend relation    -
@property (nonatomic, strong) NSString *groupNumber;  //--depend relation      -
@property (nonatomic, strong) NSNumber *maxUsageAmount;//--depend relation   +
@property (nonatomic, strong) NSString *cardSequence;  //--depend relation     -
@property (nonatomic, strong) NSString *subscriberId;//--depend relation     +
@property (nonatomic, strong) NSString *subscriberName;//--depend relation
@property (nonatomic, strong) NSString *patientKey;//--depend relation
@property (nonatomic, strong) NSString *insurancePlanNotes;
@property (nonatomic, strong) Photo *documentScreen;
@property (nonatomic, strong) Photo *documentScreen1;
@property (nonatomic, strong) Photo *documentScreen2;

- (void)copyValues:(CompanyPatientInsurance *)insurance;

- (void)copyValues:(CompanyPatientInsurance *)insurance withType:(BOOL)flag;


@end