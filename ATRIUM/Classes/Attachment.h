//
//  Attachment.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/6/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface Attachment : BaseObject

/*private Long id;
private String key;
private String fileName;
private long size;
private String contentType;
private String publicUrl;*/
@property (nonatomic, strong) NSNumber *size;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSURL *publicUrl;

@end
