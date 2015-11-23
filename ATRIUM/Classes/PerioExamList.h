//
//  PerioExamList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/28/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
@class PerioExam;
@protocol PerioExam ;

@interface PerioExamList : BaseObject

@property (nonatomic, strong) NSMutableArray<PerioExam> *perioExamList;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) SelectItem *dentist;
- (PerioExam *)perioExamWithCode:(NSString *)code ;
- (PerioExam *)perioExamWithObjetcId:(NSNumber *)objetcId withToothSideCode:(NSString *)toothSideCode;
@end
