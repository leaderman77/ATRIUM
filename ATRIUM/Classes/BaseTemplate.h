//
//  BaseTemplate.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/13/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol TemplateQuestionForList;

@interface BaseTemplate : BaseObject

/*private Long id;
 private String name;
 private String description;
 private String header;
 private String body;
 private String footer;
 private SelectItem category;
 private boolean system;
 private List<TemplateQuestionForListTO> questions = new ArrayList<>();*/
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *footer;
@property (nonatomic, strong) SelectItem *category;
@property (nonatomic, assign) BOOL system;
@property (nonatomic, strong) NSArray<TemplateQuestionForList> *questions;

@end
