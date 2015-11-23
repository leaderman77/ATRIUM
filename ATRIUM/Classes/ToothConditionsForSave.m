//
// Created by Sanch0 on 6/6/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ToothConditionsForSave.h"
#import "ToothConditionTemplate.h"


@implementation ToothConditionsForSave {

}

- (ToothConditionTemplate *)toothConditionTemplate {
    if (!_toothConditionTemplate) {
        _toothConditionTemplate = [[ToothConditionTemplate alloc] init];
    }
    return _toothConditionTemplate;
}


- (NSMutableArray <SelectItem> *)areaDetails {
    if (!_areaDetails) {
        _areaDetails = (NSMutableArray <SelectItem> *) [NSMutableArray new];
    }
    return _areaDetails;
}

@end