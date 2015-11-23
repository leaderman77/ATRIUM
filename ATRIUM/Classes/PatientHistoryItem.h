//
//  PatientHistoryItem.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 1/27/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface PatientHistoryItem : BaseObject

@property (nonatomic, strong) NSString *pdfUrl;
@property (nonatomic, strong) NSNumber *pdfCreatedDate;

@end
