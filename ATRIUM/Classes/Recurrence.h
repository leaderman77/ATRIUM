//
//  Recurrence.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/19/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface Recurrence : BaseObject
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) SelectItem *category;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) SelectItem *recurrenceType;
@property (nonatomic, strong) NSNumber *repeatCount;
@property (nonatomic, assign) BOOL sunday;
@property (nonatomic, assign) BOOL monday;
@property (nonatomic, assign) BOOL tuesday;
@property (nonatomic, assign) BOOL wednesday;
@property (nonatomic, assign) BOOL thursday;
@property (nonatomic, assign) BOOL friday;
@property (nonatomic, assign) BOOL saturday;
@property (nonatomic, assign) BOOL customPattern;
@property (nonatomic, strong) NSNumber *monthDayNumber;
@property (nonatomic, strong) SelectItem *yearMonth;
@property (nonatomic, strong) SelectItem *yearWeekNumber;
@property (nonatomic, strong) SelectItem *yearWeekDay;
@property (nonatomic, strong) NSNumber *occurrences;
@property (nonatomic, strong) NSNumber *runBefore;
@property (nonatomic, strong) NSNumber *runningType;
@property (nonatomic, strong) SelectItem *recipientType;
@property (nonatomic, strong) SelectItem *filterGender;
@property (nonatomic, strong) NSNumber *startDate;
@property (nonatomic, strong) NSNumber *endDate;
@property (nonatomic, strong) NSArray<SelectItem> *templateItems;
@property (nonatomic, strong) NSMutableArray<SelectItem> *recipientItems;
/*private Long id;
 private String name;
 private String description;
 
 private SelectItem category;
 
 private boolean active;
 private SelectItem recurrenceType;
 private Integer repeatCount;
 
 private Boolean sunday = false;
 private Boolean monday = false;
 private Boolean tuesday = false;
 private Boolean wednesday = false;
 private Boolean thursday = false;
 private Boolean friday = false;
 private Boolean saturday = false;
 private Boolean customPattern = false;
 private Integer monthDayNumber;
 private SelectItem yearMonth;//january, february, ...
 
 private SelectItem yearWeekNumber;
 private SelectItem yearWeekDay;
 
 private Long occurrences;
 private Long runBefore = 0L; //for appointment sms notification "send before" field
 private Long runningType;
 
 private SelectItem recipientType;
 private SelectItem filterGender;
 private Date startDate;
 private Date endDate;
 private List<SelectItem> templateItems = new ArrayList<>();
 private List<SelectItem> recipientItems = new ArrayList<>();*/
@end
