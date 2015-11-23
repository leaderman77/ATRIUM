//
// Created by Sanch0 on 12/2/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointmentSearchParameters : BaseObject

@property (nonatomic, strong) NSNumber *periodStart;
@property (nonatomic, strong) NSNumber *periodEnd;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSNumber *dentistId;
@property (nonatomic, strong) NSNumber *dentalPointId;

@property (nonatomic, strong) NSString *weekDays;  //Mon, Tues, ... need to check the source
@property (nonatomic, strong) NSString *timeStart; //HH:mm
@property (nonatomic, strong) NSString *timeEnd;

@property (nonatomic, strong) NSNumber *appointmentId;


@property (nonatomic, copy) NSString *patientKey;
@end