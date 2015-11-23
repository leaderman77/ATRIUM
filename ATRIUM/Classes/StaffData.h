//
//  StaffData.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/14/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class NSURL;

@interface StaffData : BaseObject <SelectItem>
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, strong) NSString *email;  
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, copy) NSString *staffPosition;

@end


