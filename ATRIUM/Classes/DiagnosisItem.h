//
// Created by Sanch0 on 1/27/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DiagnosisItem
@end

@interface DiagnosisItem : SelectItem

@property (nonatomic, strong) NSNumber *sortNo;

@end