//
//  TreatmentMonitor.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/7/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "TreatmentMonitor.h"

@implementation TreatmentMonitor

+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"description" : @"descrip"}];
}

+ (SelectItem *)getStatusBy:(TransactionMonitorStatusType)statusType {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:@(statusType) withName:nil];
    switch (statusType) {
        case kMonitorActiveStatus :
//            selectItem.code = TRANSACTION_MONITOR_ACTIVE;
            break;
        case kMonitorStoppedStatus :
//            selectItem.code = TRANSACTION_MONITOR_STOPPPED;
            break;
    }
    return selectItem;
}


- (NSString *)treatmentFixAreaDetails {
    if(!_treatmentFixAreaDetails) {
        NSMutableArray *areaDetails = [[self.treatmentAreaDetails componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" |"]] mutableCopy];
        [areaDetails removeObject:@""];
        if([self.treatmentArea.code isEqualToString:@"SURFACE"]) {
            NSMutableArray *areadetails2  = [NSMutableArray array];
            for (NSString *area in areaDetails) {
                [areadetails2 addObject:[area substringToIndex:1]];
            }
            areaDetails = areadetails2;
        }
        _treatmentFixAreaDetails = [areaDetails componentsJoinedByString:@","];
    }
    return _treatmentFixAreaDetails;
}

@end
