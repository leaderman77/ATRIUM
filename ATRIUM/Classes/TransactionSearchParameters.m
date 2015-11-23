//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "TransactionSearchParameters.h"


@implementation TransactionSearchParameters {

}

- (instancetype)initWithPatientKey:(NSString *)patientKey withType:(NSString *)type {
    self = [super init];
    if (self) {
        self.patientKey = patientKey;
        self.type = type;
//        self.status = PLANNED_TRANSACTION_STATUS_CODE;
    }
    return self;
}

- (instancetype)initWithPatientKey:(NSString *)patientKey withAppointmentId:(NSNumber *)appointmentId withType:(NSString *)type {
    self = [super init];
    if (self) {
        self.patientKey = patientKey;
        self.appointmentId = appointmentId;
        self.type = type;
//        self.status = PLANNED_TRANSACTION_STATUS_CODE;
        self.sortField = @"date_desc";
    }
    return self;
}

- (instancetype)initWithPatientKey:(NSString *)patientKey withAppointmentId:(NSNumber *)appointmentId withType:(NSString *)type withSortField:(NSString *)sortField {
    self = [super init];
    if (self) {
        self.patientKey = patientKey;
        self.appointmentId = appointmentId;
        self.type = type;
//        self.status = PLANNED_TRANSACTION_STATUS_CODE;
        self.sortField = sortField;
    }
    return self;
}


- (instancetype)initWithPatientKey:(NSString *)patientKey withType:(NSString *)type withStatus:(NSString *)status {
    self = [super init];
    if (self) {
        self.patientKey = patientKey;
        self.type = type;
        self.status = status;
    }
    return self;
}

- (instancetype)initWithPatientKey:(NSString *)patientKey withAppointmentId:(NSNumber *)appointmentId withType:(NSString *)type withStatus:(NSString *)status {
    self = [super init];
    if (self) {
        self.patientKey = patientKey;
        self.appointmentId = appointmentId;
        self.type = type;
        self.status = status;
        self.sortField = @"date_desc";
    }
    return self;
}

- (void)clear {
    self.start = @0;
    self.limit = @10;
    self.sortField = nil;

}


@end