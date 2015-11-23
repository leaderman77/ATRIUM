//
//  MobileClaimList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/6/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol Claim;

@interface MobileClaimList : BaseObject

@property (nonatomic, strong) NSMutableArray<Claim> *claimList;

@end
