//
// Created by Sanch0 on 10/17/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface NewsItem : BaseObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSURL *redirectUrl;
@property (nonatomic, copy) NSNumber *createdDate;

@property (nonatomic, copy) NSDate<Ignore> *date;
@property (nonatomic, copy) NSString<Ignore> *shortDescription;



@end