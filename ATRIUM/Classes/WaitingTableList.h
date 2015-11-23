//
// Created by Sanch0 on 1/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ClinicAppointment;


@interface WaitingTableList : BaseObject

@property (nonatomic, strong) NSArray <ClinicAppointment> *list;
@property (nonatomic, strong) NSNumber *totalCount;

@end