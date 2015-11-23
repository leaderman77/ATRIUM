//
// Created by Sanch0 on 6/4/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"


@interface ToothConditionSearchParameters : SearchParameters

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, assign) BOOL isSupernumeraryTooth;
@property (nonatomic, strong) NSString *toothPositionCode;


@end