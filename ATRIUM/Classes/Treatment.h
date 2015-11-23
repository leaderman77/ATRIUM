//
// Created by Sanch0 on 2/4/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeethChartingEnums.h"

@class TreatmentItem;
@class DiagnosisItem;
@protocol TreatmentFollowUp;


@interface Treatment : SelectItem

@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) NSString *description2; //For arabic description
@property (nonatomic, strong) TreatmentItem *group;
@property (nonatomic, strong) SelectItem *area;
@property (nonatomic, strong) NSArray <SelectItem> *areaDetails;
@property (nonatomic, strong) DiagnosisItem *principalDiagnose;
@property (nonatomic, strong) DiagnosisItem *secondaryDiagnose;
@property (nonatomic, strong) NSArray <TreatmentFollowUp> *followUps;
@property (nonatomic, strong) NSNumber *bonus;

//for company
@property (nonatomic, strong) NSNumber *selected;
@property (nonatomic, strong) NSNumber *appointmentLength;
@property (nonatomic, strong) NSNumber *useHygienist;
@property (nonatomic, strong) NSNumber *notBillInsurance;
@property (nonatomic, strong) NSNumber *taxable;
@property (nonatomic, strong) NSNumber *system;
@property (nonatomic, strong) NSNumber *needPreApproval;

//before and after treatment document types
@property (nonatomic, strong) SelectItem *beforeClinicNote;
@property (nonatomic, strong) SelectItem *afterClinicNote;

@property (nonatomic, strong) SelectItem *beforeConsentForm;
@property (nonatomic, strong) SelectItem *afterConsentForm;

@property (nonatomic, strong) SelectItem *beforePostOperation;
@property (nonatomic, strong) SelectItem *afterPostOperation;

@property (nonatomic, strong) SelectItem *beforeLabOrder;
@property (nonatomic, strong) SelectItem *afterLabOrder;
@property (nonatomic, strong) NSNumber *hasMultiCodes;


@property (nonatomic, strong) NSNumber <Ignore> *checked;

- (NSString *)stringAreaWithDetails;

- (TreatmentAreaType)areaType;

- (SelectItem *)toSelectItem;
@end