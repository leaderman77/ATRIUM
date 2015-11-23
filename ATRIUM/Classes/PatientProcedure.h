//
//  PatientProcedure.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/5/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "DentalTransactionBaseItem.h"

@protocol PatientProcedureTreatment;

@interface PatientProcedure : BaseObject

@property(nonatomic, strong) NSNumber *procedureId;
@property(nonatomic, strong) NSNumber *appointmentId;
@property(nonatomic, strong) NSArray<PatientProcedureTreatment> *treatments;
@property(nonatomic, strong) NSString *patientKey;

@end
