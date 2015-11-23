//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDocumentSignStatus_UnSigned              @"DocumentSignStatus_UnSigned"
#define kDocumentSignStatus_Signed                @"DocumentSignStatus_Signed"
#define kDocumentSignStatus_Rejected              @"DocumentSignStatus_Rejected"

@protocol BaseNeedSignForm

@end

@interface BaseNeedSignForm : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *patientSignature;
@property (nonatomic, strong) SelectItem *templateItem;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSNumber *signedDate;
@property (nonatomic, strong) SelectItem *clinic;
@property (nonatomic, strong) NSString *statusCode;
@property (nonatomic, strong) NSString *signContent;
@property (nonatomic, strong) SelectItem *templateType;


@end