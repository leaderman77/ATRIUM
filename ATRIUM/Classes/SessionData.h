//
//  SessionData.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/15/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
#import "SelectItem.h"

@class Address;
@class CompanyShort;
@class Clinic;

@interface SessionData : BaseObject

@property (nonatomic, strong) CompanyShort *company;
@property (nonatomic, strong) Clinic *clinic;
@property (nonatomic, strong) SelectItem *device;
@property (nonatomic, strong) SelectItem *member;
@property (nonatomic, strong) NSArray *permissions;
@property (nonatomic, strong) SelectItem *toothNumericType;

@property (nonatomic, strong) NSNumber <Ignore> *memberId;

@property (nonatomic, strong) NSSet <Ignore> *permissionsSet;
@end
