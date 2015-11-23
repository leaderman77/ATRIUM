//
//  Procedures.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/5/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol FollowUp;

@interface Procedures : BaseObject

@property (nonatomic, strong) NSNumber* typeId;
@property (nonatomic, strong) SelectItem* specialty;
@property (nonatomic, strong) SelectItem* principalDiagnosis;
@property (nonatomic, strong) SelectItem* secondaryDiagnosis;
@property (nonatomic, strong) SelectItem* beforeClinicalNote;
@property (nonatomic, strong) SelectItem* afterClinicalNote;
@property (nonatomic, strong) SelectItem* beforeConsentForm;
@property (nonatomic, strong) SelectItem* afterConsentForm;
@property (nonatomic, strong) SelectItem* beforePostOperation;
@property (nonatomic, strong) SelectItem* afterPostOperation;
@property (nonatomic, strong) SelectItem* beforeLabOrder;
@property (nonatomic, strong) SelectItem* afterLabOrder;
@property (nonatomic, strong) NSArray<FollowUp>* followUps;
@property (nonatomic, strong) NSArray<SelectItem>* treatments;
@property (nonatomic, assign) BOOL system;

@end
