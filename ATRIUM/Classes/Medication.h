//
// Created by Sanch0 on 4/6/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Medication : BaseObject

@property (nonatomic, strong) SelectItem *category;
@property (nonatomic, strong) NSNumber *showInMedicationAlertForm;
@property (nonatomic, strong) NSArray <SelectItem> *substitutes;
@property (nonatomic, strong) NSArray <SelectItem> *incompatibles;

@end