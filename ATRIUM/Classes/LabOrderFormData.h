//
//  LabOrderFormData.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/1/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class PatientPersonalDetails, Member;
@protocol SelectItem ;

@interface LabOrderFormData : BaseObject

//private List<SelectItem> externalLabList;
//private List<SelectItem> toothList;
//private List<SelectItem> templateList;
//private MemberTO dentist;
//private PatientPersonalDetailsTO patient;

@property (nonatomic, strong) NSArray<SelectItem> *externalLabList;
@property (nonatomic, strong) NSArray<SelectItem> *toothList;
@property (nonatomic, strong) NSArray<SelectItem> *templateList;
@property (nonatomic, strong) Member *dentist;
@property (nonatomic, strong) PatientPersonalDetails *patient;
@end
