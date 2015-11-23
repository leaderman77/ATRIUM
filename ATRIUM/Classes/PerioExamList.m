//
//  PerioExamList.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/28/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PerioExamList.h"
#import "PerioExam.h"

@implementation PerioExamList

- (PerioExam *)perioExamWithCode:(NSString *)code {
    for (PerioExam *perioExam in self.perioExamList) {
        if([perioExam.tooth.code isEqualToString:code]) {
            return perioExam;
        }
    }
    return nil;
}

- (PerioExam *)perioExamWithObjetcId:(NSNumber *)objetcId withToothSideCode:(NSString *)toothSideCode {
    NSArray *filteredArray = [self.perioExamList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"toothSide.code ==[c] %@ && tooth.objectId == %lld", toothSideCode, [objetcId longLongValue]]];
    if(!filteredArray.count)  {
        DLog(@"");
    }
    return [filteredArray firstObject];
}

@end
