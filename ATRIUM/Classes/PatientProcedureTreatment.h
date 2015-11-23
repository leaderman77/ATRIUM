//
//  PatientProcedureTreatment.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/5/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface PatientProcedureTreatment : BaseObject

@property(nonatomic, strong) SelectItem *treatment;
@property(nonatomic, strong) SelectItem *tooth;
@property(nonatomic, strong) SelectItem *area;
@property(nonatomic, strong) NSArray<SelectItem> *areaDetails;

@end
