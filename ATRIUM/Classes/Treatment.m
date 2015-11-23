//
// Created by Sanch0 on 2/4/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "Treatment.h"
#import "TreatmentItem.h"
#import "DiagnosisItem.h"


@implementation Treatment {

}

- (NSString *)stringAreaWithDetails {
    if (self.area.name.length > 0) {
        NSArray *areaDetails = [self.areaDetails valueForKey:@"name"];
        NSString *areaDetailsStr = [NSString stringWithFormat:@"%@ : %@", TRANSLATE(self.area.name), [areaDetails componentsJoinedByString:@","]];
        return areaDetailsStr;
    }
    return @"";
}


- (id)copyWithZone:(NSZone *)zone {
    Treatment *copy = [[[self class] allocWithZone:zone] init];
    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.code = self.code;
        copy.descrip = self.descrip;
        copy.typeId = self.typeId;
        copy.description2 = self.description2;
        copy.group = [self.group copy];
        copy.areaDetails = [self.areaDetails copy];
        copy.principalDiagnose = [self.principalDiagnose copy];

        copy.selected = self.selected;
        copy.appointmentLength = self.appointmentLength;
        copy.useHygienist = self.useHygienist;
        copy.notBillInsurance = self.notBillInsurance;
        copy.taxable = self.taxable;
        copy.system = self.system;
        copy.needPreApproval = self.needPreApproval;
        copy.beforeClinicNote = [self.beforeClinicNote copy];
        copy.afterClinicNote = [self.afterClinicNote copy];
        copy.beforeConsentForm = [self.beforeConsentForm copy];
        copy.afterConsentForm = [self.afterConsentForm copy];
        copy.beforePostOperation = [self.beforePostOperation copy];
        copy.afterPostOperation = [self.afterPostOperation copy];
        copy.beforeLabOrder = [self.beforeLabOrder copy];
        copy.afterLabOrder = [self.afterLabOrder copy];
        copy.hasMultiCodes = self.hasMultiCodes;

    }

    return copy;
}

- (TreatmentAreaType)areaType {
    return (TreatmentAreaType) self.area.objectId.integerValue;
}


- (SelectItem *)toSelectItem {
    SelectItem *selectItem = [[SelectItem alloc] init];
    selectItem.objectId = self.objectId;
    selectItem.code = self.code;
    selectItem.descrip = self.descrip;
    selectItem.name = self.name;
    return selectItem;
}

@end