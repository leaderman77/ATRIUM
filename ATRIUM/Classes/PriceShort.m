//
// Created by Sanch0 on 4/9/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PriceShort.h"


@implementation PriceShort {

}

+ (instancetype)priceShortWithPriceSource:(SelectItem *)priceSource withPrice:(NSNumber *)price {
    PriceShort *priceShort = [PriceShort new];
    priceShort.priceSource = priceSource;
    priceShort.price = price;
    return priceShort;
}

@end