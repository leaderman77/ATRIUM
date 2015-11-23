//
//  PostOperationInstructionTemplate.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PostOperationInstructionTemplate.h"

@implementation PostOperationInstructionTemplate

+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"description" : @"descrip"}];
}

@end
