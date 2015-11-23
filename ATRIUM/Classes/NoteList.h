//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CompanyPatientProfileNote;

@protocol CompanyPatientProfileNote;

@interface NoteList : BaseObject

@property (nonatomic, strong) NSMutableArray<CompanyPatientProfileNote> *list;
@property (nonatomic, strong) NSNumber *totalCount;

@end