//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompanyPatientProfileNote
@end

@interface CompanyPatientProfileNote : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *owner;

@end