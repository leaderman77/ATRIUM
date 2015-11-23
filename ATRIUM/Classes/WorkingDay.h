//
//  WorkingDay.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 1/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface WorkingDay : BaseObject

@property (nonatomic, strong) NSString *workStart;
@property (nonatomic, strong) NSString *workEnd;
@property (nonatomic, strong) NSString *breakStart;
@property (nonatomic, strong) NSString *breakEnd;
@property (nonatomic, strong) SelectItem *weekDays;
@property (nonatomic, strong) NSNumber *active;

@end

