//
// Created by Sanch0 on 4/22/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "TreatmentPreApproval.h"


@implementation TreatmentPreApproval {

}

+ (SelectItem *)selectItemStatusWithType:(TreatmentPreApprovalStatus)statusType {
    return [[SelectItem alloc] initWithId:@(statusType) withName:nil withCode:statusType == TreatmentPreApprovalStatusSendRequest ? @"Send_Request" : @"Later"];
}

- (NSMutableArray *)dentalTransactions {
    if (!_dentalTransactions) {
        _dentalTransactions = [[NSMutableArray alloc] init];
    }
    return _dentalTransactions;
}

- (NSMutableArray *)diagnosis {
    if (!_diagnosis) {
        _diagnosis = [[NSMutableArray alloc] init];
    }
    return _diagnosis;
}

- (NSMutableArray *)treatmentList {
    if (!_treatmentList) {
        _treatmentList = [[NSMutableArray alloc] init];
    }
    return _treatmentList;
}



@end