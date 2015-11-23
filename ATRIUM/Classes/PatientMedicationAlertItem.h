//
// Created by Sanch0 on 11/17/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientMedicationAlertItem

@end


@interface PatientMedicationAlertItem : BaseObject

@property (nonatomic, strong) NSString *medicationName;
@property (nonatomic, strong) NSNumber *dosage;
@property (nonatomic, strong) SelectItem *unit;
@property (nonatomic, strong) NSString *purpose;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSNumber *modifiedDate;

@end