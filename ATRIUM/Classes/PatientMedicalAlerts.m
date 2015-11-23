//
// Created by Sanch0 on 11/12/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "PatientMedicalAlerts.h"
#import "PatientMedicalAlertItem.h"

@implementation PatientMedicalAlerts

    
- (NSMutableArray *)signedAlerts {
    if(!_signedAlerts) {
        _signedAlerts = [NSMutableArray arrayWithCapacity:0];
        for (PatientMedicalAlertItem *alert  in self.alerts) {
            if(alert.selected) {
                [_signedAlerts addObject:alert];
            }
        }
    }
    return _signedAlerts;
}
    

@end