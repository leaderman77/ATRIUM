//
// Created by Sanch0 on 12/2/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ClinicAppointmentFreeTime

@end

@interface ClinicAppointmentFreeTime : BaseObject

@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *endTime;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) SelectItem *dentalPoint;


@property (nonatomic, strong) NSDate <Ignore> *startTimeDate;
@property (nonatomic, strong) NSDate <Ignore> *endTimeDate;

//NEED TO ADD TO CLASS SERVER
@property (nonatomic, strong) SelectItem <Ignore> *dentist;

@end