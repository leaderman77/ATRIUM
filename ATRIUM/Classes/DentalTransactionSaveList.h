//
// Created by Sanch0 on 3/27/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DentalTransactionSaveItem;

@interface DentalTransactionSaveList : BaseObject

@property (nonatomic, strong) NSMutableArray <DentalTransactionSaveItem> *list;

@end