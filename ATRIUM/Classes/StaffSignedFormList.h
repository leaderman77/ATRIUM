//
//  StaffSignedFormList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol StaffSignedForm;
@interface StaffSignedFormList : BaseObject

@property (nonatomic, strong) NSArray<StaffSignedForm> *items;
@property (nonatomic, strong) NSNumber *totalCount;

@end
