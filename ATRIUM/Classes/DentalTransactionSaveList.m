//
// Created by Sanch0 on 3/27/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DentalTransactionSaveList.h"


@implementation DentalTransactionSaveList {

}

- (NSMutableArray <DentalTransactionSaveItem> *)list {
    if (!_list) {
        _list = (NSMutableArray <DentalTransactionSaveItem> *) [[NSMutableArray alloc] init];
    }
    return _list;
}

@end