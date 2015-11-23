//
// Created by Sanch0 on 12/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "CallListColumn.h"
#import "ClinicAppointment.h"


@implementation CallListColumn {

}

@synthesize clinicAppointmentsByIds = _clinicAppointmentsByIds;

- (NSDictionary *)clinicAppointmentsByIds {
    if (!_clinicAppointmentsByIds) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [self.list enumerateObjectsUsingBlock:^(ClinicAppointment *obj, NSUInteger idx, BOOL *stop) {
            if (obj.objectId) {
                dic[obj.objectId] = obj;
            }
            obj.position = @(idx);
        }];
        _clinicAppointmentsByIds = dic;
    }
    return _clinicAppointmentsByIds;
}

- (void)reCalculateListPositions {
    [self.list enumerateObjectsUsingBlock:^(ClinicAppointment *obj, NSUInteger idx, BOOL *stop) {
        obj.position = @(idx);
    }];
}

- (NSDate *)dateLocal {
    if (!_dateLocal) {
//        _dateLocal = [NSDate dateFromServerDateLong:self.date];
    }
    return _dateLocal;
}

@end