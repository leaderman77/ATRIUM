//
//  NewUserProfile.h
//  ATRIUM
//
//  Created by Admin on 10/19/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseObject.h"

@interface NewUserProfile : BaseObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *confirmPassword;
@property (nonatomic, strong) NSNumber *birthDate;
@property (nonatomic, strong) NSString *phoneNumber;

- (void)copyValues:(NewUserProfile *)insurance;
@end
