//
// Created by Sanch0 on 12/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CompanyShort : BaseObject

@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) SelectItem *timezone;

@end