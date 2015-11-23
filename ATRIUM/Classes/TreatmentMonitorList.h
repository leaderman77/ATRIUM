//
//  TreatmentMonitorList.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/8/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol  TreatmentMonitor;

@interface TreatmentMonitorList : BaseObject

@property (nonatomic, strong) NSMutableArray<TreatmentMonitor> *list;
@property (nonatomic, strong) NSNumber *totalCount;

@end
