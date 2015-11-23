//
// Created by Sanch0 on 6/9/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ToothConditionsForDelete : BaseObject

@property (nonatomic, strong) NSMutableArray *ids;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *toothCode;
@property (nonatomic, strong) NSString *toothPosition;

@end