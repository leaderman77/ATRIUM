//
// Created by Sanch0 on 11/17/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatientMedicationAlertItem.h"
#import "BaseSignatureForm.h"

@protocol PatientMedicationAlertItem;

@interface PatientMedicationAlerts : BaseSignatureForm

@property (nonatomic, strong) NSMutableArray<PatientMedicationAlertItem> *alerts;

@end