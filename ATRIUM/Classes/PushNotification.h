//
// Created by Sanch0 on 4/17/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PushNotification : BaseObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSNumber *memberId;
@property (nonatomic, strong) SelectItem *status;

@property (nonatomic, strong) NSNumber *appointmentId;

@property (nonatomic, strong) NSDate <Ignore> *createdDateLocal;

@end