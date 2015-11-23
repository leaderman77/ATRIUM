//
//  MemberWorkingHoursCollection.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class MemberWorkingHours, MemberPermission;

@interface MemberWorkingHoursCollection : BaseObject

@property (nonatomic, strong) NSNumber *memberId;
@property (nonatomic, strong) MemberWorkingHours *day1;
@property (nonatomic, strong) MemberWorkingHours *day2;
@property (nonatomic, strong) MemberWorkingHours *day3;
@property (nonatomic, strong) MemberWorkingHours *day4;
@property (nonatomic, strong) MemberWorkingHours *day5;
@property (nonatomic, strong) MemberWorkingHours *day6;
@property (nonatomic, strong) MemberWorkingHours *day7;
@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, strong) MemberPermission *memberPermission;
@property (nonatomic, strong) NSNumber *breakTimeBetweenAppointment;
@property (nonatomic, strong) NSArray<Ignore> *activeWorkingDays;
/*   private Long memberId;
 
 private MemberWorkingHoursTO day1;
 private MemberWorkingHoursTO day2;
 private MemberWorkingHoursTO day3;
 private MemberWorkingHoursTO day4;
 private MemberWorkingHoursTO day5;
 private MemberWorkingHoursTO day6;
 private MemberWorkingHoursTO day7;
 private Long companyId;
 private MemberPermissionTO memberPermission;
 private Long breakTimeBetweenAppointment;*/

@end
