//
//  AppointmentSmsReminder.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/15/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "AppointmentSmsReminder.h"

@implementation AppointmentSmsReminder

+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"template" : @"templateItem"}];
}

@end
