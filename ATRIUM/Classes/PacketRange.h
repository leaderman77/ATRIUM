//
// Created by Sanch0 on 2/4/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TreatmentItem;

@protocol PacketRange

@end

@interface PacketRange : BaseObject

@property (nonatomic, strong) TreatmentItem *startCode;
@property (nonatomic, strong) TreatmentItem *endCode;

@end