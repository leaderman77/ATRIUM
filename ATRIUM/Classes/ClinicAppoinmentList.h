//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClinicAppointment;

@protocol ClinicAppointment;

@interface ClinicAppoinmentList : BaseObject

@property (nonatomic, strong) NSArray<ClinicAppointment> *list;
@property (nonatomic, strong) NSNumber *totalCount;
@end