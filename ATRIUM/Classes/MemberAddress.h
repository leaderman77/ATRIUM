//
//  MemberAddress.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
@class Address, MemberPermission;

@interface MemberAddress : BaseObject

@property (nonatomic, strong) NSNumber *memberId;
@property (nonatomic, assign) BOOL duplicateAddress;
@property (nonatomic, strong) Address *postAddress;
@property (nonatomic, strong) Address *billingAddress;
@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, strong) MemberPermission *memberPermission;

@end
