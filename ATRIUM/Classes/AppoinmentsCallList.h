//
// Created by Sanch0 on 1/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CallListColumn;


@interface AppoinmentsCallList : BaseObject

@property (nonatomic, strong) NSArray <CallListColumn> *points;

@end