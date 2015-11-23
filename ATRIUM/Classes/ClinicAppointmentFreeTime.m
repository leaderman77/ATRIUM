//
// Created by Sanch0 on 12/2/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "ClinicAppointmentFreeTime.h"


@implementation ClinicAppointmentFreeTime

- (NSDate <Ignore> *)startTimeDate {
    if (!_startTimeDate) {
        _startTimeDate = [NSDate dateFromServerDateLong:self.startTime];
    }
    return _startTimeDate;
}


- (NSDate <Ignore> *)endTimeDate {
    if (!_endTimeDate) {
        _endTimeDate = [NSDate dateFromServerDateLong:self.endTime];
    }
    return _endTimeDate;
}

@end