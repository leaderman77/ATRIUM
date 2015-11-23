//
//  MemberData.h
//  ATRIUM
//
//  Created by Admin on 10/19/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseObject.h"

@class NSURL;

@interface MemberData : BaseObject <SelectItem>

@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, copy) NSString *staffPosition;
@end
