//
// Created by Sanch0 on 6/6/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ToothConditionsForSave;

@interface ToothConditionsForSaveList : BaseObject

@property (nonatomic, strong) NSMutableArray <ToothConditionsForSave> *items;

@end