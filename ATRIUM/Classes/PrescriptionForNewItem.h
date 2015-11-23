//
// Created by Sanch0 on 3/12/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PrescriptionForNewItem : BaseObject

@property (nonatomic, strong) NSArray <SelectItem> *medicationCategory; //DRUG category
@property (nonatomic, strong) NSArray <SelectItem> *strengthUnitList; //
@property (nonatomic, strong) NSArray <SelectItem> *amountUnitList;     //AMOUNT, Dispense Unit
@property (nonatomic, strong) NSArray <SelectItem> *routList;
@property (nonatomic, strong) NSArray <SelectItem> *routFrequencyList;
@property (nonatomic, assign) BOOL dentistHasSignature;

@end