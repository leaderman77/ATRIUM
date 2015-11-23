//
// Created by Sanch0 on 1/13/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppoinmentSearchParameters : BaseObject

@property (nonatomic, strong) NSNumber *periodStart;
@property (nonatomic, strong) NSNumber *periodEnd;
@property (nonatomic, strong) NSString *weekDays;
@property (nonatomic, strong) NSString *timeStart;
@property (nonatomic, strong) NSString *timeEnd;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSNumber *dentistId;
@property (nonatomic, strong) NSNumber *dentalPointId;
@property (nonatomic, strong) NSNumber *appoinmentId;

@property (nonatomic, strong) NSMutableArray <Ignore> *weekDaysArray;

@end