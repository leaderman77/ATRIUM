//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeethChartingEnums.h"

@class Treatment;
@class Product;

@protocol DentalTransaction

@end

@interface DentalTransaction : BaseObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) SelectItem *type;
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSNumber *modifiedDate;
@property (nonatomic, strong) SelectItem *status;           //planed, completed, exist for treatment

@property (nonatomic, strong) SelectItem *tooth;            //if we use tooth
@property (nonatomic, strong) SelectItem *toothPosition;    //if we use tooth

@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) SelectItem *priceSource;

@property (nonatomic, strong) SelectItem *area;
@property (nonatomic, strong) NSArray <SelectItem> *areaDetails;

@property (nonatomic, strong) NSNumber *partCount;

@property (nonatomic, strong) NSNumber *createdAppointmentId;
@property (nonatomic, strong) NSNumber *closedAppointmentId;

//item
@property (nonatomic, strong) SelectItem *treatmentItem;
@property (nonatomic, strong) SelectItem *diagnosisItem;
@property (nonatomic, strong) SelectItem *diagnosisItem2;
@property (nonatomic, strong) SelectItem *productItem;


@property (nonatomic, strong) NSDate <Ignore> *createdDateLocal;


+ (SelectItem *)selectItemStatus:(DentalTransactionStatusType)dentalTransactionStatusType;

+ (SelectItem *)selectItemTransactionType:(TransactionType)transactionType;

+ (SelectItem *)selectItemTreatmentAreaType:(TreatmentAreaType)treatmentAreaType;

+ (SelectItem *)selectItemWithTreatmentArea:(TreatmentAreaType)treatmentAreaType withEnum:(NSInteger)enumType;

extern NSString *const PLANNED;
extern NSString *const EXISTING;
extern NSString *const PAID;
extern NSString *const CANCELED;
extern NSString *const COMPLETED;

@end