//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "ClinicAppointment.h"
#import "PatientForAppointment.h"


@implementation ClinicAppointment {

}

- (NSString *)fullPatientName {
    if (self.patient) {
        NSMutableString *fullName = [[NSMutableString alloc] initWithString:self.patient.firstName ? self.patient.firstName : @""];
        if (self.patient.lastName) {
            if (fullName.length > 0) {
                [fullName appendString:@" "];
            }
            [fullName appendString:self.patient.lastName];
        }
        return fullName;
    }
    return @"";
}

- (NSString *)fullPatientNameWithChartNumberForCalendar {
    NSMutableString *fullNameWithChartNumber = [[NSMutableString alloc] init];
    if (self.patient) {
        NSArray *firstNames = [self.patient.firstName.trim componentsSeparatedByString:@" "];
        [fullNameWithChartNumber appendString:firstNames.count > 0 ? [firstNames firstObject] : @""];
        if (self.patient.lastName.trim.length > 0) {
            if (fullNameWithChartNumber.length > 0) {
                [fullNameWithChartNumber appendString:@" "];
            }
            NSArray *lastNames = [self.patient.lastName.trim componentsSeparatedByString:@" "];
            [fullNameWithChartNumber appendString:lastNames.count > 0 ? [lastNames firstObject] : @""];
        }
        if (self.patient.chartNumber.trim.length > 0) {
            if (fullNameWithChartNumber.length > 0) {
                [fullNameWithChartNumber appendString:@" "];
            }
            [fullNameWithChartNumber appendString:self.patient.chartNumber.trim];
        }
    }
    return fullNameWithChartNumber;
}


- (NSString *)fullPatientNameForCalendar {
    NSMutableString *fullName = [[NSMutableString alloc] init];
    if (self.patient) {
        NSArray *firstNames = [self.patient.firstName.trim componentsSeparatedByString:@" "];
        [fullName appendString:firstNames.count > 0 ? [firstNames firstObject] : @""];
        if (self.patient.lastName.trim.length > 0) {
            if (fullName.length > 0) {
                [fullName appendString:@" "];
            }
            NSArray *lastNames = [self.patient.lastName.trim componentsSeparatedByString:@" "];
            [fullName appendString:lastNames.count > 0 ? [lastNames firstObject] : @""];
        }
    }
    return fullName;
}


- (NSDate <Ignore> *)startTimeDate {
    if (!_startTimeDate) {
        _startTimeDate = [NSDate dateFromServerDateLong:self.startTime];
    }
    return _startTimeDate;
}

- (NSDate <Ignore> *)endTimeDate {
    if (!_endTimeDate) {
        _endTimeDate = [self.startTimeDate dateByAddingTimeInterval:self.duration.doubleValue / 1000];
    }
    return _endTimeDate;
}

- (void)setDuration:(NSNumber *)duration {
    _duration = duration;
    _endTimeDate = nil;
}


- (id)copyWithZone:(NSZone *)zone {
    ClinicAppointment *copy = [[[self class] allocWithZone:zone] init];
    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.startTime = self.startTime;
        copy.date = self.date;
        copy.duration = self.duration;
        copy.category = self.category;
        copy.status = self.status;
        copy.dentist = self.dentist;
        copy.dentalPoint = self.dentalPoint;
        copy.note = self.note;

        copy.patient = [self.patient copy];
    }

    return copy;
}


@end