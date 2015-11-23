//
// Created by Sanch0 on 5/23/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseToothConditionState.h"


@implementation BaseToothConditionState {

}

+ (UIColor *)colorByType:(ToothConditionEntityType)type {
    UIColor *color = nil;
    if (type == ToothConditionTypeDiagnosis) {
        color = [UIColor yellowColor];
    } else if (type == ToothConditionTypeTreatmentPlanned) {
        color = [UIColor redColor];
    } else if (type == ToothConditionTypeExistingTreatment) {
        color = [UIColor blueColor];
    } else if (type = ToothConditionTypeTreatmentCompleted) {
        color = [UIColor greenColor];
    }
    return color;
}
@end