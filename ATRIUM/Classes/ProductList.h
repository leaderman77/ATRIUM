//
//  ProductList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/20/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
@protocol Product;
@interface ProductList : BaseObject
@property (nonatomic, strong) NSMutableArray <Product> *list;
@property (nonatomic, strong) NSNumber *totalCount;
@end
