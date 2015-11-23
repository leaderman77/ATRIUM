//
//  DentalTransactionBaseItem.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
#import "TeethChartingEnums.h"

@interface DentalTransactionBaseItem : BaseObject
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

@property (nonatomic, strong) NSNumber *treatmentPriceRowId;

@property (nonatomic, strong) SelectItem *area;
@property (nonatomic, strong) NSArray <SelectItem> *areaDetails;

@property (nonatomic, assign) NSInteger partCount;

@property (nonatomic, strong) NSNumber *createdAppointmentId;
@property (nonatomic, strong) NSNumber *closedAppointmentId;

@property (nonatomic, strong) SelectItem *treatmentItem;
@property (nonatomic, strong) SelectItem *diagnosisItem;
@property (nonatomic, strong) SelectItem *diagnosisItem2;
@property (nonatomic, strong) SelectItem *productItem;
@property (nonatomic, strong) NSNumber *productCount;

@property (nonatomic, strong) SelectItem *createdDentist;
@property (nonatomic, strong) SelectItem *closedDentist;
@property (nonatomic, assign) BOOL sendBillInsurance;

@property (nonatomic, strong) NSDate <Ignore> *createdDateLocal;
@property (nonatomic, strong) NSString <Ignore> *areaDetailsStr;
@property (nonatomic, strong) NSString <Ignore> *toothNumberStr;
@property (nonatomic, strong) SelectItem *approvalStatus;


+ (SelectItem *)selectItemStatus:(DentalTransactionStatusType)dentalTransactionStatusType;

+ (SelectItem *)selectItemTransactionType:(TransactionType)transactionType;

+ (SelectItem *)selectItemTreatmentAreaType:(TreatmentAreaType)treatmentAreaType;

+ (SelectItem *)selectItemWithTreatmentArea:(TreatmentAreaType)treatmentAreaType withEnum:(NSInteger)enumType;

- (NSString *)getAreaDetailsCodesSeparated;
- (NSString *)getAreaDetailsNames;
+ (TreatmentAreaType)transactionAreaTypeWithCode:(NSString *)code;

@end
