//
//  MemberWorkingHours.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 1/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"


@protocol WorkingDay;
@class MemberPermission;

@interface MemberWorkingHours : BaseObject

//@property (nonatomic, strong) NSArray<WorkingDay> *workingDays;
//@property (nonatomic, strong) NSNumber *companyId;
//@property (nonatomic, strong) MemberPermission *memberPermission;
//@property (nonatomic, strong) NSNumber *breakTimeBetweenAppointment;

@property (nonatomic, strong) NSString *workStart;
@property (nonatomic, strong) NSString *workEnd;
@property (nonatomic, strong) NSString *breakStart;
@property (nonatomic, strong) NSString *breakEnd;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) SelectItem *weekDays;

- (NSDate *)getDateFromString:(NSString *)time ;



@end
