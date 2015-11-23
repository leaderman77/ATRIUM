//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;
@class CompanyPatientPersonalDetails;


@interface PatientForAppointment : BaseObject

@property (nonatomic, strong) NSString *chartNumber;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *dateOfBirth;
@property (nonatomic, strong) SelectItem *gender;
@property (nonatomic, strong) NSString *mobilePhoneNumber;
@property (nonatomic, strong) NSString *workPhoneNumber;
@property (nonatomic, strong) NSString *homePhoneNumber;
@property (nonatomic, strong) Photo *photo;
@property (nonatomic, strong) NSNumber *companyPatientId;

@property (nonatomic, strong, readonly) NSString <Ignore> *fullName;
@property (nonatomic, strong) NSString <Ignore> *fullNameForSearch;


@end