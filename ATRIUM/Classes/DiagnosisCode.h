//
// Created by Sanch0 on 1/27/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DiagnosisItem;

@protocol DiagnosisCode

@end

@interface DiagnosisCode : SelectItem

@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) DiagnosisItem *group;
@property (nonatomic, assign) BOOL system;
@property (nonatomic, strong) SelectItem *area;
@property (nonatomic, strong) NSURL<Ignore>* favoriteImageUrl;
@property (nonatomic, strong) NSNumber <Ignore> *isPrimaryForPrescription;

- (SelectItem *)toSelectItem;


@end