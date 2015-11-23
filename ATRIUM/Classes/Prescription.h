//
// Created by Sanch0 on 3/11/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PrescriptionTemplateSubstitution;
@class Medication;

@protocol Prescription

@end

@interface Prescription : SelectItem

@property (nonatomic, strong) SelectItem *category;
@property (nonatomic, strong) SelectItem *medicationCategory; //DRUG CATEGORY

//DRUG
@property (nonatomic, strong) SelectItem *medication; //DRUG
@property (nonatomic, strong) NSNumber *strength;
@property (nonatomic, strong) SelectItem *strengthUnit;

@property (nonatomic, strong) NSNumber *amount;

@property (nonatomic, strong) SelectItem *amountUnit;
@property (nonatomic, strong) SelectItem *medicationUnit;

@property (nonatomic, strong) SelectItem *rout;
@property (nonatomic, strong) SelectItem *routFrequency;

@property (nonatomic, strong) NSNumber *dispense;
@property (nonatomic, strong) SelectItem *dispenseMedicationUnit;

@property (nonatomic, strong) NSNumber *refills;

/*
 * Patient instructions
 */

@property (nonatomic, strong) NSString *instructions;

@property (nonatomic, strong) NSNumber *expirationDate;

@property (nonatomic, assign) BOOL genericSubstitution;

@property (nonatomic, strong) NSMutableArray <PrescriptionTemplateSubstitution> *substitutions;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *owner;


@property (nonatomic, strong) Medication <Ignore> *medicationItem;
@property (nonatomic, strong) NSNumber <Ignore> *isOpened;
@property (nonatomic, strong) NSMutableArray <Ignore> *substitutionEditItems;

- (BOOL)isValid;

@end