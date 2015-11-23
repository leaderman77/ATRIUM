//
// Created by Sanch0 on 11/5/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "Country.h"


@implementation Country

- (NSString *)autocompleteString {
    return self.name;
}

- (id)copyWithZone:(NSZone *)zone {
    Country *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.hasStates = self.hasStates;
        copy.phoneCode = self.phoneCode;
    }

    return copy;
}

@end