//
// Created by Sanch0 on 6/17/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientAttachment.h"


@implementation PatientAttachment {

}

+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"description" : @"descrip"}];
}

@end