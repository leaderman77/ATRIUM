//
//  DentalTransactionFullItemList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class DentalTransactionFullItem;

@protocol DentalTransactionFullItem;
@interface DentalTransactionFullItemList : BaseObject

@property (nonatomic, strong) NSArray<DentalTransactionFullItem> *items;
@property (nonatomic, strong) NSNumber *totalCount;

@end
