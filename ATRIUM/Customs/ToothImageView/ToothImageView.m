//
// Created by Sanch0 on 4/21/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ToothImageView.h"
#import "ToothConditionLayer.h"
#import "PatientToothConditions.h"
#import "ToothConditionsEnums.h"
#import "ToothDetailsType.h"
#import "CALayer+Additions.h"
#import "PatientToothConditionWithChanges.h"
#import "PatientToothChangeConditions.h"
#import "OrderedDictionary.h"


@implementation ToothImageView {
    OrderedDictionary *_toothConditionsLayers;
    NSString *distalStr, *facialStr, *buccalStr, *mesialStr, *lingualStr, *oclusalStr, *incisalStr, *facial5Str, *buccal5Str, *lingual5Str;
}

@synthesize toothConditionsLayers = _toothConditionsLayers;

- (void)setIsSurfaceView:(BOOL)isSurfaceView {
    _isSurfaceView = isSurfaceView;
    self.arrow.top = (_isSurfaceView) ? -self.arrow.top : self.width + self.arrow.height;

}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
        _arrow.layer.borderWidth = 1.f;
        _arrow.layer.borderColor = [UIColor redColor].CGColor;
//        [self addSubview:_arrow];
    }
    return _arrow;
}


- (void)removeAllConditions {
    [self.layer.sublayers enumerateObjectsUsingBlock:^(ToothConditionLayer *caLayer, NSUInteger idx, BOOL *stop) {
        if ([caLayer isKindOfClass:[ToothConditionLayer class]]) {
            [caLayer removeFromSuperlayer];
        }
    }];
    [self.toothConditionsLayers removeAllObjects];
}

- (void)removeAllToothConditions {
    [self.toothConditionsLayers enumerateObjectsUsingBlock:^(ToothConditionLayer *caLayer, NSUInteger idx, BOOL *stop) {
        if ([caLayer isKindOfClass:[ToothConditionLayer class]]) {
            [caLayer removeFromSuperlayer];
        }
    }];
    [self.toothConditionsLayers removeAllObjects];
}

- (OrderedDictionary *)toothConditionsLayers {
    if (_toothConditionsLayers == nil) {
        _toothConditionsLayers = [[OrderedDictionary alloc] init];
    }
    return _toothConditionsLayers;
}

- (void)configureSurfaceImageNumberCodes {
    NSInteger toothPosition = [[_toothConditionWithChanges.toothPositionCode substringFromIndex:1] integerValue];
    //1 - left
    //2 - top
    //3 - right
    //4 - bottom
    //5 - center

    facialStr = facial5Str = lingualStr = lingual5Str = buccalStr = buccal5Str = oclusalStr = incisalStr = mesialStr = distalStr = nil;

    if (self.isSurfaceView) {
        if (toothPosition >= 1 && toothPosition <= 5) {
            buccalStr = @"2";
            mesialStr = @"3";
            distalStr = @"1";
            oclusalStr = @"5";
            lingualStr = @"4";

        } else if (toothPosition >= 6 && toothPosition <= 11) {
            facialStr = @"2";
            if (toothPosition <= 8) {
                mesialStr = @"3";
                distalStr = @"1";
            } else {
                distalStr = @"3";
                mesialStr = @"1";
            }
            incisalStr = @"5";
            lingualStr = @"4";

        } else if (toothPosition >= 12 && toothPosition <= 16) {
            buccalStr = @"2";
            mesialStr = @"1";
            distalStr = @"3";
            oclusalStr = @"5";
            lingualStr = @"4";

        } else if (toothPosition >= 28 && toothPosition <= 32) {
            lingualStr = @"2";
            mesialStr = @"3";
            distalStr = @"1";
            oclusalStr = @"5";
            buccalStr = @"4";

        } else if (toothPosition >= 22 && toothPosition <= 27) {
            lingualStr = @"2";
            if (toothPosition >= 25) {
                mesialStr = @"3";
                distalStr = @"1";
            } else {
                mesialStr = @"1";
                distalStr = @"3";
            }
            incisalStr = @"5";
            facialStr = @"4";

        } else if (toothPosition >= 17 && toothPosition <= 21) {
            lingualStr = @"2";
            distalStr = @"3";
            mesialStr = @"1";
            oclusalStr = @"5";
            buccalStr = @"4";
        }
    } else {
        if (toothPosition >= 1 && toothPosition <= 5) {
            buccalStr = @"5";
            mesialStr = @"3";
            distalStr = @"1";
            oclusalStr = @"4";
            buccal5Str = @"2";

        } else if (toothPosition >= 6 && toothPosition <= 11) {
            facialStr = @"5";
            if (toothPosition <= 8) {
                mesialStr = @"3";
                distalStr = @"1";
            } else {
                distalStr = @"3";
                mesialStr = @"1";
            }
            incisalStr = @"4";
            facial5Str = @"2";

        } else if (toothPosition >= 12 && toothPosition <= 16) {
            buccalStr = @"5";
            mesialStr = @"1";
            distalStr = @"3";
            oclusalStr = @"4";
            buccal5Str = @"2";

        } else if (toothPosition >= 28 && toothPosition <= 32) {
            buccalStr = @"5";
            mesialStr = @"3";
            distalStr = @"1";
            oclusalStr = @"2";
            buccal5Str = @"4";

        } else if (toothPosition >= 22 && toothPosition <= 27) {
            facialStr = @"5";
            if (toothPosition >= 25) {
                mesialStr = @"3";
                distalStr = @"1";
            } else {
                mesialStr = @"1";
                distalStr = @"3";
            }
            incisalStr = @"2";
            facial5Str = @"4";

        } else if (toothPosition >= 17 && toothPosition <= 21) {
            buccalStr = @"5";
            distalStr = @"3";
            mesialStr = @"1";
            oclusalStr = @"2";
            buccal5Str = @"4";
        }
    }


}

- (void)setToothConditionWithChanges:(PatientToothConditionWithChanges *)toothConditionWithChanges {
    _toothConditionWithChanges = toothConditionWithChanges;
    _toothConditions = toothConditionWithChanges.toothConditions;
    [self removeAllToothConditions];
    [self configureSurfaceImageNumberCodes];

    [_toothConditionWithChanges.toothChangeConditions sortUsingComparator:^NSComparisonResult(PatientToothChangeConditions *obj1, PatientToothChangeConditions *obj2) {
        if (obj1.treatment.objectId || obj1.existingTreatment.objectId) {
            return obj2.diagnosisCode
                    ? NSOrderedDescending
                    : [obj1.createdDate compare:obj2.createdDate];
        } else if (obj1.diagnosisCode) {
            return obj2.diagnosisCode
                    ? [obj1.createdDate compare:obj2.createdDate]
                    : (obj2.treatment || obj2.existingTreatment)
                            ? NSOrderedAscending
                            : [obj1.createdDate compare:obj2.createdDate];
        } else {
            return [obj1.createdDate compare:obj2.createdDate];
        }
    }];

    if (self.isSurfaceView) {
        [self populateWithSurfaceViewToothConditions];
        [_toothConditionWithChanges.toothChangeConditions enumerateObjectsUsingBlock:^(PatientToothChangeConditions *obj, NSUInteger idx, BOOL *stop) {
            if (!obj.revert) {
                [self populateSurfaceWithChangeConditions:obj];
            }
        }];
    } else {
        [self populateWithMainToothConditions];
        [_toothConditionWithChanges.toothChangeConditions enumerateObjectsUsingBlock:^(PatientToothChangeConditions *obj, NSUInteger idx, BOOL *stop) {
            if (!obj.revert) {
                [self populateMainToothWithChangeConditions:obj];
            }
        }];
    }
}

- (void)populateWithSurfaceViewToothConditions {
    NSInteger toothPosition = [[_toothConditionWithChanges.toothPositionCode substringFromIndex:1] integerValue];
    BOOL isUp = toothPosition >= 1 && toothPosition <= 16;
    NSString *toothImageNumberName = _toothConditionWithChanges.toothConditions.tooth.name
            ? [[ToothDetailsType sharedInstance] imageNameWithCode:_toothConditionWithChanges.toothConditions.tooth.name]
            : [[ToothDetailsType sharedInstance] imageNameWithPositionCode:_toothConditionWithChanges.toothConditions.toothPosition.code];

    [self configureToothStatus:_toothConditions toothImageNumberName:toothImageNumberName];
    [self configureShiftY:_toothConditions isUp:isUp];
    [self configureTurn:_toothConditions isUp:isUp];
    [self configureFractureCrownRoot:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureCrowns:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureDecay:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureMetallicRestoration:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureNonMetallicRestoration:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureAmalgam:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureProvisionalRestoration:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];

    [self configureBanding:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureFissureSealant:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];

}

- (void)populateWithMainToothConditions {
    NSInteger toothPosition = [[_toothConditionWithChanges.toothPositionCode substringFromIndex:1] integerValue];
    BOOL isUp = toothPosition >= 1 && toothPosition <= 16;
    NSString *toothImageNumberName = _toothConditionWithChanges.toothConditions.tooth.name
            ? [[ToothDetailsType sharedInstance] imageNameWithCode:_toothConditionWithChanges.toothConditions.tooth.name]
            : [[ToothDetailsType sharedInstance] imageNameWithPositionCode:_toothConditionWithChanges.toothConditions.toothPosition.code];

    [self configureToothStatus:_toothConditions toothImageNumberName:toothImageNumberName];
    [self configureCalculusGrade:_toothConditions toothImageNumberName:toothImageNumberName isUpPosition:isUp];
    [self configureFurcationGrade:_toothConditions isUpPosition:isUp];
    [self configureMobilityGrade:_toothConditions isUpPosition:isUp];
    [self configureShiftX:_toothConditions isUp:isUp];
    [self configureShiftZ:_toothConditions isUp:isUp];
    [self configureToothAche:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];

    [self configureFractureCrownRoot:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureCrowns:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureDecay:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureMetallicRestoration:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureNonMetallicRestoration:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureAmalgam:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureProvisionalRestoration:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];

    [self configureVeneer:_toothConditions isUp:isUp];
    [self configureResidualRoot:_toothConditions toothImageNumberName:toothImageNumberName];
    [self configureOcclusalReduction:_toothConditions toothImageNumberName:toothImageNumberName isUp:isUp];

}

- (void)populateSurfaceWithChangeConditions:(PatientToothChangeConditions *)changeConditions {
    NSInteger toothPosition = [[_toothConditionWithChanges.toothPositionCode substringFromIndex:1] integerValue];
    BOOL isUp = toothPosition >= 1 && toothPosition <= 16;
    NSString *toothImageNumberName = _toothConditionWithChanges.toothConditions.tooth.name
            ? [[ToothDetailsType sharedInstance] imageNameWithCode:_toothConditionWithChanges.toothConditions.tooth.name]
            : [[ToothDetailsType sharedInstance] imageNameWithPositionCode:_toothConditionWithChanges.toothConditions.toothPosition.code];

    [self configureToothStatus:changeConditions toothImageNumberName:toothImageNumberName];
    [self configureShiftY:changeConditions isUp:isUp];
    [self configureTurn:changeConditions isUp:isUp];
    [self configureFractureCrownRoot:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureCrowns:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureDecay:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureMetallicRestoration:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureNonMetallicRestoration:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureAmalgam:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureProvisionalRestoration:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureFissureSealant:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureBanding:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureFissureSealant:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];

    /*//CROWNS
    if (changeConditions.metalCeramicCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metal_ceramic_%@_%@", upperLowerString, toothImageNumberName];
        ToothConditionLayer *layer = [ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        [self addToothConditionsLayer:layer];
    }
    if (changeConditions.metalFreeCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metal_free_crown_%@_%@", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }

    if (changeConditions.metallicCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_crown_%@_%@", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.temporalCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"temporary_crown_%@_%@", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }

    //FRACTURE
    if (changeConditions.fractureCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"fracture_%@_%@", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self withLayerPosition:layerPosition]];
    }

    //DECAYS
    if (changeConditions.decay_Distal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_1", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.decay_Facial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_2", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.decay_Mesial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_3", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.decay_Lingual.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_4", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.decay_Oclusal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_5", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }

    //METALLIC RESTORATION
    if (changeConditions.metallicRestoration_Distal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_1", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.metallicRestoration_Facial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_2", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.metallicRestoration_Mesial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_3", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.metallicRestoration_Lingual.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_4", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.metallicRestoration_Oclusal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_5", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }

    //NOMETALLIC RESTORATION
    if (changeConditions.nonMetallicRestoration_Distal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_1", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.nonMetallicRestoration_Facial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_2", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.nonMetallicRestoration_Mesial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_3", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.nonMetallicRestoration_Lingual.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_4", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.nonMetallicRestoration_Oclusal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_5", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }

    //OPTION AMALGAM
    if (changeConditions.amalgam_Distal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_1", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.amalgam_Facial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_2", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.amalgam_Mesial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_3", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.amalgam_Lingual.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_4", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.amalgam_Oclusal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_5", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }

    //OPTION AMALGAM
    if (changeConditions.provisionalRestoration_Distal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_1", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.provisionalRestoration_Facial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_2", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.provisionalRestoration_Mesial.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_3", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.provisionalRestoration_Lingual.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_4", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }
    if (changeConditions.provisionalRestoration_Oclusal.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_5", upperLowerString, toothImageNumberName];
        [self addToothConditionsLayer:[ToothConditionLayer toothConditionLayerWithImage:[changeConditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition]];
    }*/
}

- (void)populateMainToothWithChangeConditions:(PatientToothChangeConditions *)changeConditions {
    NSInteger toothPosition = [[_toothConditionWithChanges.toothPositionCode substringFromIndex:1] integerValue];
    BOOL isUp = toothPosition >= 1 && toothPosition <= 16;
    NSString *toothImageNumberName = _toothConditionWithChanges.toothConditions.tooth.name
            ? [[ToothDetailsType sharedInstance] imageNameWithCode:_toothConditionWithChanges.toothConditions.tooth.name]
            : [[ToothDetailsType sharedInstance] imageNameWithPositionCode:_toothConditionWithChanges.toothConditions.toothPosition.code];

    LayerPosition layerPosition = (isUp) ? LayerPositionBottom : LayerPositionTop;
    NSString *upperLowerString = (isUp) ? @"upper" : @"lower";
    upperLowerString = @"lower";
    [self configureToothStatus:changeConditions toothImageNumberName:toothImageNumberName];
    [self configureCalculusGrade:changeConditions toothImageNumberName:toothImageNumberName isUpPosition:isUp];
    [self configureFurcationGrade:changeConditions isUpPosition:isUp];
    [self configureMobilityGrade:changeConditions isUpPosition:isUp];
    [self configureShiftX:changeConditions isUp:isUp];
    [self configureShiftZ:changeConditions isUp:isUp];
    [self configureToothAche:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];

    [self configureFractureCrownRoot:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureCrowns:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureDecay:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureMetallicRestoration:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureNonMetallicRestoration:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureAmalgam:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];
    [self configureProvisionalRestoration:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];

    [self configureVeneer:changeConditions isUp:isUp];
    [self configureResidualRoot:changeConditions toothImageNumberName:toothImageNumberName];
    [self configureOcclusalReduction:changeConditions toothImageNumberName:toothImageNumberName isUp:isUp];

}

- (void)configureTurn:(BaseToothConditionState *)condition isUp:(BOOL)isUp {


    if (condition.turn.code.length > 0) {
        NSString *code = condition.turn.code;
        NSString *imageName = nil;
        if ([code isEqualToString:TOOTHTURN_CLOCKWISE]) {
            imageName = @"arrow_curly_down_right";
        } else if ([code isEqualToString:TOOTHTURN_COUNTERCLOCKWISE]) {
            imageName = @"arrow_curly_down_left";
        }
        /*   if (!imageName) {
               if (toothPosition % 2 == 0) {
                   imageName = @"arrow_curly_down_right";
               } else {
                   imageName = @"arrow_curly_down_left";
               }
           }*/

        if (imageName) {
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self];
            conditionLayer.top = (isUp) ? -conditionLayer.height : 5;
            conditionLayer.conditionCode = TOOTH_CONDITION_TURN;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureShiftY:(BaseToothConditionState *)changeConditions isUp:(BOOL)isUp {
    //ARROWS
    if (changeConditions.shiftY.code.length > 0) {
        NSString *code = changeConditions.shiftY.code;
        NSString *imageName = nil;
        CGFloat top = 0.f;
        if ([code isEqualToString:TOOTHSHIFT_FACIALIZED]) {
            imageName = (isUp) ? @"arrow_up" : @"arrow_down";
        } else if ([code isEqualToString:TOOTHSHIFT_LINGUALIZED]) {
            imageName = (isUp) ? @"arrow_down" : @"arrow_up";
        }
        if (imageName) {
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self];
            conditionLayer.top = isUp ? -conditionLayer.height : 0;
            conditionLayer.conditionCode = TOOTH_CONDITION_SHIFT_Y;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureResidualRoot:(BaseToothConditionState *)changeConditions toothImageNumberName:(NSString *)toothImageNumberName {
//RESEDUAL ROOT

    if (changeConditions.residualRoot.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"resedual-root_%@", toothImageNumberName];
        self.image = [UIImage imageNamed:imageName];
        [self.toothConditionsLayers setObject:imageName forKey:TOOTH_CONDITION_RESIDUAL_ROOT];
    }
}

- (void)configureToothAche:(BaseToothConditionState *)changeConditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //TOOTH ACHE
    if (changeConditions.toothAche.code.length > 0) {
        NSString *code = changeConditions.toothAche.code;
        NSString *imageName = nil;
        if ([code isEqualIgnoreCase:TOOTH_ACHE_SENSITIVE]) {
            imageName = [[NSString alloc] initWithFormat:@"%@", @"tooth_ache_sensitive"];
        } else if ([code isEqualIgnoreCase:TOOTH_ACHE_PULPITIS]) {
            imageName = [[NSString alloc] initWithFormat:@"pulpitis_%@_1", toothImageNumberName];
        } else if ([code isEqualIgnoreCase:TOOTH_ACHE_ACUTE_PERIAPICAL]) {
            imageName = @"acute_periapical";
        } else if ([code isEqualIgnoreCase:TOOTH_ACHE_CHRONIC_PERIAPICAL]) {
            imageName = @"chronic_periapical";
        }
        if (imageName) {
            UIImage *conditionImage = [code isEqualIgnoreCase:TOOTH_ACHE_PULPITIS] ? [changeConditions conditionImageWithName:imageName] : [UIImage imageNamed:imageName];
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:conditionImage onView:self];
            if ([code isEqualIgnoreCase:TOOTH_ACHE_SENSITIVE]) {
                conditionLayer.top = (isUp) ? 150 : self.height - conditionLayer.height - 50;
            } else {
                conditionLayer.layerPosition = (isUp && ![code isEqualIgnoreCase:TOOTH_ACHE_PULPITIS]) ? LayerPositionTop : LayerPositionBottom;
            }
            conditionLayer.conditionCode = TOOTH_CONDITION_TOOTH_ACHE;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureShiftZ:(BaseToothConditionState *)changeConditions isUp:(BOOL)isUp {
    if (changeConditions.shiftZ.code.length > 0) {
        NSString *code = changeConditions.shiftZ.code;
        NSString *imageName = nil;
        if ([code isEqualToString:TOOTHSHIFT_INTRUDED]) {
            imageName = [[NSString alloc] initWithFormat:@"%@", (isUp) ? @"arrow_up" : @"arrow_down"];
        } else if ([code isEqualToString:TOOTHSHIFT_EXTRUDED]) {
            imageName = [[NSString alloc] initWithFormat:@"%@", (isUp) ? @"arrow_down" : @"arrow_up"];
        }
        if (imageName) {
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self];
            conditionLayer.top = isUp ? self.height : -conditionLayer.height;
            conditionLayer.conditionCode = TOOTH_CONDITION_SHIFT_Z;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureShiftX:(BaseToothConditionState *)changeConditions isUp:(BOOL)isUp {
//ARROWS
    if (changeConditions.shiftX.code.length > 0) {
        NSString *code = changeConditions.shiftX.code;
        NSString *imageName = nil;
        if ([code isEqualToString:TOOTHSHIFT_MESIALIZED]) {
            imageName = [[NSString alloc] initWithFormat:@"%@", @"arrow_right_condition"];
        } else if ([code isEqualToString:TOOTHSHIFT_DISTALIZED]) {
            imageName = [[NSString alloc] initWithFormat:@"%@", @"arrow_left_condition"];
        }

        if (imageName) {
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self];
            conditionLayer.top = (isUp) ? 0 : self.height - conditionLayer.height;
            conditionLayer.conditionCode = TOOTH_CONDITION_SHIFT_X;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureMobilityGrade:(BaseToothConditionState *)changeConditions isUpPosition:(BOOL)isUp {
//MOBILITY GRADE
    if (changeConditions.mobilityGrade.code.length > 0) {
        NSString *code = changeConditions.mobilityGrade.code;
        NSString *imageName = nil;
        NSString *upDownStr = isUp ? @"up" : @"down";
        if ([code isEqualToString:TOOTHGRADE_GRADE1]) {
            imageName = [[NSString alloc] initWithFormat:@"1_%@", upDownStr];
        } else if ([code isEqualToString:TOOTHGRADE_GRADE2]) {
            imageName = [[NSString alloc] initWithFormat:@"2_%@", upDownStr];
        } else if ([code isEqualToString:TOOTHGRADE_GRADE3]) {
            imageName = [[NSString alloc] initWithFormat:@"3_%@", upDownStr];
        }

        if (imageName.length > 0) {
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self];
//                conditionLayer.layerPosition = (isUp) ? LayerPositionBottom : LayerPositionTop;
            conditionLayer.top = 5;
            conditionLayer.conditionCode = TOOTH_CONDITION_MOBILITY_GRADE;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureFurcationGrade:(BaseToothConditionState *)changeConditions isUpPosition:(BOOL)isUp {
//FURCATION GRADE
    if (changeConditions.furcationGrade.code.length > 0) {
        NSString *code = changeConditions.furcationGrade.code;
        NSString *imageName = nil;
        if ([code isEqualToString:TOOTHGRADE_GRADE1]) {
            imageName = @"fucation-1";
        } else if ([code isEqualToString:TOOTHGRADE_GRADE2]) {
            imageName = @"fucation-2";
        } else if ([code isEqualToString:TOOTHGRADE_GRADE3]) {
            imageName = @"fucation-3";
        } else if ([code isEqualToString:TOOTHGRADE_GRADE4]) {
            imageName = @"fucation-4";
        }
        if (imageName.length > 0) {
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self];
            conditionLayer.top = (isUp) ? 50 : 50;
            conditionLayer.conditionCode = TOOTH_CONDITION_FURCATION_GRADE;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureCalculusGrade:(BaseToothConditionState *)changeConditions toothImageNumberName:(NSString *)toothImageNumberName isUpPosition:(BOOL)isUp {
//CALCULUS GRADE
    if (changeConditions.calculusGrade.code.length > 0) {
        NSString *code = changeConditions.calculusGrade.code;
        NSString *imageName = nil;
        if ([code isEqualToString:TOOTHGRADE_GRADE1]) {
            imageName = [[NSString alloc] initWithFormat:@"grade_1_%@_1", toothImageNumberName];
        } else if ([code isEqualToString:TOOTHGRADE_GRADE2]) {
            imageName = [[NSString alloc] initWithFormat:@"grade_2_%@_1", toothImageNumberName];
        } else if ([code isEqualToString:TOOTHGRADE_GRADE3]) {
            imageName = [[NSString alloc] initWithFormat:@"grade_3_%@_1", toothImageNumberName];
        }

        if (imageName.length > 0) {
            ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self];
            conditionLayer.layerPosition = (isUp) ? LayerPositionBottom : LayerPositionTop;
            conditionLayer.conditionCode = TOOTH_CONDITION_CALCULUS_GRADE;
            [self addToothConditionsLayer:conditionLayer];
        }
    }
}

- (void)configureToothStatus:(BaseToothConditionState *)changeConditions toothImageNumberName:(NSString *)toothImageNumberName {
//TOOTH STATUS
    if (changeConditions.toothStatus.code.length > 0) {
        NSString *code = changeConditions.toothStatus.code;
        NSString *imageName = nil;
        if (self.isSurfaceView) {
            if ([code isEqualToString:TOOTHSTATUS_ABSENT]) {
                imageName = @"";
            }
        } else {
            if ([code isEqualToString:TOOTHSTATUS_NORMAL]) {
//                imageName = [[NSString alloc] initWithFormat:@"%@_1", toothImageNumberName];
//                self.image = self.toothDetailsType.toothImage;
            } else if ([code isEqualToString:TOOTHSTATUS_IMPLANT]) {
                imageName = [[NSString alloc] initWithFormat:@"implants_%@", toothImageNumberName];
            } else if ([code isEqualToString:TOOTHSTATUS_ABSENT]) {
                imageName = @"absent_tooth";
            } else if ([code isEqualToString:TOOTHSTATUS_BRIDGE]) {
                imageName = [[NSString alloc] initWithFormat:@"%@", toothImageNumberName];
            }
        }
        if (imageName) {
            self.image = [code isEqualToString:TOOTHSTATUS_ABSENT] ? [changeConditions conditionImageWithName:imageName] : [UIImage imageNamed:imageName];
            [self.toothConditionsLayers setObject:imageName forKey:TOOTH_CONDITION_TOOTH_STATUS];

        }

    }
}

- (void)configureVeneer:(BaseToothConditionState *)conditions isUp:(BOOL)isUp {
    //Vaneer
    LayerPosition layerPosition = (isUp) ? LayerPositionTop : LayerPositionBottom;
    if (conditions.veneer.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"veneer_%@", isUp ? @"down" : @"up"];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self];
//        conditionLayer.top = (toothImageNumberName) ? 7 : -13;
        conditionLayer.top = isUp ? self.height : -conditionLayer.height;
        conditionLayer.conditionCode = TOOTH_CONDITION_VENEER;
        [self addToothConditionsLayer:conditionLayer];
    }

}


- (void)configureDecay:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //DECAYS + with color

    NSString *upperLowerString = self.isSurfaceView ? @"upper" : @"lower";
    LayerPosition layerPosition = self.isSurfaceView
            ? (isUp) ? LayerPositionTop : LayerPositionBottom
            : (isUp) ? LayerPositionBottom : LayerPositionTop;

    if (conditions.decay_Distal.boolValue && distalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, distalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_DISTAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.decay_Facial.boolValue && facialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, facialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_FACIAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Mesial.boolValue && mesialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, mesialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_MESIAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Facial5.boolValue && facial5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, facial5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_FACIAL5;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Oclusal.boolValue && oclusalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, oclusalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_OCLUSAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Incisal.boolValue && incisalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, incisalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_INCISAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Lingual.boolValue && lingualStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, lingualStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_LINGUAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Lingual5.boolValue && lingual5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, lingual5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_LINGUAL5;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Buccal.boolValue && buccalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, buccalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_BUCCAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.decay_Buccal5.boolValue && buccal5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"decay_%@_%@_%@", upperLowerString, toothImageNumberName, buccal5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_DECAY_BUCCAL5;
        [self addToothConditionsLayer:conditionLayer];

    }

}

- (void)configureProvisionalRestoration:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //provisional restoration + with colour
    NSString *upperLowerString = self.isSurfaceView ? @"upper" : @"lower";
    LayerPosition layerPosition = self.isSurfaceView
            ? (isUp) ? LayerPositionTop : LayerPositionBottom
            : (isUp) ? LayerPositionBottom : LayerPositionTop;

    if (conditions.provisionalRestoration_Distal.boolValue && distalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, distalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_DISTAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Facial.boolValue && facialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, facialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_FACIAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Mesial.boolValue && mesialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, mesialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_MESIAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Lingual.boolValue && lingualStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, lingualStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_LINGUAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Oclusal.boolValue && oclusalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, oclusalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_OCLUSAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Incisal.boolValue && incisalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, incisalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_INCISAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Facial5.boolValue && facial5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, facial5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_FACIAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Lingual5.boolValue && lingual5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, lingual5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_LINGUAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Buccal.boolValue && buccalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, buccalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_BUCCAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.provisionalRestoration_Buccal5.boolValue && buccal5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"provesional_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, buccal5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_PROVISIONAL_RESTORATION_BUCCAL5;
        [self addToothConditionsLayer:conditionLayer];
    }

}

- (void)configureAmalgam:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //OPTION AMALGAM    + with colour
    NSString *upperLowerString = self.isSurfaceView ? @"upper" : @"lower";
    LayerPosition layerPosition = self.isSurfaceView
            ? (isUp) ? LayerPositionTop : LayerPositionBottom
            : (isUp) ? LayerPositionBottom : LayerPositionTop;

    if (conditions.amalgam_Distal.boolValue && distalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_%@", upperLowerString, toothImageNumberName, distalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_DISTAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Facial.boolValue && facialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_2", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_FACIAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Facial5.boolValue && facial5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_2", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_FACIAL5;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Mesial.boolValue && mesialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_3", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_MESIAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.amalgam_Lingual.boolValue && lingualStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_4", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_LINGUAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Lingual5.boolValue && lingual5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_4", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_LINGUAL5;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Oclusal.boolValue && oclusalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_5", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_OCLUSAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Incisal.boolValue && incisalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_%@", upperLowerString, toothImageNumberName, incisalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_INCISAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Buccal.boolValue && buccalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_%@", upperLowerString, toothImageNumberName, buccalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_BUCCAL;
        [self addToothConditionsLayer:conditionLayer];

    }
    if (conditions.amalgam_Buccal5.boolValue && buccal5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"option_amalgam_%@_%@_%@", upperLowerString, toothImageNumberName, buccal5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_AMALGAM_BUCCAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
}

- (void)configureNonMetallicRestoration:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //NOMETALLIC RESTORATION + with colour
    NSString *upperLowerString = self.isSurfaceView ? @"upper" : @"lower";
    LayerPosition layerPosition = self.isSurfaceView
            ? (isUp) ? LayerPositionTop : LayerPositionBottom
            : (isUp) ? LayerPositionBottom : LayerPositionTop;

    if (conditions.nonMetallicRestoration_Distal.boolValue && distalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, distalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_DISTAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Facial.boolValue && facialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, facialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_FACIAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Facial5.boolValue && facial5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, facial5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_FACIAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Mesial.boolValue && mesialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, mesialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_MESIAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Lingual.boolValue && lingualStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, lingualStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_LINGUAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Lingual5.boolValue && lingual5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, lingual5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_LINGUAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Oclusal.boolValue && oclusalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, oclusalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_OCLUSAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Incisal.boolValue && incisalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, incisalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_INCISAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Buccal.boolValue && buccalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, buccalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_BUCCAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.nonMetallicRestoration_Buccal5.boolValue && buccal5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"nonmetallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, buccal5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_NONMETALLIC_RESTORATION_BUCCAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
}

- (void)configureMetallicRestoration:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //METALLIC RESTORATION + with color
    NSString *upperLowerString = self.isSurfaceView ? @"upper" : @"lower";
    LayerPosition layerPosition = self.isSurfaceView
            ? (isUp) ? LayerPositionTop : LayerPositionBottom
            : (isUp) ? LayerPositionBottom : LayerPositionTop;

    if (conditions.metallicRestoration_Distal.boolValue && distalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, distalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_DISTAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Facial.boolValue && facialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, facialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_FACIAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Facial5.boolValue && facial5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, facial5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_FACIAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Mesial.boolValue && mesialStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, mesialStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_MESIAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Lingual.boolValue && lingualStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, lingualStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_LINGUAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Lingual5.boolValue && lingual5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, lingual5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_LINGUAL5;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Oclusal.boolValue && oclusalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, oclusalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_OCLUSAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Incisal.boolValue && incisalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, incisalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_INCISAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Buccal.boolValue && buccalStr.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, buccalStr];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_BUCCAL;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metallicRestoration_Buccal5.boolValue && buccal5Str.length > 0) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_restoration_%@_%@_%@", upperLowerString, toothImageNumberName, buccal5Str];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_RESTORATION_BUCCAL5;
        [self addToothConditionsLayer:conditionLayer];
    }

}


- (void)configureFractureCrownRoot:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //FRACTURE

    NSString *upperLowerString = self.isSurfaceView ? @"upper" : @"lower";
    LayerPosition layerPosition = self.isSurfaceView
            ? (isUp) ? LayerPositionTop : LayerPositionBottom
            : (isUp) ? LayerPositionBottom : LayerPositionTop;
    if (!self.isSurfaceView && conditions.fractureRoot.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"fracture_%@_%@_1", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_FRACTURE_ROOT;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.fractureCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"fracture_%@_%@_2", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[UIImage imageNamed:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_FRACTURE_CROWN;
        [self addToothConditionsLayer:conditionLayer];
    }
}

- (void)configureCrowns:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    //CROWNS + with colour

    NSString *upperLowerString = self.isSurfaceView ? @"upper" : @"lower";
    LayerPosition layerPosition = self.isSurfaceView
            ? (isUp) ? LayerPositionTop : LayerPositionBottom
            : (isUp) ? LayerPositionBottom : LayerPositionTop;
    if (conditions.metalCeramicCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metal_ceramic_%@_%@", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METAL_CERAMIC_CROWN;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.metalFreeCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metal_free_crown_%@_%@", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METAL_FREE_CROWN;
        [self addToothConditionsLayer:conditionLayer];
    }

    if (conditions.metallicCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"metallic_crown_%@_%@", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_METALLIC_CROWN;
        [self addToothConditionsLayer:conditionLayer];
    }
    if (conditions.temporalCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"temporary_crown_%@_%@", upperLowerString, toothImageNumberName];
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self withLayerPosition:layerPosition];
        conditionLayer.conditionCode = TOOTH_CONDITION_TEMPORAL_CROWN;
        [self addToothConditionsLayer:conditionLayer];
    }

    //DESTROYED crown
    if (!self.isSurfaceView && conditions.destroyedCrown.boolValue) {
        NSString *imageName = [[NSString alloc] initWithFormat:@"destroyed_%@", toothImageNumberName];
        self.image = [UIImage imageNamed:imageName];
        [self.toothConditionsLayers setObject:imageName forKey:TOOTH_CONDITION_DESTROYED_CROWN];
    }
}


- (void)configureFissureSealant:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    if (conditions.fissureSealant.boolValue) {
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:@"s_icon@2x"] onView:self];
        conditionLayer.layerPosition = isUp ? LayerPositionTop : LayerPositionBottom;
        conditionLayer.conditionCode = TOOTH_CONDITION_FISSURE_SEALANT;
        [self addToothConditionsLayer:conditionLayer];
    }
}

- (void)configureBanding:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)name isUp:(BOOL)isUp {
    if (conditions.banding.boolValue) {
//    ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:@"circle_icon@2x"] onView:self];
        ToothConditionLayer *conditionLayer = [[ToothConditionLayer alloc] init];
        conditionLayer.conditionCode = TOOTH_CONDITION_BANDING;
        conditionLayer.frame = CGRectMake(0, isUp ? -6 : 4, self.width, self.width);
        conditionLayer.cornerRadius = conditionLayer.width / 2;
        conditionLayer.borderWidth = 2.f;
        conditionLayer.borderColor = [conditions conditionColor].CGColor;
//    conditionLayer.layerPosition = isUp ? LayerPositionTop : LayerPositionBottom;
        [self addToothConditionsLayer:conditionLayer];
    }
}

- (void)configureOcclusalReduction:(BaseToothConditionState *)conditions toothImageNumberName:(NSString *)toothImageNumberName isUp:(BOOL)isUp {
    if (conditions.occlusalReduction.boolValue) {
        NSString *imageName = isUp ? @"v_up@2x" : @"v_down@2x";
        ToothConditionLayer *conditionLayer = [ToothConditionLayer toothConditionLayerWithImage:[conditions conditionImageWithName:imageName] onView:self];
        conditionLayer.layerPosition = isUp ? LayerPositionBottom : LayerPositionTop;
        conditionLayer.conditionCode = TOOTH_CONDITION_OCCLUSAL_REDUCTION;
        [self addToothConditionsLayer:conditionLayer];
    }

}



- (void)addToothConditionsLayer:(ToothConditionLayer *)toothConditionLayer {
    if (toothConditionLayer) {

//        [_toothConditionsLayers addObject:toothConditionLayer];
        if (toothConditionLayer.conditionCode) {
            [self.toothConditionsLayers setObject:toothConditionLayer forKey:toothConditionLayer.conditionCode];
        }

        [self.layer addSublayer:toothConditionLayer];
    }

}

//- (void)removeToothConditionsLayer:(ToothConditionLayer *)toothConditionLayer {
//
//}


@end