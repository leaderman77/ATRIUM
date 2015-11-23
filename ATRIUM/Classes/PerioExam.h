//
//  PerioExam.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface PerioExam : BaseObject
/* private Long id;
 private String patientKey;
 private Long dentistId;
 private Date createdDate;
 private SelectItem tooth;
 private SelectItem plaqueStatus;
 private SelectItem mobilityStatus;
 private SelectItem boneLossStatus;
 private Long furcationStatus;
 private Boolean mucogingivalDefectStatus = false;
 
 private Long probingDepthDistal;
 private Long probingDepthCentral;
 private Long probingDepthMesial;
 
 private Long gingivalMarginDistal;
 private Long gingivalMarginCentral;
 private Long gingivalMarginMesial;
 
 private Long clinicalAttachmentDistal;
 private Long clinicalAttachmentCentral;
 private Long clinicalAttachmentMesial;
 
 private Boolean bleedingDistal = false;
 private Boolean bleedingCentral = false;
 private Boolean bleedingMesial = false;
 
 private Boolean suppurationDistal = false;
 private Boolean suppurationCentral = false;
 private Boolean suppurationMesial = false;*/

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *dentistId;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) SelectItem *tooth;
@property (nonatomic, strong) SelectItem *plaqueStatus;
@property (nonatomic, strong) SelectItem *mobilityStatus;
@property (nonatomic, strong) SelectItem *boneLossStatus;
@property (nonatomic, strong) NSNumber *furcationStatus;
@property (nonatomic, assign) BOOL mucogingivalDefectStatus;

@property (nonatomic, strong) NSNumber * probingDepthDistal;
@property (nonatomic, strong) NSNumber * probingDepthCentral;
@property (nonatomic, strong) NSNumber * probingDepthMesial;

@property (nonatomic, strong) NSNumber * gingivalMarginDistal;
@property (nonatomic, strong) NSNumber * gingivalMarginCentral;
@property (nonatomic, strong) NSNumber * gingivalMarginMesial;

@property (nonatomic, strong) NSNumber * clinicalAttachmentDistal;
@property (nonatomic, strong) NSNumber * clinicalAttachmentCentral;
@property (nonatomic, strong) NSNumber * clinicalAttachmentMesial;

@property (nonatomic, assign) BOOL bleedingDistal;
@property (nonatomic, assign) BOOL bleedingCentral;
@property (nonatomic, assign) BOOL bleedingMesial;

@property (nonatomic, assign) BOOL suppurationDistal;
@property (nonatomic, assign) BOOL suppurationCentral;
@property (nonatomic, assign) BOOL suppurationMesial;

@property (nonatomic, strong) SelectItem *toothSide;
- (BOOL)isFrontSide;

+ (SelectItem *)plaqueStatusWith:(NSInteger)type;
+ (SelectItem *)mobilityStatusWith:(NSInteger)type;
+ (SelectItem *)boneLossStatusWith:(NSInteger)type;
@end
