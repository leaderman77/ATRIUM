//
// Created by Sanch0 on 12/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClinicWorkingHours : BaseObject

@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *startTimeForNewPatient;
@property (nonatomic, strong) NSString *endTimeForNewPatient;
@property (nonatomic, strong) SelectItem *weekDays;
@property (nonatomic, assign) BOOL active;

@property (nonatomic, strong) NSNumber <Ignore> *startTimeMinutes;
@property (nonatomic, strong) NSNumber <Ignore> *endTimeMinutes;

@property (nonatomic, strong) NSNumber <Ignore> *startTimeMinutesRounded;
@property (nonatomic, strong) NSNumber <Ignore> *endTimeMinutesRounded;

@property (nonatomic, strong) NSNumber <Ignore> *startTimeForNewPatientMinutes;
@property (nonatomic, strong) NSNumber <Ignore> *endTimeForNewPatientMinutes;

@end