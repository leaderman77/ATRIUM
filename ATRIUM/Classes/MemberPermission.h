//
//  MemberPermission.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 1/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface MemberPermission : BaseObject

@property (nonatomic, strong) NSNumber *canEditGeneralInfo;
@property (nonatomic, strong) NSNumber *canEditAccountDetail;
@property (nonatomic, strong) NSNumber *canEditEmployeeInfo;
@property (nonatomic, strong) NSNumber *canEditBankAccountInfo;
@property (nonatomic, strong) NSNumber *canEditPostAddress;
@property (nonatomic, strong) NSNumber *canEditBillingAddress;
@property (nonatomic, strong) NSNumber *canEditWorkingHours;

@end


