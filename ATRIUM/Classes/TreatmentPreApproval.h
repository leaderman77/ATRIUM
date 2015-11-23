//
// Created by Sanch0 on 4/22/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, TreatmentPreApprovalStatus) {
    TreatmentPreApprovalStatusSendRequest = 1,     //code: Send_Request
    TreatmentPreApprovalStatusLater,               //code: Later
};

@interface TreatmentPreApproval : BaseObject

@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSMutableArray *dentalTransactions;
@property (nonatomic, strong) NSMutableArray <SelectItem> *diagnosis;
@property (nonatomic, strong) SelectItem *status;


@property (nonatomic, strong) NSMutableArray <Ignore> *treatmentList;

@property (nonatomic, strong) NSNumber *appointmentId;

+ (SelectItem *)selectItemStatusWithType:(TreatmentPreApprovalStatus)statusType;
@end