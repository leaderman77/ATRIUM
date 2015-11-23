//
//  LabOrderDocument.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/31/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "LabOrderDocument.h"
#import "Photo.h"
#import "Member.h"

@implementation LabOrderDocument

+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"description" : @"descrip"}];
}

@end
