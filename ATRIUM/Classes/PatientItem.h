//
//  PatientItem.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 2/7/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface PatientItem : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *chartNumber;

@end
