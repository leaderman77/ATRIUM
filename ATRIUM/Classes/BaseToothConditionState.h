//
// Created by Sanch0 on 5/23/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseToothConditionState : BaseObject

@property (nonatomic, strong) SelectItem *toothPosition;
@property (nonatomic, strong) SelectItem *toothGeneration;
@property (nonatomic, strong) SelectItem *tooth;
@property (nonatomic, assign) BOOL supernumeraryTooth;

@property (nonatomic, strong) SelectItem *conditionType;

@property (nonatomic, strong) SelectItem *toothStatus;
@property (nonatomic, strong) SelectItem *calculusGrade;
@property (nonatomic, strong) SelectItem *mobilityGrade;
@property (nonatomic, strong) SelectItem *furcationGrade;
@property (nonatomic, strong) SelectItem *shiftX;
@property (nonatomic, strong) SelectItem *shiftY;
@property (nonatomic, strong) SelectItem *shiftZ;
@property (nonatomic, strong) SelectItem *turn;
@property (nonatomic, strong) SelectItem *toothAche;

//TODO hAcK with BOOL -> NSNumber. It's changed to use in toothImageView.
@property (nonatomic, strong) NSNumber *veneer;
@property (nonatomic, strong) NSNumber *extractionIndicationTooth;
@property (nonatomic, strong) NSNumber *metallicCrown;
@property (nonatomic, strong) NSNumber *metalCeramicCrown;
@property (nonatomic, strong) NSNumber *metalFreeCrown;
@property (nonatomic, strong) NSNumber *temporalCrown;
@property (nonatomic, strong) NSNumber *destroyedCrown;
@property (nonatomic, strong) NSNumber *fractureCrown;
@property (nonatomic, strong) NSNumber *fractureRoot;
@property (nonatomic, strong) NSNumber *residualRoot;
@property (nonatomic, strong) NSNumber *fractureCrownRoot;
@property (nonatomic, strong) NSNumber *banding;
@property (nonatomic, strong) NSNumber *fissureSealant;
@property (nonatomic, strong) NSNumber *occlusalReduction;

@property (nonatomic, strong) NSNumber *decay_Facial;
@property (nonatomic, strong) NSNumber *decay_Facial5;
@property (nonatomic, strong) NSNumber *decay_Mesial;
@property (nonatomic, strong) NSNumber *decay_Lingual;
@property (nonatomic, strong) NSNumber *decay_Lingual5;
@property (nonatomic, strong) NSNumber *decay_Distal;
@property (nonatomic, strong) NSNumber *decay_Oclusal;
@property (nonatomic, strong) NSNumber *decay_Incisal;
@property (nonatomic, strong) NSNumber *decay_Buccal;
@property (nonatomic, strong) NSNumber *decay_Buccal5;

@property (nonatomic, strong) NSNumber *amalgam_Facial;
@property (nonatomic, strong) NSNumber *amalgam_Facial5;
@property (nonatomic, strong) NSNumber *amalgam_Mesial;
@property (nonatomic, strong) NSNumber *amalgam_Lingual;
@property (nonatomic, strong) NSNumber *amalgam_Lingual5;
@property (nonatomic, strong) NSNumber *amalgam_Distal;
@property (nonatomic, strong) NSNumber *amalgam_Oclusal;
@property (nonatomic, strong) NSNumber *amalgam_Incisal;
@property (nonatomic, strong) NSNumber *amalgam_Buccal;
@property (nonatomic, strong) NSNumber *amalgam_Buccal5;


@property (nonatomic, strong) NSNumber *composite_Facial;
@property (nonatomic, strong) NSNumber *composite_Facial5;
@property (nonatomic, strong) NSNumber *composite_Mesial;
@property (nonatomic, strong) NSNumber *composite_Lingual;
@property (nonatomic, strong) NSNumber *composite_Lingual5;
@property (nonatomic, strong) NSNumber *composite_Distal;
@property (nonatomic, strong) NSNumber *composite_Oclusal;
@property (nonatomic, strong) NSNumber *composite_Incisal;

@property (nonatomic, strong) NSNumber *provisionalRestoration_Facial;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Facial5;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Mesial;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Lingual;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Lingual5;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Distal;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Oclusal;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Incisal;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Buccal;
@property (nonatomic, strong) NSNumber *provisionalRestoration_Buccal5;

@property (nonatomic, strong) NSNumber *metallicRestoration_Facial;
@property (nonatomic, strong) NSNumber *metallicRestoration_Facial5;
@property (nonatomic, strong) NSNumber *metallicRestoration_Mesial;
@property (nonatomic, strong) NSNumber *metallicRestoration_Lingual;
@property (nonatomic, strong) NSNumber *metallicRestoration_Lingual5;
@property (nonatomic, strong) NSNumber *metallicRestoration_Distal;
@property (nonatomic, strong) NSNumber *metallicRestoration_Oclusal;
@property (nonatomic, strong) NSNumber *metallicRestoration_Incisal;
@property (nonatomic, strong) NSNumber *metallicRestoration_Buccal;
@property (nonatomic, strong) NSNumber *metallicRestoration_Buccal5;

@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Facial;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Facial5;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Mesial;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Lingual;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Lingual5;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Distal;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Oclusal;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Incisal;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Buccal;
@property (nonatomic, strong) NSNumber *nonMetallicRestoration_Buccal5;


- (UIImage *)conditionImageWithName:(NSString *)imageName;

- (UIColor *)conditionColor;

//+ (UIColor *)colorByType:(ToothConditionEntityType)type;

@end