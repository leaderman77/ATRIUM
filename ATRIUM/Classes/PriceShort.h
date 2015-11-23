//
// Created by Sanch0 on 4/9/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PriceShort

@end

@interface PriceShort : SelectItem

@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) SelectItem *priceSource;
@property (nonatomic, strong) NSNumber *needPreApproval;
@property (nonatomic, assign) BOOL defaultPrice;

+ (instancetype)priceShortWithPriceSource:(SelectItem *)priceSource withPrice:(NSNumber *)price;
@end