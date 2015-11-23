//
// Created by Sanch0 on 3/30/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CompleteDentalTransactions : BaseObject

@property (nonatomic, strong) NSNumber *currentAppointmentId;
@property (nonatomic, strong) NSArray *transactionKeys;
@property (nonatomic, strong) NSString *dentistToCashierNote;

@end