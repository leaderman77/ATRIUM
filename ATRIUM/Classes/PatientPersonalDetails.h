//
// Created by Sanch0 on 11/7/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatientEmergencyContact.h"


@class Address;
@class Photo;
@class PatientHouseHold;
@protocol PatientEmergencyContact;


@interface PatientPersonalDetails : BaseObject <NSCopying>

@property (nonatomic, strong) NSString *chartNumber;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *signature;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) SelectItem *nationality;
@property (nonatomic, strong) SelectItem *maritalStatus;
@property (nonatomic, strong) NSNumber *dateOfBirth;
@property (nonatomic, strong) SelectItem *gender;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *homePhoneNumber;
@property (nonatomic, strong) NSString *workPhoneNumber;
@property (nonatomic, strong) NSString *mobilePhoneNumber;
@property (nonatomic, assign) BOOL student;
@property (nonatomic, strong) Address *address;
@property (nonatomic, strong) Photo *photo;
@property (nonatomic, strong) NSNumber *weight;

@property (nonatomic, strong) NSString *documentSocialSecurityNumber;
@property (nonatomic, strong) NSString *documentDriverLicenseNumber;
@property (nonatomic, strong) NSString *documentSocialInsuranceNumber;
@property (nonatomic, strong) NSString *documentPasswordNumber;
@property (nonatomic, strong) NSString *documentNationalIdNumber;
@property (nonatomic, strong) PatientHouseHold *patientHouseHold;
@property (nonatomic, strong) NSMutableArray <PatientEmergencyContact> *emergencyContacts;

@property (nonatomic, strong) NSString <Ignore> *fullName;

@end