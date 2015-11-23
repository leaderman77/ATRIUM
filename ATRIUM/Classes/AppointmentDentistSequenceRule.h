//
//  AppointmentDentistSequenceRule.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/2/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface AppointmentDentistSequenceRule : BaseObject

/* private Long appointmentId;
 private String patientKey;
 private Long dentistId;
 private Long startDate;
 
 private Long period;
 private SelectItem periodUnit;
 
 private SelectItem endType;
 private Long endDate;
 private Long limitCount;*/

@property (nonatomic, strong) NSNumber *appointmentId;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *dentistId;
@property (nonatomic, strong) NSNumber *startDate;
@property (nonatomic, strong) NSNumber *period;
@property (nonatomic, strong) SelectItem *periodUnit;
@property (nonatomic, strong) SelectItem *endType;
@property (nonatomic, strong) NSNumber *endDate;
@property (nonatomic, strong) NSNumber *limitCount;
@property (nonatomic, strong) SelectItem *status;
//periodUnit

@end
