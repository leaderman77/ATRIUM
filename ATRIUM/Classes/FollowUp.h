//
//  FollowUp.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/5/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface FollowUp : BaseObject

@property (nonatomic, strong) NSNumber* sortNo;
@property (nonatomic, strong) NSNumber* timeInPeriod;
@property (nonatomic, strong) SelectItem* period;

@end
