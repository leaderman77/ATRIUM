//
// Created by Sanch0 on 11/21/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientEmergencyContact

@end


@interface PatientEmergencyContact : BaseObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *relationship;
@property (nonatomic, strong) NSString *homePhoneNumber;
@property (nonatomic, strong) NSString *mobilePhoneNumber;

@end