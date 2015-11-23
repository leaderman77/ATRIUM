//
//  PatientHouseHold.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/25/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class PatientForList;

@interface PatientHouseHold : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *chartNumber;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *dateOfBirth;
@property (nonatomic, strong) NSString *mobilePhoneNumber;

- (id)initWithPatientForList:(PatientForList *)patient;

@end
