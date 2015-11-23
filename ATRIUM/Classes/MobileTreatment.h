//
// Created by Sanch0 on 4/24/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PriceShort;

@protocol MobileTreatment

@end

@interface MobileTreatment : SelectItem

@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) SelectItem *status;
@property (nonatomic, strong) NSNumber *patientShare;
@property (nonatomic, strong) NSNumber *payerShare;
@property (nonatomic, strong) NSNumber *donNotBillInsurance;

@property (nonatomic, strong) NSNumber <Ignore> *priceChoosed;


@property (nonatomic, strong) NSMutableArray <SelectItem> *areaDetails;
@property (nonatomic, strong) NSNumber *treatmentId;
@property (nonatomic, strong) NSMutableArray <PriceShort> *priceList;


- (id)initWithSelectItem:(SelectItem *)selectItem;

@end