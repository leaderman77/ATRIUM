//
//  LabOrderDocument.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/31/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol  Photo;
//@class Member;

@interface LabOrderDocument : BaseObject

/*private Long id;
 private String orderNumber;
 private SelectItem labOrderTemplate;
 private SelectItem orderType;
 private SelectItem patient;
 private SelectItem dentist;
 private SelectItem externalLab;
 private SelectItem status;
 private List<SelectItem> toothList = new ArrayList<>();
 private SelectItem shade;
 private Date dueDate;
 private Date receivedDate;
 private BigDecimal price;
 private String description;
 private String pdfUrl;
 private List<PhotoTO> attachments = new ArrayList<>();
*/
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) SelectItem *labOrderTemplate;
@property (nonatomic, strong) SelectItem *orderType;
@property (nonatomic, strong) SelectItem *dentist;
@property (nonatomic, strong) SelectItem *patient;
@property (nonatomic, strong) SelectItem *externalLab;
@property (nonatomic, strong) SelectItem *status;
@property (nonatomic, strong) NSArray<SelectItem> *toothList;
@property (nonatomic, strong) SelectItem *shade;
@property (nonatomic, strong) NSNumber *dueDate;
@property (nonatomic, strong) NSNumber *receivedDate;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) NSURL *pdfUrl;
@property (nonatomic, strong) NSArray<Photo> *attachments;


@end
