//
//  MobileMember.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class MemberAddress, MemberWorkingHoursCollection, Member;

@interface MobileMember : BaseObject

@property (nonatomic, strong) Member *memberDetails;
@property (nonatomic, strong) MemberWorkingHoursCollection *workingHours;
@property (nonatomic, strong) MemberAddress *address;
@property (nonatomic, strong) NSString *signature;

@end
