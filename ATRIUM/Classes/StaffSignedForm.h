//
//  StaffSignedForm.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface StaffSignedForm : BaseObject

@property (nonatomic, strong) NSNumber *signedDate;
@property (nonatomic, strong) SelectItem *clinic;
@property (nonatomic, strong) NSString *pdfLink;
/*    private Long id;
 private Long signedDate;
 private SelectItem clinic;
 private String pdfLink;*/
@end
