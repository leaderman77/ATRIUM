//
// Created by Sanch0 on 11/12/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientMedicalAlertItem

@end

@interface PatientMedicalAlertItem : BaseObject

@property (nonatomic, strong) NSString *medicalName;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, assign) BOOL selected;

- (id)initWithMedicalName:(NSString *)medicalName;
- (id)initWithMedicalName:(NSString *)medicalName withSelected:(BOOL)selected;
@end