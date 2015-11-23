//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseNeedSignForm;


@interface BaseNeedSignFormList : BaseObject

@property (nonatomic, strong) NSMutableArray <BaseNeedSignForm> *list;
@property (nonatomic, strong) NSNumber *totalCount;
- (void)sortBaseNeedSignFormListWithUnSignedFirst;
- (NSArray *)getUnSignedItems;

@end