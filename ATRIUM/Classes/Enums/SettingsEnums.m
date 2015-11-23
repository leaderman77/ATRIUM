//
//  SettingsEnums.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/11/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "SettingsEnums.h"

@implementation SettingsEnums

+ (UIColor *)getAppointmentStatusColor:(AppointmentStatusType)type  {
    return [[SettingsManager sharedManager] colorForAppoinmentStatus:[self getAppointmentStatusCode:type]];
}

+ (void)setAppointmentStatusColorWith:(AppointmentStatusType)type withColor:(UIColor *)color {
    
}

+ (NSString *)getAppointmentStatusTitleWith:(AppointmentStatusType)type  {
    return nil;
    switch (type) {
        case kUnconfirmed:{
            return APPOINTMENT_STATUS_UNCONFIRMED;
        }break;
        case kConfirmed:{
            return APPOINTMENT_STATUS_CONFIRMED;
        }break;
        case kInWaiting:{
            return APPOINTMENT_STATUS_IN_WAITING;
        }break;
        case kCheckedIn:{
            return APPOINTMENT_STATUS_CHECKED_IN;
        }break;
        case kBeingSeen:{
            return APPOINTMENT_STATUS_BEING_SEEN;
        }break;
        case kWillCall:{
            return APPOINTMENT_STATUS_WILL_CALL;
        }break;
        case kComplete:{
            return APPOINTMENT_STATUS_COMPLETE;
        }break;
        case kCancelled:{
            return APPOINTMENT_STATUS_CANCELLED;
        }break;
        case kMissed:{
            return APPOINTMENT_STATUS_MISSED;
        }break;
//        case kStandby:{
//            return APPOINTMENT_STATUS_STANDBY;
//        }break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString *)getAppointmentStatusCode:(AppointmentStatusType)type {
    switch (type) {
        case kUnconfirmed:{
            return APPOINTMENT_STATUS_UNCONFIRMED;
        }break;
        case kConfirmed:{
            return APPOINTMENT_STATUS_CONFIRMED;
        }break;
        case kInWaiting:{
            return APPOINTMENT_STATUS_IN_WAITING;
        }break;
        case kCheckedIn:{
            return APPOINTMENT_STATUS_CHECKED_IN;
        }break;
        case kBeingSeen:{
            return APPOINTMENT_STATUS_BEING_SEEN;
        }break;
        case kWillCall:{
            return APPOINTMENT_STATUS_WILL_CALL;
        }break;
        case kComplete:{
            return APPOINTMENT_STATUS_COMPLETE;
        }break;
        case kCancelled:{
            return APPOINTMENT_STATUS_CANCELLED;
        }break;
        case kMissed:{
            return APPOINTMENT_STATUS_MISSED;
        }break;
//        case kStandby:{
//            return APPOINTMENT_STATUS_STANDBY;
//        }break;
            
        default:
            break;
    }
    return nil;
}

@end
