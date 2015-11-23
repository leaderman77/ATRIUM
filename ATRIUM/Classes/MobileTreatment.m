//
// Created by Sanch0 on 4/24/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "MobileTreatment.h"
#import "PriceShort.h"


@implementation MobileTreatment {

}
- (id)initWithSelectItem:(SelectItem *)selectItem {
    self = [super init];
    if (self) {
        self.objectId = selectItem.objectId;
        self.name = selectItem.name;
        self.descrip = selectItem.descrip;
        self.code = selectItem.code;
        self.name = [NSString stringWithFormat:@"%@ - %@", selectItem.code ? selectItem.code : @"", selectItem.descrip ? selectItem.descrip : @""];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    MobileTreatment *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.quantity = self.quantity;
        copy.patientShare = self.patientShare;
        copy.payerShare = self.payerShare;
        copy.donNotBillInsurance = self.donNotBillInsurance;
    }

    return copy;
}

@end