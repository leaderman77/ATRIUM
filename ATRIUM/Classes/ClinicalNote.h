//
//  ClinicalNote.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 2/4/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class TemplateQuestion, PatientItem;

@protocol TemplateQuestion;

@interface ClinicalNote : BaseObject

@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) SelectItem *noteTemplate;
@property (nonatomic, strong) NSArray <TemplateQuestion>  *templateQuestionsAndAnswers;
@property (nonatomic, strong) NSNumber *modifiedDate;
@property (nonatomic, strong) NSNumber *appointmentId;
@property (nonatomic, strong) SelectItem *owner;
@property (nonatomic, strong) PatientItem *patient;



- (BOOL)isTemplateAviable;
- (NSString *)noteTextWithAnswers ;
- (void)calculateRangeAndSortTemplateQuestions;

@end
