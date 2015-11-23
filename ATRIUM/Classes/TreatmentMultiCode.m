//
// Created by Sanch0 on 2/12/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "TreatmentMultiCode.h"
#import "TreatmentItem.h"


@implementation TreatmentMultiCode {

}

- (NSDictionary <Ignore> *)maxCodesDic {
    if (!_maxCodesDic) {
        NSMutableDictionary *codes = [NSMutableDictionary new];
        if (self.treatmentCode1) {
            codes[@(1)] = self.treatmentCode1;
        }
        if (self.treatmentCode2) {
            codes[@(2)] = self.treatmentCode2;
        }
        if (self.treatmentCode3) {
            codes[@(3)] = self.treatmentCode3;
        }
        if (self.treatmentCode4) {
            codes[@(4)] = self.treatmentCode4;
        }
        if (self.treatmentCode5) {
            codes[@(5)] = self.treatmentCode5;
        }
        if (self.treatmentCode6) {
            codes[@(6)] = self.treatmentCode6;
        }
        _maxCodesDic = codes;
    }
    return _maxCodesDic;
}

@end