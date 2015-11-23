//
// Created by Sanch0 on 10/21/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"


@interface PatientSearchParameters : SearchParameters

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *chartNumber;
@property (nonatomic, copy) NSString *patientKey;

@end