//
//  MemberWorkingHoursCollection.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "MemberWorkingHoursCollection.h"
#import "MemberWorkingHours.h"
@implementation MemberWorkingHoursCollection

- (NSArray<Ignore> *)activeWorkingDays {
    if(!_activeWorkingDays) {
        NSMutableArray *activDays = [NSMutableArray arrayWithCapacity:0];
        if(self.day1.active) {
            [activDays addObject:self.day1];
        }
        if(self.day2.active) {
            [activDays addObject:self.day2];
        }
        if(self.day3.active) {
            [activDays addObject:self.day3];
        }
        if(self.day4.active) {
            [activDays addObject:self.day4];
        }
        if(self.day5.active) {
            [activDays addObject:self.day5];
        }
        if(self.day6.active) {
            [activDays addObject:self.day6];
        }
        if(self.day7.active) {
            [activDays addObject:self.day7];
        }
        _activeWorkingDays = activDays;
    }
    return _activeWorkingDays;
}

@end
