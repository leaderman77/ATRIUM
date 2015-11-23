//
//  AppointmentSmsReminder.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/15/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
#define kAppointmentSmsReminderTypeAutomatic        @"Automatic"
#define kAppointmentSmsReminderTypeManual           @"Manual"

@interface AppointmentSmsReminder : BaseObject
/*private Long id;
 private SelectItem template;
 private String recipientType;
 private String receiver;
 private Long runBefore;
 private Long runningType;
 private Long createdDate;*/
@property (nonatomic, strong) SelectItem *templateItem;
@property (nonatomic, strong) NSString *recipientType;
@property (nonatomic, strong) NSMutableArray<SelectItem> *recipients;
@property (nonatomic, strong) NSNumber *runBefore;
@property (nonatomic, strong) NSString *runningType;
@property (nonatomic, strong) NSNumber *createdDate;

@end
