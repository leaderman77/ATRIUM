//
// Created by Sanch0 on 4/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DentalTransactionBreakToParts.h"
#import "DentalTransactionPartItem.h"


@implementation DentalTransactionBreakToParts {

}

- (NSMutableArray <DentalTransactionPartItem> *)parts {
    if (!_parts) {
        _parts = (NSMutableArray <DentalTransactionPartItem> *) [[NSMutableArray alloc] init];
    }
    return _parts;
}

@end