//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "CompanyPatientInsuranceList.h"
#import "CompanyPatientInsurance.h"


@implementation CompanyPatientInsuranceList {

}

- (CompanyPatientInsurance *)getInsuranceWithType:(NSInteger)type {
    __block CompanyPatientInsurance *result = nil;
    [self.list enumerateObjectsUsingBlock:^(CompanyPatientInsurance *obj, NSUInteger idx, BOOL *stop) {
        if (obj.type.objectId && obj.type.objectId.integerValue == type) {
            result = obj;
            *stop = YES;
        }
    }];
    return result;
}

- (CompanyPatientInsurance *)insuraceWithId:(NSNumber *)objectId {
    if (objectId.integerValue <= 0) {
        return nil;
    }
    __block CompanyPatientInsurance *result = nil;
    [self.list enumerateObjectsUsingBlock:^(CompanyPatientInsurance *obj, NSUInteger idx, BOOL *stop) {
        if ([objectId isEqualToNumber:obj.objectId]) {
            result = obj;
            *stop = YES;
        }
    }];
    return result;
}

@end