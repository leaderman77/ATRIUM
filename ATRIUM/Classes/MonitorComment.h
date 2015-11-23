//
//  MonitorComment.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/7/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface MonitorComment : BaseObject

/*private Long monitorId;
 private SelectItem dentist;
 private String comment;
 private Long commentDate;*/

@property (nonatomic, strong) NSNumber *monitorId;
@property (nonatomic, strong) SelectItem *dentist;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSNumber *commentDate;

@end
