//
// Created by Sanch0 on 11/19/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PatientForAppointment;
@class CompanyPatientPersonalDetails;


@interface PatientForList : BaseObject

@property (nonatomic, strong) NSString *chartNumber;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *photoKey;
@property (nonatomic, strong) NSURL *photoUrl;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSNumber *dateOfBirth;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *homePhoneNumber;
@property (nonatomic, strong) NSString *workPhoneNumber;
@property (nonatomic, strong) NSString *mobilePhoneNumber;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;


- (CompanyPatientPersonalDetails *)toCompanyPatient;

- (PatientForAppointment *)toPatientForAppoinment;
@end