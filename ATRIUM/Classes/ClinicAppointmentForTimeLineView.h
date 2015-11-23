//
// Created by Sanch0 on 12/23/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClinicAppointmentForTimeLineView : NSObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSMutableArray *appoinments;
@property (nonatomic, strong) NSNumber *duration;

@end