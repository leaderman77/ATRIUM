//
// Created by Sanch0 on 3/30/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DentalTransactionPartItem

@end

@interface DentalTransactionPartItem : BaseObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) SelectItem *status;
@property (nonatomic, strong) NSNumber *closedAppointmentId;

@property (nonatomic, strong) NSNumber <Ignore> *checked;
@end