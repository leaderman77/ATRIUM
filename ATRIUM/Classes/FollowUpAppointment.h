//
//  FollowUpAppointment.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/26/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface FollowUpAppointment : BaseObject
/*private Long id;
 private String patientKey;
 private Long sourceId; //treatment code id
 private Long dentistId;
 private SelectItem status;
 private Long period;
 private SelectItem periodUnit;
 private SelectItem endType;
 private Long endDate;
 private Long occurrence;*/
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *sourceId;//treatment code id
@property (nonatomic, strong) NSNumber *dentistId;
@property (nonatomic, strong) SelectItem *status;
@property (nonatomic, strong) NSNumber *period;
@property (nonatomic, strong) SelectItem *periodUnit;
@property (nonatomic, strong) SelectItem *endType;
@property (nonatomic, strong) NSNumber *endDate;
@property (nonatomic, strong) NSNumber *occurrence;

@end
