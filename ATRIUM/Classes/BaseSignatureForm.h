//
// Created by Sanch0 on 11/12/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseSignatureForm : BaseObject

@property (nonatomic, strong) NSString *chartNumber;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *signature;

@end