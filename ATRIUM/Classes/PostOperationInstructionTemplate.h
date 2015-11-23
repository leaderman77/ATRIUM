//
//  PostOperationInstructionTemplate.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface PostOperationInstructionTemplate : BaseObject
/*private Long id;
 private String name;
 private String description;
 private String header;
 private String body;
 private String footer;
 private SelectItem category;
 private boolean system;*/

@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, strong) NSNumber *typeId;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSString *descrip;//is description
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *footer;
@property (nonatomic, strong) SelectItem *category;
@property (nonatomic, assign) BOOL system;


@end
