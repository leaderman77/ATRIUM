//
//  TemplateQuestionForList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/13/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface TemplateQuestionForList : BaseObject
/*    private Long id;
 private String code;
 private String name;
 private String question;
 private SelectItem questionType;*/

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) SelectItem *questionType;

@end
