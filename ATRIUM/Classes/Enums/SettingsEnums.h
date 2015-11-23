//
//  SettingsEnums.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/11/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kMainLeftView = 1,
    KAboutView,
    kNotificationsView,
    kStatusColorsView,
    kSoftwareVersionsView,
    kSupportView,
    kLegalView,
    kAppointmentStatusView,
    kSelectStatusColorView,
    kPickerStatusColorView,
    kFavoritesView,
    kTreatmentViewDefaultStatusView,
} SettingsRightViewType;

//ACTIONS TYPE
typedef enum {
    MainLeftViewShouldOpenAboutView,
    MainLeftViewShouldOpenNotificationsView,
    MainLeftViewShouldOpenStatusColorsView,
    MainLeftViewShouldOpenAppointmentTypesColorsView,
    MainLeftViewShouldOpenFavoritesView,
    MainLeftViewShouldOpenTreatmentViewDefaultStatusView,
    AboutViewShouldOpenSowtwareVersionView,
    AboutViewShouldOpenSupportView,
    AboutViewShouldOpenLegalView,
    AppointmentStatusViewShouldOpenSelectStatusColorView,
    AppointmentStatusViewShouldOpenPickerStatusColorView,
    PickerStatusColorViewDidSelectColor,
} SettingsRightViewActionType;

typedef enum {
    //appointment status
    kUnconfirmed,
    kInWaiting,
    kConfirmed,
    kCheckedIn,
    kBeingSeen,
    kWillCall,
    kComplete,
    kCancelled,
    kMissed,
    //appointment types
    kGeneral,
    kConciltation,
    kOrtho,
    kCleaning,
    kSecondOpinion,
    kSurgery,
    kPreventiveInspection,
} AppointmentStatusType;


@interface SettingsEnums : NSObject

+ (UIColor *)getAppointmentStatusColor:(AppointmentStatusType)type ;
+ (void)setAppointmentStatusColorWith:(AppointmentStatusType)type withColor:(UIColor *)color;

+ (NSString *)getAppointmentStatusTitleWith:(AppointmentStatusType)type ;

+ (NSString *)getAppointmentStatusCode:(AppointmentStatusType)type;


@end
