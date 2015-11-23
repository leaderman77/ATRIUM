//
//  DentalTransactionBaseItem.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DentalTransactionBaseItem.h"
#import "ToothDetailsType.h"

@implementation DentalTransactionBaseItem


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
        case TreatmentCompletedTransactionType:
        case DiagnosisCompletedTransactionType:
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
    SelectItem *selectItem = [[SelectItem alloc] initWithId:@(enumType) withName:nil];
    switch (treatmentAreaType) {
        case kSurfaceTreatmentAreaType : {
            switch (enumType) {
                case FacialSurfaceType:
                    selectItem.code = @"F";
                    selectItem.name = TRANSLATE(@"Facial");
                    break;
                case MesialSurfaceType:
                    selectItem.code = @"M";
                    selectItem.name = TRANSLATE(@"Mesial");
                    break;
                case LingualSurfaceType:
                    selectItem.code = @"L";
                    selectItem.name = TRANSLATE(@"Lingual");
                    break;
                case DistalSurfaceType:
                    selectItem.code = @"D";
                    selectItem.name = TRANSLATE(@"Distal");
                    break;
                case OclusalSurfaceType:
                    selectItem.code = @"O";
                    selectItem.name = TRANSLATE(@"Oclusal");
                    break;
                case IncisalSurfaceType:
                    selectItem.code = @"I";
                    selectItem.name = TRANSLATE(@"Incisal");
                    break;
                case BuccalSurfaceType:
                    selectItem.code = @"B";
                    selectItem.name = TRANSLATE(@"Buccal");
                    break;
                case LingualFiveSurfaceType:
                    selectItem.code = @"L5";
                    selectItem.name = @"";
                    break;
                case FacialFiveSurfaceType:
                    selectItem.code = @"F5";
                    selectItem.name = @"";
                    break;
                case BuccalFiveSurfaceType:
                    selectItem.code = @"B5";
                    selectItem.name = @"";
                    break;
            }
        };
            break;
        case kToothTreatmentAreaType : {
            switch (enumType) {
                case kBicuspidToothType:
                    selectItem.code = @"Bicuspid";
                    break;
                case kCuspidToothType:
                    selectItem.code = @"Cuspid";
                    break;
                case kLateralToothType:
                    selectItem.code = @"Lateral";
                    break;
                case kCentralToothType:
                    selectItem.code = @"Central";
                    break;
                case kMolarToothType:
                    selectItem.code = @"Molar";
                    break;
            }
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

- (NSString <Ignore> *)areaDetailsStr {
    if (!_areaDetailsStr) {
        if ([self.area.code isEqualToString:TOOTH_TREATMENT_AREA_CODE] || [self.area.code isEqualToString:ROOT_TREATMENT_AREA_CODE]) {
            ToothDetailsType *toothDetailsType = [[ToothDetailsType sharedInstance] toothDetailsWithCode:self.tooth.code];
            _areaDetailsStr = toothDetailsType.numeric;
        } else if ([self.area.code isEqualToString:SURFACE_TREATMENT_AREA_CODE]) {
            __block NSMutableString *areaCodes = [[NSMutableString alloc] init];
            __block BOOL isFiveSurfaceExist = NO;
            [self.areaDetails enumerateObjectsUsingBlock:^(SelectItem *obj, NSUInteger idx, BOOL *stop) {
                if (obj.code.length > 0 && ![areaCodes containsString:obj.code]) {
                    if (isFiveSurfaceExist) {
                        if (![areaCodes containsString:[obj.code substringToIndex:1]]) {
                            [areaCodes insertString:[obj.code substringToIndex:1] atIndex:areaCodes.length - 2];
                        }
                    } else {
                        NSString *code = obj.code;
                        if (obj.code.length > 1) {
                            code = [obj.code substringToIndex:1];
                            if (![areaCodes containsString:code]) {
                                [areaCodes appendString:code];
                            }
                            code = [obj.code substringFromIndex:1];
                        }
                        [areaCodes appendString:code];
                        if ([obj.code isEqualToString:@"F5"] || [obj.code isEqualToString:@"L5"] || [obj.code isEqualToString:@"B5"]) {
                            isFiveSurfaceExist = YES;
                        }
                    }
                }
            }];
            _areaDetailsStr = areaCodes;
        } else if ([self.area.code isEqualToString:SEXTANT_TREATMENT_AREA_CODE]){
            NSArray *areaDetailCodes = [self.areaDetails valueForKeyPath:@"objectId"];
            _areaDetailsStr = @"";
            for (NSNumber *item in areaDetailCodes) {
                _areaDetailsStr = [NSString stringWithFormat:@"%@%@S%d", _areaDetailsStr, _areaDetailsStr.length ? @", ": @"", [item integerValue]];
            }
        } else if ([self.area.code isEqualToString:QUADRANT_TREATMENT_AREA_CODE]){
            NSArray *areaDetailCodes = [self.areaDetails valueForKeyPath:@"code"];
            _areaDetailsStr = @"";
            NSString *shortName;
            for (NSString *code in areaDetailCodes) {
                if([code isEqualToString:@"UpperRight"]) {
                    shortName = @"UR";
                } else if([code isEqualToString:@"UpperLeft"]) {
                    shortName = @"UL";
                } else if([code isEqualToString:@"LowerRight"]) {
                    shortName = @"LR";
                } else if([code isEqualToString:@"LowerLeft"]) {
                    shortName = @"LL";
                } else {
                    shortName = code;
                }
                _areaDetailsStr = [NSString stringWithFormat:@"%@%@%@", _areaDetailsStr, _areaDetailsStr.length ? @", ": @"", shortName];
            }
        } else {
            NSArray *areaDetailNames = [self.areaDetails valueForKeyPath:@"name"];
            _areaDetailsStr = areaDetailNames ? [areaDetailNames componentsJoinedByString:@", "] : @"";
        }
    }
    return _areaDetailsStr;
}

- (NSString <Ignore> *)toothNumberStr {
    if (!_toothNumberStr) {
        ToothDetailsType *toothDetailsType = [[ToothDetailsType sharedInstance] toothDetailsWithCode:self.tooth.code];
        _toothNumberStr = toothDetailsType.numeric;

    }
    return _toothNumberStr;
}


- (NSString *)getAreaDetailsCodesSeparated {
    NSString *codes = (self.areaDetails.count) ? @"|" : @"";
//    if(self.treatmentItem.co)
    for (SelectItem *item in self.areaDetails) {
        codes = [codes stringByAppendingFormat:@"%@|", item.name];
    }
    return codes;
}

- (NSString *)getAreaDetailsNames {
    NSMutableString *codes = [[NSMutableString alloc] init];
    if ([self.area.code isEqualToString:TOOTH_TREATMENT_AREA_CODE]) {
        for (SelectItem *item in self.areaDetails) {
            if (codes.length) {
                [codes appendFormat:@" ,%@", item.code];
//                codes = [codes stringByAppendingFormat:@"%@,", item.code];
            } else {
//                codes = item.code;
                [codes appendString:item.code];
            }
        }
    } else if ([self.area.code isEqualToString:SURFACE_TREATMENT_AREA_CODE]) {
        for (SelectItem *item in self.areaDetails) {
            if (codes.length) {
                [codes appendFormat:@" ,%@", item.code];
//                codes = [codes stringByAppendingFormat:@"%@,", item.code];
            } else {
//                codes = item.code;
            }
        }
    } else {
        for (SelectItem *item in self.areaDetails) {
            if (codes.length) {
                [codes appendFormat:@" ,%@", item.name];
//                codes = [codes stringByAppendingFormat:@"%@,", item.name];
            } else {
//                codes = item.name;
                [codes appendString:item.name];
            }
        }
    }

    return codes;
}

+ (TreatmentAreaType)transactionAreaTypeWithCode:(NSString *)code {
    TreatmentAreaType treatmentAreaType = kTreatmentAreaTypeNone;
    if ([code isEqualToString:SURFACE_TREATMENT_AREA_CODE]) {
        treatmentAreaType = kSurfaceTreatmentAreaType;
    } else if ([code isEqualToString:TOOTH_TREATMENT_AREA_CODE]) {
        treatmentAreaType = kToothTreatmentAreaType;
    } else if ([code isEqualToString:ROOT_TREATMENT_AREA_CODE]) {
        treatmentAreaType = kRootTreatmentAreaType;
    } else if ([code isEqualToString:MOUTH_TREATMENT_AREA_CODE]) {
        treatmentAreaType = kMouthTreatmentAreaType;
    } else if ([code isEqualToString:QUADRANT_TREATMENT_AREA_CODE]) {
        treatmentAreaType = kQuadrantTreatmentAreaType;
    } else if ([code isEqualToString:SEXTANT_TREATMENT_AREA_CODE]) {
        treatmentAreaType = kSextantTreatmentAreaType;
    }
    return treatmentAreaType;
}


@end
