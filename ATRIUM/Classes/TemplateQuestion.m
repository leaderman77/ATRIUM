//
//  TemplateQuestion.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 2/7/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "TemplateQuestion.h"

@implementation TemplateQuestion

- (NSMutableArray *)answers {
    if(!_answers) {
        _answers = [NSMutableArray arrayWithCapacity:0];
    }
    return _answers;
}

@end
