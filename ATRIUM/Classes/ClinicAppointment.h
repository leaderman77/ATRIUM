//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PatientForAppointment;
@class NoResponseModel;

@protocol ClinicAppointment

@end

@interface ClinicAppointment : BaseObject

@property (nonatomic, strong) PatientForAppointment *patient;

@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSNumber *duration;

@property (nonatomic, strong) SelectItem *category;
@property (nonatomic, strong) SelectItem *status;
@property (nonatomic, strong) SelectItem *dentist;
@property (nonatomic, strong) SelectItem *dentalPoint;
@property (nonatomic, strong) NSString *note;

@property (nonatomic, strong) NSNumber *lastCallAttemptTime;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *creator;
@property (nonatomic, strong) NSNumber *actualStartTime;
@property (nonatomic, strong) NSString *startedDeviceToken;

@property (nonatomic, strong) NSDate <Ignore> *startTimeDate;
@property (nonatomic, strong) NSDate <Ignore> *endTimeDate;
@property (nonatomic, strong) NSNumber <Ignore> *isNoResponse;
@property (nonatomic, strong) NSNumber <Ignore> *position;
@property (nonatomic, strong) NoResponseModel <Ignore> *noResponseModel;

@property (nonatomic, strong) NSString *comment;

- (NSString *)fullPatientName;

- (NSString *)fullPatientNameWithChartNumberForCalendar;

- (NSString *)fullPatientNameForCalendar;


@end