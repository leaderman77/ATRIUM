//
// Created by Sanch0 on 3/30/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DentalTransactionBaseItem.h"

@protocol DentalTransactionPartItem;


@interface DentalTransactionListItem : DentalTransactionBaseItem

@property (nonatomic, strong) NSMutableArray <DentalTransactionPartItem> *parts;
@property (nonatomic, strong) NSNumber <Ignore> *checked;


@end