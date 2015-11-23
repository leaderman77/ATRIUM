//
//  TemplateQuestion.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 2/7/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface TemplateQuestion : BaseObject


@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) SelectItem *questionType;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSMutableArray *answers;
@property (nonatomic, strong) NSString *typeKey;
//local

@property (nonatomic, strong) NSNumber <Ignore> *rangeLocation;
@end
