//
// Created by Sanch0 on 4/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ToothConditionTemplate.h"
#import "ToothConditionsEnums.h"
#import "ToothDetailsType.h"


@implementation ToothConditionTemplate {

}

/*
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

* */

+ (ToothConditionTemplate *)toothConditionWithIntactValues:(ToothDetailsType *)tooth {
    ToothConditionTemplate *template = [[ToothConditionTemplate alloc] init];
    template.conditionType = [SelectItem selectItemWithCode:TOOTH_CONDITION_TYPE_RESULT];
    template.toothStatus = [SelectItem selectItemWithCode:TOOTHSTATUS_NORMAL];
    template.calculusGrade = [SelectItem selectItemWithCode:TOOTHGRADE_NONE];
    template.mobilityGrade = [SelectItem selectItemWithCode:TOOTHGRADE_NONE];
    template.furcationGrade = [SelectItem selectItemWithCode:TOOTHGRADE_NONE];
    template.shiftX = [SelectItem selectItemWithCode:TOOTHSHIFT_NONE];
    template.shiftY = [SelectItem selectItemWithCode:TOOTHSHIFT_NONE];
    template.shiftZ = [SelectItem selectItemWithCode:TOOTHSHIFT_NONE];
    template.turn = [SelectItem selectItemWithCode:TOOTHTURN_NONE];
    template.toothAche = [SelectItem selectItemWithCode:TOOTH_ACHE_NONE];
    template.decay = @NO;
    template.veneer = @NO;
    template.extractionIndicationTooth = @NO;
    template.metallicCrown = @NO;
    template.metalCeramicCrown = @NO;
    template.metalFreeCrown = @NO;
    template.temporalCrown = @NO;
    template.destroyedCrown = @NO;
    template.residualRoot = @NO;
    template.amalgam = @NO;
    template.composite = @NO;
    template.provisionalRestoration = @NO;
    template.metallicRestoration = @NO;
    template.nonMetallicRestoration = @NO;
    template.fractureCrown = @NO;
    template.fractureRoot = @NO;
//    template.pulpits = @NO;

    template.supernumeraryTooth = [tooth.generation.code isEqualToString:SUPERNUMERARY_TOOTH_CODE];
    template.generation = tooth.generation;

    return template;
}

@end