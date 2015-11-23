//
// Created by Sanch0 on 10/24/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerPopover.h"

@class PickerPopover;
@class CustomTextField;
@class MLPAutoCompleteTextField;
@class BaseInfoView;
@class PatientPersonalDetails;
@class PatientSignatureFormForShow;
@class CompanyPatientInsurance;

#define LABEL_FRAME                              CGRectMake(left, top, labelWidth, labelHeight)
#define LABEL_FRAME_WITH_LEFT(left)              CGRectMake(left, top, labelWidth, labelHeight)
#define TEXTFIELD_FRAME                          CGRectMake(left, top, labelWidth, textFieldHeight)
#define TEXTFIELD_FRAME_WITH_LEFT(left)          CGRectMake(left, top, labelWidth, textFieldHeight)

#define FIRST_NAME @"FIRST_NAME"
#define LAST_NAME @"LAST_NAME"
#define MIDDLE_NAME @"MIDDLE_NAME"
#define NATIONALITY @"NATIONALITY"
#define MARITAL_STATUS @"MARITAL_STATUS"
#define STUDENT_STATUS @"STUDENT_STATUS"
#define DATE_OF_BIRTH @"DATE_OF_BIRTH"
#define GENDER @"GENDER"
#define EMAIL @"EMAIL"
#define HOME_PHONE_NUMBER @"HOME_PHONE_NUMBER"
#define WORK_PHONE_NUMBER @"WORK_PHONE_NUMBER"
#define MOBILE_PHONE_NUMBER @"MOBILE_PHONE_NUMBER"
#define ADDRESS @"ADDRESS"
#define PHOTO @"PHOTO"
#define WEIGHT @"WEIGHT"
#define EMERGENCY_CONTACT_FIRST_NAME @"EMERGENCY_CONTACT_FIRST_NAME"
#define EMERGENCY_CONTACT_LAST_NAME @"EMERGENCY_CONTACT_LAST_NAME"
#define EMERGENCY_CONTACT_RELATIONSHIP @"EMERGENCY_CONTACT_RELATIONSHIP"
#define EMERGENCY_CONTACT_HOME_PHONE_NUMBER @"EMERGENCY_CONTACT_HOME_PHONE_NUMBER"
#define EMERGENCY_CONTACT_MOBILE_PHONE_NUMBER @"EMERGENCY_CONTACT_MOBILE_PHONE_NUMBER"






@protocol BaseInfoViewDelegate<NSObject>
- (void)baseInfoView:(BaseInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value;
@end

@interface BaseInfoView : UIView<UITextFieldDelegate, PickerPopoverDelegate> {
@protected
    CGFloat top;
    CGFloat labelWidth;
    CGFloat labelHeight;
    CGFloat textFieldHeight;
    CGFloat left;
}

@property (nonatomic, weak) id<BaseInfoViewDelegate>baseDelegate;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UILabel *titleInfoLabel;
@property (nonatomic, strong) UIView *leftTitleLine;
@property (nonatomic, strong) UIView *rightTitleLine;

@property (nonatomic, strong) PickerPopover *pickerPopover;

@property (nonatomic, strong) id patientDic;
@property (nonatomic, assign) BOOL isViewMode;

@property (nonatomic,   weak) UIScrollView *scrollView;
@property (nonatomic, strong) PatientSignatureFormForShow *patientSignatureFormForShow;
@property (nonatomic, readonly) PatientPersonalDetails *patientDetails;

@property (nonatomic, strong) NSMutableDictionary *textFieldsDic;
@property (nonatomic, strong) NSMutableSet *mandatoryFields;

- (void)changeTextFieldEditMode:(UITextField *)textField;
/*

CGFloat top = 0.f;
CGFloat labelWidth = 380.f;
CGFloat labelHeight = 30.f;
CGFloat textFieldHeight = 50.f;
CGFloat left = 0.5 * (self.width - labelWidth);

*/


- (void)createAndLayoutSubviews;
- (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title;
- (CustomTextField *)textFieldWithFrame:(CGRect)frame withArrow:(BOOL)flag;
- (MLPAutoCompleteTextField *)autoCompleteTextFieldWithFrame:(CGRect)frame withArrow:(BOOL)flag;


- (void)populatePatientDetails;
- (BOOL)isEmptyTextField:(UITextField *)textField;
- (BOOL)validateAndPopulatePatientDetails;

- (void)populateWithPatientSignature:(PatientSignatureFormForShow *)patientSignatureFormForShow;
- (void)populateWithPatientDetails:(PatientPersonalDetails *)patientDetails;
- (void)changeToOrientation:(UIInterfaceOrientation )orientation;

@end