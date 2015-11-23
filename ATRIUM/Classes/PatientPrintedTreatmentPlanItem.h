//
// Created by Sanch0 on 5/5/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PatientPrintedTreatmentPlanItem : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *creator;
@property (nonatomic, strong) NSURL *pdfUrl;

@property (nonatomic, strong) NSDate <Ignore> *createdDateLocal;

@end