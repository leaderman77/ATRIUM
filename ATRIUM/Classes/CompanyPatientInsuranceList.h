//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompanyPatientInsurance;
@class CompanyPatientInsurance;

@interface CompanyPatientInsuranceList : BaseObject

@property (nonatomic, strong) NSMutableArray <CompanyPatientInsurance> *list;
@property (nonatomic, strong) NSNumber *totalCount;

- (CompanyPatientInsurance *)getInsuranceWithType:(NSInteger)type;

- (CompanyPatientInsurance *)insuraceWithId:(NSNumber *)objectId;

@end