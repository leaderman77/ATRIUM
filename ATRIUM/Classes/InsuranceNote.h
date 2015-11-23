//
//  InsuranceNote.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/13/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseTemplate.h"

@interface InsuranceNote : BaseTemplate

/*private String patientKey;
private SelectItem patient;
private SelectItem owner;*/

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) SelectItem *patient;
@property (nonatomic, strong) SelectItem *owner;
@property (nonatomic, strong) NSNumber *createdDate;

- (NSString *)getNoteWithTitle;

@end
