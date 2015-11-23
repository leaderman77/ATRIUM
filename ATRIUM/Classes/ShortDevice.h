//
// Created by Sanch0 on 2/19/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShortDevice : BaseObject

@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSNumber *clinicId;
@property (nonatomic, strong) NSNumber *companyId;

@end