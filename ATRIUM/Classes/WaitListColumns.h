//
// Created by Sanch0 on 1/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FollowUpTableList;
@class WaitingTableList;
@class DentalChartTableList;


@interface WaitListColumns : BaseObject

@property (nonatomic, strong) FollowUpTableList *followUp;
@property (nonatomic, strong) WaitingTableList *waiting;
@property (nonatomic, strong) DentalChartTableList *dentalChart;

- (NSArray *)listByColumn:(NSInteger)column;

@end