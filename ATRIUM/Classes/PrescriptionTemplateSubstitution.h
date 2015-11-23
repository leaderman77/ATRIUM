//
// Created by Sanch0 on 3/11/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PrescriptionTemplateSubstitution

@end

@interface PrescriptionTemplateSubstitution : BaseObject

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) SelectItem *medication;

@property (nonatomic, strong) NSNumber *strength;
@property (nonatomic, strong) SelectItem *strengthUnit;

@property (nonatomic, strong) NSString <Ignore> *substitutionName;

@end