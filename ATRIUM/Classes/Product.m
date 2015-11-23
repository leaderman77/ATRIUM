//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "Product.h"


@implementation Product

-(BOOL)isEqual:(Product *)object {
    if([object isKindOfClass:[self class]] && object) {
        return [self.objectId isEqualToNumber:[object objectId]];
    }
    return [super isEqual:object];
}

@end