//
// Created by Sanch0 on 4/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DentalTransactionPartItem;


@interface DentalTransactionBreakToParts : BaseObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSNumber *currentAppointmentId;
@property (nonatomic, strong) NSMutableArray <DentalTransactionPartItem> *parts;

@end