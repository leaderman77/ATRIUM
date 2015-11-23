//
// Created by Sanch0 on 12/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallListColumn.h"

@class ClinicWorkingHours;

@interface AppointmentCalendar : BaseObject

@property (nonatomic, strong) NSArray <CallListColumn> *points;
@property (nonatomic, strong) ClinicWorkingHours *workTime;
@property (nonatomic, strong) NSNumber *serverTime;

@end