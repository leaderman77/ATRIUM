//
// Created by Sanch0 on 3/11/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "Prescription.h"
#import "Medication.h"
#import "PrescriptionTemplateSubstitution.h"


@implementation Prescription {

}
- (BOOL)isValid {
    if (self.medicationCategory.objectId.integerValue == 0) {
        ALERT(TRANSLATE(@"Please, choose Drug category."));
        return NO;
    }
    if (self.medication.objectId.integerValue == 0) {
        ALERT(TRANSLATE(@"Please, choose Drug."));
        return NO;
    }
    if (self.strengthUnit.objectId.integerValue == 0) {
        ALERT(TRANSLATE(@"Please, choose Strength unit."));
        return NO;
    }

    if (self.amount.floatValue == 0) {
        ALERT(TRANSLATE(@"Please, enter amount."));
        return NO;
    }
    if (self.amountUnit.objectId.integerValue == 0) {
        ALERT(TRANSLATE(@"Please, choose Amount unit."));
        return NO;
    }
    if (self.rout.objectId.integerValue == 0) {
        ALERT(TRANSLATE(@"Please, choose Rout."));
        return NO;
    }
    if (self.routFrequency.objectId.integerValue == 0) {
        ALERT(TRANSLATE(@"Please, choose Frequency."));
        return NO;
    }
    if (self.dispense.floatValue == 0) {
        ALERT(TRANSLATE(@"Please, enter dispense."));
        return NO;
    }
    if (self.dispenseMedicationUnit.objectId.integerValue == 0) {
        ALERT(TRANSLATE(@"Please, choose Dispense unit."));
        return NO;
    }

    if (self.expirationDate.floatValue == 0) {
        ALERT(TRANSLATE(@"Please, enter expiration date."));
        return NO;
    }


    /* if (self.amount.floatValue == 0 || self.dispense.floatValue == 0 || self.expirationDate.longLongValue == 0) {
         return NO;
     }
     if (self.medication.objectId.integerValue == 0 || self.medicationCategory.objectId.integerValue == 0 || self.strengthUnit.objectId.integerValue == 0
             || self.amountUnit.objectId.integerValue == 0 || self.rout.objectId.integerValue == 0 || self.routFrequency.objectId.integerValue == 0
             || self.dispenseMedicationUnit.objectId.integerValue == 0) {
         return NO;
     }*/

    [self.substitutions removeAllObjects];
    if (self.genericSubstitution) {
        [self.substitutions addObjectsFromArray:self.substitutionEditItems];
    }

    return YES;
}

- (NSMutableArray <PrescriptionTemplateSubstitution> *)substitutions {
    if (!_substitutions) {
        _substitutions = (id) [NSMutableArray new];
    }
    return _substitutions;
}

- (NSMutableArray <Ignore> *)substitutionEditItems {
    if (!_substitutionEditItems) {
        _substitutionEditItems = [NSMutableArray new];
    }
    return _substitutionEditItems;
}


- (void)setMedicationItem:(Medication <Ignore> *)medicationItem {
    _medicationItem = medicationItem;
    [self.substitutionEditItems removeAllObjects];
    [_medicationItem.substitutes enumerateObjectsUsingBlock:^(SelectItem *obj, NSUInteger idx, BOOL *stop) {
        PrescriptionTemplateSubstitution *templateSubstitution = [[PrescriptionTemplateSubstitution alloc] init];
        templateSubstitution.objectId = obj.objectId;
        templateSubstitution.substitutionName = obj.name;
        templateSubstitution.medication = [[SelectItem alloc] initWithId:_medicationItem.objectId withName:_medicationItem.name];
        [self.substitutionEditItems addObject:templateSubstitution];
    }];
}


@end