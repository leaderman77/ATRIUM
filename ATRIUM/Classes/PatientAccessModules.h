//
//  PatientAccessModules.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/5/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface PatientAccessModules : BaseObject

@property (nonatomic, strong) NSNumber *personalDetails;
@property (nonatomic, strong) NSNumber *medicalAlerts;
@property (nonatomic, strong) NSNumber *medicationAlerts;

@end
