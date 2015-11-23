//
//  DentalTransactionBaseItemList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/6/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol DentalTransactionBaseItem ;

@interface DentalTransactionBaseItemList : BaseObject

@property (nonatomic, strong) NSArray <DentalTransactionBaseItem> *list;
@property (nonatomic, strong) NSNumber *totalCount;

@end
