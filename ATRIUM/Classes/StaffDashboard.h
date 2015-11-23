//
// Created by Sanch0 on 11/4/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StaffDashboard : BaseObject

@property (nonatomic, strong) NSNumber *patientAllCount;
@property (nonatomic, strong) NSNumber *patientNewForTodayCount;

@property (nonatomic, strong) NSNumber *appointmentForTodayCount;
@property (nonatomic, strong) NSNumber *appointmentInWaitingCount;

@end