//
// Created by Sanch0 on 6/17/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;

@interface PatientAttachment : BaseObject

@property (nonatomic, strong) Photo *photo;
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) SelectItem *member;

@end