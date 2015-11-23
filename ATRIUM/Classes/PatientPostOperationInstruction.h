//
//  PatientPostOperationInstruction.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
@class PostOperationInstructionTemplate;
@interface PatientPostOperationInstruction : BaseObject

/*private String patientKey;
 private Long treatmentCodeId;
 private SelectItem dentist;
 private String pdfUrl;
 private Long createdDate;
 private SelectItem type;
 private String content;
 private PostOperationInstructionTemplateTO template;*/
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *treatmentCodeId;
@property (nonatomic, strong) SelectItem *dentist;

@property (nonatomic, strong) NSURL *pdfUrl;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSString *descrip;//is description
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) SelectItem *type;
@property (nonatomic, strong) PostOperationInstructionTemplate *instructionTemplate;//is template
@end
