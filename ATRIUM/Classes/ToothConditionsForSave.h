//
// Created by Sanch0 on 6/6/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ToothConditionTemplate;

@protocol ToothConditionsForSave

@end

@interface ToothConditionsForSave : BaseObject

@property (nonatomic, strong) ToothConditionTemplate *toothConditionTemplate;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) SelectItem *tooth;
@property (nonatomic, strong) SelectItem *area;
@property (nonatomic, strong) NSNumber *dentistId;

@property (nonatomic, strong) NSMutableArray <SelectItem> *areaDetails;

@end