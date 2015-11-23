//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DentalTransaction.h"


@implementation DentalTransaction {

}

NSString *const PLANNED = @"PLANNED";

- (NSDate <Ignore> *)createdDateLocal {
    if (_createdDateLocal == nil) {
        _createdDateLocal = [NSDate dateFromServerDateLong:self.createdDate];
    }
    return _createdDateLocal;
}

+ (SelectItem *)selectItemTransactionType:(TransactionType)transactionType {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:@(transactionType) withName:nil];
    switch (transactionType) {
        case DiagnosisTransactionType :
            selectItem.code = DIAGNOSIS_TRANSACTION_TYPE_CODE;
            break;
        case TreatmentTransactionType :
            selectItem.code = TREATMENT_TRANSACTION_TYPE_CODE;
            break;
        case ExistingTransactionType :
            selectItem.code = EXISTING_TRANSACTION_TYPE_CODE;
            break;
        case ProductsTransactionType :
            selectItem.code = PRODUCT_TRANSACTION_TYPE_CODE;
            break;
        default:
            break;
    }
    return selectItem;
}

+ (SelectItem *)selectItemStatus:(DentalTransactionStatusType)dentalTransactionStatusType {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:@(dentalTransactionStatusType) withName:nil];
    switch (dentalTransactionStatusType) {
        case kPlannedDentalTransactionStatus :
            selectItem.code = PLANNED_TRANSACTION_STATUS_CODE;
            break;
        case kCancelledDentalTransactionStatus :
            selectItem.code = CANCELED_TRANSACTION_STATUS_CODE;
            break;
        case kCompletedDentalTransactionStatus :
            selectItem.code = COMPLETED_TRANSACTION_STATUS_CODE;
            break;
    }
    return selectItem;
}

+ (SelectItem *)selectItemTreatmentAreaType:(TreatmentAreaType)treatmentAreaType {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:@(treatmentAreaType) withName:nil];
    switch (treatmentAreaType) {
        case kSurfaceTreatmentAreaType :
            selectItem.code = SURFACE_TREATMENT_AREA_CODE;
            break;
        case kToothTreatmentAreaType :
            selectItem.code = TOOTH_TREATMENT_AREA_CODE;
            break;
        case kRootTreatmentAreaType :
            selectItem.code = ROOT_TREATMENT_AREA_CODE;
            break;
        case kMouthTreatmentAreaType :
            selectItem.code = MOUTH_TREATMENT_AREA_CODE;
            break;
        case kQuadrantTreatmentAreaType :
            selectItem.code = QUADRANT_TREATMENT_AREA_CODE;
            break;
        case kSextantTreatmentAreaType :
            selectItem.code = SEXTANT_TREATMENT_AREA_CODE;
            break;
        case kTreatmentAreaTypeNone:
            break;
    }
    return selectItem;
}

+ (SelectItem *)selectItemWithTreatmentArea:(TreatmentAreaType)treatmentAreaType withEnum:(NSInteger)enumType {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:nil withName:nil];
    switch (treatmentAreaType) {
        case kSurfaceTreatmentAreaType : {
            switch (enumType) {
                case FacialSurfaceType:
                    selectItem.code = @"F";
                    break;
                case MesialSurfaceType:
                    selectItem.code = @"M";
                    break;
                case LingualSurfaceType:
                    selectItem.code = @"L";
                    break;
                case DistalSurfaceType:
                    selectItem.code = @"D";
                    break;
                case OclusalSurfaceType:
                    selectItem.code = @"O";
                    break;
                case IncisalSurfaceType:
                    selectItem.code = @"I";
                    break;
                case kTreatmentAreaTypeNone:
                    break;
            }
        };
            break;
        case kToothTreatmentAreaType : {

        };

            break;
        case kRootTreatmentAreaType :

            break;
        case kMouthTreatmentAreaType : {
            if (enumType == kUpperMouthType) {
                selectItem.objectId = @(kUpperMouthType);
                selectItem.code = @"Upper";
            } else if (enumType == kLowerMouthType) {
                selectItem.objectId = @(kLowerMouthType);
                selectItem.code = @"Lower";
            }

        };
            break;
        case kQuadrantTreatmentAreaType : {
            switch (enumType) {
                case kUpperRightQuadrantType:
                    selectItem.code = @"UpperRight";
                    break;
                case kUpperLeftQuadrantType:
                    selectItem.code = @"UpperLeft";
                    break;
                case kLowerRightQuadrantType:
                    selectItem.code = @"LowerRight";
                    break;
                case kLowerLeftQuadrantType:
                    selectItem.code = @"LowerLeft";
                    break;

            }
            selectItem.objectId = @(enumType);
        };


            break;
        case kSextantTreatmentAreaType : {
            switch (enumType) {
                case kSextant1:
                    selectItem.code = @"Sextant1";
                    break;
                case kSextant2:
                    selectItem.code = @"Sextant2";
                    break;
                case kSextant3:
                    selectItem.code = @"Sextant3";
                    break;
                case kSextant4:
                    selectItem.code = @"Sextant4";
                    break;
                case kSextant5:
                    selectItem.code = @"Sextant5";
                    break;
                case kSextant6:
                    selectItem.code = @"Sextant6";
                    break;

            }
            selectItem.objectId = @(enumType);
        };
            break;
        default:
            break;
    }
    return selectItem;
}


@end