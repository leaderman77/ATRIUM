//
// Created by Sanch0 on 11/12/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "PatientMedicalAlertItem.h"


@implementation PatientMedicalAlertItem

- (id)initWithMedicalName:(NSString *)medicalName withSelected:(BOOL)selected {
    self = [super init];
    if (self) {
        self.medicalName = medicalName;
        self.selected = selected;
    }
    return self;
}

- (id)initWithMedicalName:(NSString *)medicalName {
    self = [super init];
    if (self) {
        self.medicalName = medicalName;
    }
    return self;
}

//- (NSString *)name {
//    return self.medicalName;
//}


@end