//
// Created by Sanch0 on 5/2/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PatientPrintedTreatmentsPlanForSave : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *appointmentId;
@property (nonatomic, strong) NSMutableArray *dentalTransactionKeys;

@end