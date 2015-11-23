//
// Created by Sanch0 on 3/26/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Treatment;
@class TreatmentMultiCode;
@protocol PriceShort;


@interface TreatmentMultiCodeWithPrices : BaseObject

@property (nonatomic, strong) Treatment *item;
@property (nonatomic, strong) TreatmentMultiCode *multiCode;
@property (nonatomic, strong) NSArray <PriceShort> *priceList1;
@property (nonatomic, strong) NSArray <PriceShort> *priceList2;
@property (nonatomic, strong) NSArray <PriceShort> *priceList3;
@property (nonatomic, strong) NSArray <PriceShort> *priceList4;
@property (nonatomic, strong) NSArray <PriceShort> *priceList5;
@property (nonatomic, strong) NSArray <PriceShort> *priceList6;

@property (nonatomic, assign) BOOL notBillInsurance;

@property (nonatomic, strong) NSDictionary <Ignore> *pricesDic;
@property (nonatomic, strong) NSNumber <Ignore> *selectedPriceIndex;
@end