//
// Created by Sanch0 on 11/5/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "Address.h"
#import "Country.h"


@implementation Address {

}

- (id)copyWithZone:(NSZone *)zone {
    Address *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.postcode = self.postcode;
        copy.country = [self.country copy];
        copy.state = [self.state copy];
        copy.town = [self.town copy];
        copy.line1 = [self.line1 copy];
        copy.line2 = [self.line2 copy];
    }

    return copy;
}

@end