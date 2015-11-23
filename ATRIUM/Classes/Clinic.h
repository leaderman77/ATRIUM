//
// Created by Sanch0 on 12/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Address;


@interface Clinic : BaseObject

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *registerDate;
@property (nonatomic, strong) NSNumber *modifiedDate;
@property (nonatomic, strong) Address *address;
@property (nonatomic, strong) NSNumber *roomCount;
@property (nonatomic, strong) SelectItem *treatmentPrice;
@property (nonatomic, strong) NSNumber *minTimeForVisit;

@end