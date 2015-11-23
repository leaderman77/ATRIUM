//
// Created by Sanch0 on 7/13/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientToothChangeConditions.h"


@implementation PatientToothChangeConditions {

}

- (UIImage *)conditionImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    ToothConditionEntityType type = ToothConditionTypeNone;
    if (self.treatment.objectId.integerValue > 0) {
        type = ToothConditionTypeTreatmentPlanned;
    } else if (self.diagnosisCode.objectId.integerValue > 0) {
        type = ToothConditionTypeDiagnosis;
    } else if (self.existingTreatment.objectId.integerValue > 0) {
        type = ToothConditionTypeExistingTreatment;
    }

    return [[SettingsManager sharedManager] conditionImage:image withType:type];
}

- (UIColor *)conditionColor {
    ToothConditionEntityType type = ToothConditionTypeNone;
    if (self.treatment.objectId.integerValue > 0) {
        type = ToothConditionTypeTreatmentPlanned;
    } else if (self.diagnosisCode.objectId.integerValue > 0) {
        type = ToothConditionTypeDiagnosis;
    } else if (self.existingTreatment.objectId.integerValue > 0) {
        type = ToothConditionTypeExistingTreatment;
    }
    return [BaseToothConditionState colorByType:type];
}


@end