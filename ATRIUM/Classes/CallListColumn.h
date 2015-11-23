//
// Created by Sanch0 on 12/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ClinicAppointment;

@protocol CallListColumn
@end

@interface CallListColumn : BaseObject

@property (nonatomic, strong) SelectItem *dentalPoint;
@property (nonatomic, strong) SelectItem *dentist;
@property (nonatomic, strong) NSMutableArray <ClinicAppointment> *list;
@property (nonatomic, strong, readonly) NSDictionary <Ignore> *clinicAppointmentsByIds;

@property (nonatomic, strong) NSNumber *date;
@property (nonatomic, strong) NSDate *dateLocal;

//@property (nonatomic, strong) NSNumber <Ignore> *startTime;
- (void)reCalculateListPositions;

@end