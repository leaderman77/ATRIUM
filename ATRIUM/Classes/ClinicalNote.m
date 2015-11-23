//
//  ClinicalNote.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 2/4/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ClinicalNote.h"
#import "TemplateQuestion.h"
#import "PatientItem.h"
#import "TeethChartingEnums.h"
#import "ToothDetailsType.h"

#define kReplacementQuestionCodeString(code) [NSString stringWithFormat:@"[[%@]]", code]

@implementation ClinicalNote

-(void)calculateRangeAndSortTemplateQuestions {
    for(TemplateQuestion *question in self.templateQuestionsAndAnswers) {
        question.rangeLocation = @([self.noteTemplate.code rangeOfString:question.code].location);
        if(question.rangeLocation.integerValue > self.noteTemplate.code.length || question.rangeLocation.integerValue == 0) {
            DLog(@"Error Template question not found in tempolate text %@", question.name);
        }
    }
    self.templateQuestionsAndAnswers = (id)[self.templateQuestionsAndAnswers sortedArrayUsingComparator:^NSComparisonResult(TemplateQuestion *obj1, TemplateQuestion *obj2) {
        return [obj1.rangeLocation compare:obj2.rangeLocation];
    }];
}

- (NSString *)noteTextWithAnswers {
    NSString *note = self.noteTemplate.code;
    NSString *answer = @"";
    for (TemplateQuestion *question in self.templateQuestionsAndAnswers) {
        if([question.questionType.code isEqualToString:LIST_OF_ANSWERS]) {
            if(question.answers.count) {
                answer = [question.answers firstObject];
                note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(question.code) withString:answer];
            }
        } else if([question.questionType.code isEqualToString:LIST_OF_ANSWERS_MULTIPLE_CHOICE]) {
            if(question.answers.count) {
                answer = [question.answers componentsJoinedByString:@", "];
                note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(question.code) withString:answer];
            }
        }else if([question.questionType.code isEqualToString:FREE_FORM_ENTRY]) {
            if(question.answers.count) {
                answer = [question.answers firstObject];
                note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(question.code) withString:answer];
            }
        } else if([question.questionType.code isEqualToString:SURFACE_SELECTION]) {
            if(question.answers.count) {
                answer = [question.answers componentsJoinedByString:@" "];
                note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(question.code) withString:answer];
            }
        } else if([question.questionType.code isEqualToString:TEETH_SELECTION]) {
            NSMutableArray *positions = [NSMutableArray arrayWithCapacity:0];
            for (NSString *code  in question.answers) {
                ToothDetailsType *toothDetailsType = [[ToothDetailsType sharedInstance] toothDetailsWithCode:code];
                [positions addObject:toothDetailsType.numeric];
            }
            answer = [positions componentsJoinedByString:@" "];
            note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(question.code) withString:answer];
        } else if([question.questionType.name isEqualToString:DATE_SELECTOR]) {
            if(question.answers.count) {
                NSNumber *date = [question.answers firstObject];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = SHORT_DATE_FORMAT;
//                answer = [dateFormatter stringFromDate:[NSDate dateFromServerDateLong:date]];
                note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(question.code) withString:answer];
            }
        }
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = SHORT_DATE_FORMAT;
    note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(@"Current date") withString:[dateFormatter stringFromDate:date]];
    dateFormatter.dateFormat = HOURS_MINUTES_SECONDS_DATE_FORMAT;
    note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(@"Current time") withString:[dateFormatter stringFromDate:date]];
    note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(@"Patient chart number") withString:self.patient.chartNumber];
    note = [note stringByReplacingOccurrencesOfString:kReplacementQuestionCodeString(@"Patient name") withString:self.patient.fullName];
    
    return note;
}

- (BOOL)isTemplateAviable {
    return self.noteTemplate.name.length != 0;
}

@end
