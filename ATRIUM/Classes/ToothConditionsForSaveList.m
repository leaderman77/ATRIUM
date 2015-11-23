//
// Created by Sanch0 on 6/6/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ToothConditionsForSaveList.h"
#import "ToothConditionsForSave.h"


@implementation ToothConditionsForSaveList {

}

- (NSMutableArray <ToothConditionsForSave> *)items {
    if (!_items) {
        _items = (NSMutableArray <ToothConditionsForSave> *) [NSMutableArray new];
    }
    return _items;
}

@end