//
// Created by Sanch0 on 2/4/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TreatmentFollowUp

@end

@interface TreatmentFollowUp : BaseObject

@property (nonatomic, strong) NSNumber *sortNo;
@property (nonatomic, strong) NSNumber *countOfPeriod;
@property (nonatomic, strong) SelectItem *period;

@end