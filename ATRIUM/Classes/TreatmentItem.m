//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "TreatmentItem.h"


@implementation TreatmentItem {

}


+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"description2" : @"descrip2", @"description" : @"descrip"}];
}


- (id)copyWithZone:(NSZone *)zone {
    TreatmentItem *copy = [[[self class] allocWithZone:zone] init];
    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.code = self.code;
        copy.descrip = self.descrip;
        copy.descrip2 = self.descrip2;
        copy.sortNo = self.sortNo;
        copy.principalDiagnosisCodeId = self.principalDiagnosisCodeId;
        copy.secondaryDiagnosisCodeId = self.secondaryDiagnosisCodeId;
    }

    return copy;
}

- (SelectItem *)toSelectItem {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:self.objectId withName:self.name];
    selectItem.code = self.code;
    selectItem.descrip = self.descrip;
    return selectItem;
}


@end