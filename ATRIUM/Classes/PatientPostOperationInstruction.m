//
//  PatientPostOperationInstruction.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientPostOperationInstruction.h"
#import "PostOperationInstructionTemplate.h"
@implementation PatientPostOperationInstruction


+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"description" : @"descrip",
                                    @"template" : @"instructionTemplate" }];
}

@end
