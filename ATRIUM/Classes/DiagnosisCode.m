//
// Created by Sanch0 on 1/27/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DiagnosisCode.h"


@implementation DiagnosisCode {

}

- (SelectItem *)toSelectItem {
    SelectItem *selectItem = [[SelectItem alloc] init];
    selectItem.objectId = self.objectId;
    selectItem.name = self.name;
    selectItem.code = self.code;
    selectItem.descrip = self.descrip;
    return selectItem;
}

/*
- (id)copyWithZone:(NSZone *)zone {
    DiagnosisCode *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.code= self.code;
        copy.descrip = self.descrip;
        copy.typeId = self.typeId;
        copy.group = self.group;
        copy.system = self.system;
        copy.area = [self.area copy];
    }

    return copy;
}
*/


@end