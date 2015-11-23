//
//  NewUserProfile.m
//  ATRIUM
//
//  Created by Admin on 10/19/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "NewUserProfile.h"

@implementation NewUserProfile

- (void)copyValues:(NewUserProfile *)userProfile {
    self.email = userProfile.email;
    self.fullName = userProfile.fullName;
    self.password = userProfile.password;
    self.confirmPassword = userProfile.confirmPassword;
    self.birthDate = userProfile.birthDate;
    self.phoneNumber = userProfile.phoneNumber;
}


@end
