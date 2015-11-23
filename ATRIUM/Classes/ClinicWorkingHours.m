//
// Created by Sanch0 on 12/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "ClinicWorkingHours.h"


@implementation ClinicWorkingHours {

}

- (NSNumber <Ignore> *)startTimeMinutesRounded {
    if (!_startTimeMinutesRounded) {
        NSArray *hourMinutes = [self.startTime componentsSeparatedByString:@":"];
        if (hourMinutes.count >= 2) {
            _startTimeMinutesRounded = @([hourMinutes[0] integerValue] * 60 + [hourMinutes[1] integerValue] - [hourMinutes[1] integerValue] % 15);
        }
    }
    return _startTimeMinutesRounded;
}

- (NSNumber <Ignore> *)endTimeMinutesRounded {
    if (!_endTimeMinutesRounded) {
        NSArray *hourMinutes = [self.endTime componentsSeparatedByString:@":"];
        if (hourMinutes.count >= 2) {
            _endTimeMinutesRounded = @([hourMinutes[0] integerValue] * 60 + [hourMinutes[1] integerValue] + [hourMinutes[1] integerValue] % 15);
        }
    }
    return _endTimeMinutesRounded;
}


- (NSNumber <Ignore> *)startTimeMinutes {
    if (!_startTimeMinutes) {
        NSArray *hourMinutes = [self.startTime componentsSeparatedByString:@":"];
        if (hourMinutes.count >= 2) {
            _startTimeMinutes = @([hourMinutes[0] integerValue] * 60 + [hourMinutes[1] integerValue]);
        }
    }
    return _startTimeMinutes;
}

- (NSNumber <Ignore> *)endTimeMinutes {
    if (!_endTimeMinutes) {
        NSArray *hourMinutes = [self.endTime componentsSeparatedByString:@":"];
        if (hourMinutes.count >= 2) {
            _endTimeMinutes = @([hourMinutes[0] integerValue] * 60 + [hourMinutes[1] integerValue]);
        }
    }
    return _endTimeMinutes;

}

- (NSNumber <Ignore> *)startTimeForNewPatientMinutes {
    if (!_startTimeForNewPatientMinutes && self.startTimeForNewPatient) {
        NSArray *hourMinutes = [self.startTimeForNewPatient componentsSeparatedByString:@":"];
        if (hourMinutes.count >= 2) {
            _startTimeForNewPatientMinutes = @([hourMinutes[0] integerValue] * 60 + [hourMinutes[1] integerValue]);
        }
    }
    return _startTimeForNewPatientMinutes;
}

- (NSNumber <Ignore> *)endTimeForNewPatientMinutes {
    if (!_endTimeForNewPatientMinutes && self.endTimeForNewPatient) {
        NSArray *hourMinutes = [self.endTimeForNewPatient componentsSeparatedByString:@":"];
        if (hourMinutes.count >= 2) {
            _endTimeForNewPatientMinutes = @([hourMinutes[0] integerValue] * 60 + [hourMinutes[1] integerValue]);
        }
    }
    return _endTimeForNewPatientMinutes;
}

@end