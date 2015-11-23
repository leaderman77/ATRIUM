//
// Created by Sanch0 on 8/18/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"


@interface AppointmentFilter : BaseObject

@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *endTime;
@property (nonatomic, strong) NSMutableArray *statusCodes;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *dentalPointId;
@property (nonatomic, strong) NSNumber *dentistId;
@property (nonatomic, strong) NSNumber *clinicId;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSString *phoneNumber;

@end