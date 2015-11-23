//
// Created by Sanch0 on 3/26/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "TreatmentMultiCodeWithPrices.h"


@implementation TreatmentMultiCodeWithPrices {

}

- (NSDictionary <Ignore> *)pricesDic {
    if (!_pricesDic) {
        NSMutableDictionary *codes = [NSMutableDictionary new];
        if (self.priceList1) {
            codes[@(1)] = self.priceList1;
        }
        if (self.priceList2) {
            codes[@(2)] = self.priceList2;
        }
        if (self.priceList3) {
            codes[@(3)] = self.priceList3;
        }
        if (self.priceList4) {
            codes[@(4)] = self.priceList4;
        }
        if (self.priceList5) {
            codes[@(5)] = self.priceList5;
        }
        if (self.priceList6) {
            codes[@(6)] = self.priceList6;
        }
        _pricesDic = codes;
    }
    return _pricesDic;
}
@end