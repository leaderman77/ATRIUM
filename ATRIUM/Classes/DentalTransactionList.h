//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DentalTransaction;


@interface DentalTransactionList : BaseObject

@property (nonatomic, strong) NSArray <DentalTransaction> *list;
@property (nonatomic, strong) NSNumber *totalCount;

@end