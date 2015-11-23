//
// Created by Sanch0 on 10/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientForLogin : BaseObject

/*
    private String patientKey;
    private String chartNumber;
    private String firstName;
    private String lastName;
    private String middleName;
    private Long dateOfBirth;
    private String homePhoneNumber;
    private String workPhoneNumber;
    private String mobilePhoneNumber;
*/

@property (nonatomic, copy) NSString *patientKey;
@property (nonatomic, copy) NSString *chartNumber;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) SelectItem *gender;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, strong) NSNumber *dateOfBirth;
@property (nonatomic, copy) NSString *homePhoneNumber;
@property (nonatomic, copy) NSString *workPhoneNumber;
@property (nonatomic, copy) NSString *mobilePhoneNumber;
@property (nonatomic, strong) NSURL *photoUrl;

@property (nonatomic, strong) NSDate<Ignore> *birthDate;

@end