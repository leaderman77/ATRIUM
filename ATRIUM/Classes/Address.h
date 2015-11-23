//
// Created by Sanch0 on 11/5/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Country;


@interface Address : BaseObject

@property (nonatomic, strong) NSString *postcode;
@property (nonatomic, strong) Country *country;
@property (nonatomic, strong) SelectItem *state;
@property (nonatomic, strong) SelectItem *town;
@property (nonatomic, strong) NSString *line1;
@property (nonatomic, strong) NSString *line2;


@end