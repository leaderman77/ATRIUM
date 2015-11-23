//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Product : BaseObject

@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, strong) NSNumber<Ignore>* count;

@end