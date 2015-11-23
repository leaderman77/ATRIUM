//
// Created by Sanch0 on 12/23/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "ClinicAppointmentForTimeLineView.h"


@implementation ClinicAppointmentForTimeLineView {

}

- (NSMutableArray *)appoinments {
    if (!_appoinments) {
        _appoinments = [[NSMutableArray alloc] init];
    }
    return _appoinments;
}

@end