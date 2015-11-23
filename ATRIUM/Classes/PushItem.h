//
// Created by Sanch0 on 4/16/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PushItem : BaseObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSNumber *entityId;

@end