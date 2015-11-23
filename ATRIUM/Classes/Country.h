//
// Created by Sanch0 on 11/5/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLPAutoCompletionObject.h"

@interface Country : BaseObject<MLPAutoCompletionObject>

@property (nonatomic, assign) BOOL hasStates;
@property (nonatomic, strong) NSString *phoneCode;

@end