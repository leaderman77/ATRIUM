//
// Created by Sanch0 on 1/27/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DiagnosisItem.h"


@implementation DiagnosisItem {

}

- (id)copyWithZone:(NSZone *)zone {
    DiagnosisItem *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.code = self.code;
        copy.descrip = self.descrip;
        copy.sortNo = self.sortNo;
    }

    return copy;
}

- (SelectItem *)toSelectItem {
    self.sortNo = nil;
    return self;
}


@end