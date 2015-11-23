//
// Created by Sanch0 on 11/12/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSignatureForm.h"

@protocol PatientMedicalAlertItem;

@interface PatientMedicalAlerts : BaseSignatureForm

@property (nonatomic, strong) NSMutableArray<PatientMedicalAlertItem> *alerts;
@property (nonatomic, strong) NSMutableArray<Ignore> *signedAlerts;

@end