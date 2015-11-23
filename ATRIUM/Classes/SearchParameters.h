//
// Created by Sanch0 on 11/19/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchParameters : BaseObject

@property (nonatomic, strong) NSNumber *start;
@property (nonatomic, strong) NSNumber *limit;
@property (nonatomic, strong) NSString *sortField;
@property (nonatomic, strong) NSString *filterKey;
@property (nonatomic, strong) NSNumber *onlyNew;
@property (nonatomic, strong) NSNumber <Ignore> *totalCount;

- (id)initWithStart:(NSNumber *)start;

- (id)initWithStart:(NSNumber *)start withLimit:(NSNumber *)limit;

- (id)initWithStart:(NSNumber *)start withLimit:(NSNumber *)limit withSortField:(NSString *)sortField;

@end