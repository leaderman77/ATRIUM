//
// Created by Sanch0 on 3/25/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ItemList.h"


@implementation ItemList {

}

- (NSMutableArray *)list {
    if (!_list) {
        _list = [[NSMutableArray alloc] init];
    }
    return _list;
}


@end