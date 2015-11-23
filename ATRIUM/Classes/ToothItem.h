//
//  ToothItem.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/11/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"


@class ToothDetailsType;
@class PerioExam;
@class PatientToothConditions;
@class PatientToothConditionWithChanges;

@interface ToothItem : BaseObject

@property (nonatomic, strong) ToothDetailsType *toothDetailsType;
@property (nonatomic, strong) PerioExam *perioExam;
@property (nonatomic, strong) PatientToothConditions *toothConditions;
@property (nonatomic, strong) PatientToothConditionWithChanges *toothConditionWithChanges;

//////ORANGE LINE
//@property (nonatomic, assign) NSInteger gingivalMarginLeft;         //Distal
//@property (nonatomic, assign) NSInteger gingivalMarginCentral;      //Central
//@property (nonatomic, assign) NSInteger gingivalMarginRight;        //Mesial
//
////RED LINE
//@property (nonatomic, assign) NSInteger probingDepthLeft;         //Distal
//@property (nonatomic, assign) NSInteger probingDepthCentral;      //Central
//@property (nonatomic, assign) NSInteger probingDepthRight;        //Mesial
//
////GREEN (SUMMARIZE) LINE
//@property (nonatomic, assign) NSInteger clinicalAttachmentLevelLeft;         //Distal
//@property (nonatomic, assign) NSInteger clinicalAttachmentLevelCentral;      //Central
//@property (nonatomic, assign) NSInteger clinicalAttachmentLevelRight;        //Mesial
//
//@property (nonatomic, strong) NSNumber *fucationNumber;
//
////
//@property (nonatomic, assign) DropState leftDropState;
//@property (nonatomic, assign) DropState centerDropState;
//@property (nonatomic, assign) DropState righttDropState;



@end
