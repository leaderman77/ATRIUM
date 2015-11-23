//
//  PatientDocument.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 2/18/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

#define kPatientDocumentSigned              @"Signed"
#define kPatientDocumentUnSigned            @"UnSigned"
#define kPatientDocumentRejected            @"Rejected"

@interface PatientDocument : BaseObject


/*  private String patientKey;
 private SelectItem templateItem;
 private SelectItem templateType;
 private Long createdDate;
 private Long signedDate;
 private boolean isSigned=false;
 private SelectItem status;*/

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) SelectItem *templateItem;
@property (nonatomic, strong) SelectItem *templateType;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSNumber *signedDate;
@property (nonatomic, strong) NSString *statusCode;
@property (nonatomic, strong) NSNumber *typeId;


+ (void)sortPatientDocumentsWithUnSignedFirst:(NSMutableArray *)documents;
+ (NSMutableArray *)getUnsignedPatientDocumentsSortPostedFirst:(NSMutableArray *)documents;
@end
