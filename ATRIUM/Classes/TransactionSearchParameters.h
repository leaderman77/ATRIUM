//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"


@interface TransactionSearchParameters : SearchParameters

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *appointmentId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;

- (instancetype)initWithPatientKey:(NSString *)patientKey withType:(NSString *)type;

- (instancetype)initWithPatientKey:(NSString *)patientKey withAppointmentId:(NSNumber *)appointmentId withType:(NSString *)type;

- (instancetype)initWithPatientKey:(NSString *)patientKey withAppointmentId:(NSNumber *)appointmentId withType:(NSString *)type withSortField:(NSString *)sortField;

- (instancetype)initWithPatientKey:(NSString *)patientKey withAppointmentId:(NSNumber *)appointmentId withType:(NSString *)type withStatus:(NSString *)status;
- (instancetype)initWithPatientKey:(NSString *)patientKey withType:(NSString *)type withStatus:(NSString *)status;

- (void)clear;
@end