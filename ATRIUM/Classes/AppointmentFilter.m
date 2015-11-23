//
// Created by Sanch0 on 8/18/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "AppointmentFilter.h"


@implementation AppointmentFilter {

}

- (NSMutableArray *)statusCodes {
    if (!_statusCodes) {
        _statusCodes = [NSMutableArray new];
    }
    return _statusCodes;
}

@end