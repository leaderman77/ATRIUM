//
// Created by Sanch0 on 4/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ToothDetailsType;


@interface ToothConditionTemplate : SelectItem

@property (nonatomic, strong) SelectItem *conditionType;
@property (nonatomic, strong) SelectItem *toothStatus;
@property (nonatomic, strong) SelectItem *calculusGrade;
@property (nonatomic, strong) SelectItem *mobilityGrade;
@property (nonatomic, strong) SelectItem *furcationGrade;
@property (nonatomic, strong) SelectItem *fracture;
@property (nonatomic, strong) SelectItem *shiftX;
@property (nonatomic, strong) SelectItem *shiftY;
@property (nonatomic, strong) SelectItem *shiftZ;
@property (nonatomic, strong) SelectItem *turn;
@property (nonatomic, strong) SelectItem *toothAche;
@property (nonatomic, strong) NSNumber *fractureCrown;
@property (nonatomic, strong) NSNumber *fractureRoot;
@property (nonatomic, strong) NSNumber *decay;
@property (nonatomic, strong) NSNumber *veneer;
@property (nonatomic, strong) NSNumber *extractionIndicationTooth;
@property (nonatomic, strong) NSNumber *metallicCrown;
@property (nonatomic, strong) NSNumber *metalCeramicCrown;
@property (nonatomic, strong) NSNumber *metalFreeCrown;
@property (nonatomic, strong) NSNumber *temporalCrown;
@property (nonatomic, strong) NSNumber *destroyedCrown;
@property (nonatomic, strong) NSNumber *residualRoot;
@property (nonatomic, strong) NSNumber *amalgam;
@property (nonatomic, strong) NSNumber *composite;
@property (nonatomic, strong) NSNumber *provisionalRestoration;
@property (nonatomic, strong) NSNumber *metallicRestoration;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration;

@property (nonatomic, assign) BOOL supernumeraryTooth;
@property (nonatomic, strong) SelectItem *generation;
//@property (nonatomic, strong) NSNumber *pulpits;

+ (ToothConditionTemplate *)toothConditionWithIntactValues:(ToothDetailsType *)tooth;

@end