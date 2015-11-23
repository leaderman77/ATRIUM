//
// Created by Sanch0 on 10/17/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "NewsItem.h"


@implementation NewsItem


- (NSDate *)date {
    if (_date == nil || [_shortDescription isEqual:[NSNull null]]) {
        _date = [NSDate dateFromServerDateLong:self.createdDate];
    }
    return _date;
}

- (NSString <Ignore> *)shortDescription {
    if (_shortDescription == nil || [_shortDescription isEqual:[NSNull null]]) {

    }
    return _shortDescription;
}

@end