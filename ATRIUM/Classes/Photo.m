//
// Created by Sanch0 on 11/6/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "Photo.h"


@implementation Photo {

}

- (id)copyWithZone:(NSZone *)zone {
    Photo *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.key = self.key;
        copy.url = self.url;
    }

    return copy;
}

@end