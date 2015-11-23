//
// Created by Sanch0 on 2/4/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCell.h"
#import "PacketRange.h"

@class PacketRange;

@protocol Packet

@end

@interface Packet : BaseObject

@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) SelectItem *speciality;
@property (nonatomic, strong) NSMutableArray <Packet> *children;
@property (nonatomic, strong) NSArray <PacketRange> *treatments;


@end