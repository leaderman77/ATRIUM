//
// Created by Sanch0 on 11/19/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "SearchParameters.h"


@implementation SearchParameters

- (id)init {
    return [self initWithStart:@0];
}

- (id)initWithStart:(NSNumber *)start {
    return [self initWithStart:start withLimit:LIMIT withSortField:nil];
}

- (id)initWithStart:(NSNumber *)start withLimit:(NSNumber *)limit {
    return [self initWithStart:start withLimit:limit withSortField:nil];
}

- (id)initWithStart:(NSNumber *)start withLimit:(NSNumber *)limit withSortField:(NSString *)sortField {
    self = [super init];

    if (self) {
        self.start = start;
        self.limit = limit;
        self.sortField = sortField;
    }

    return self;
}

@end