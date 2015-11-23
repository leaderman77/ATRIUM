//
// Created by Sanch0 on 12/29/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClinicAppointmentForChangeStatus : BaseObject

@property (nonatomic, strong) SelectItem *status;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *callTime;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *deviceToken;

@end