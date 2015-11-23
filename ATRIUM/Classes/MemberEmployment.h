//
//  MemberEmployment.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface MemberEmployment : BaseObject

@property (nonatomic, strong) NSNumber *contractPeriodCount;
@property (nonatomic, strong) SelectItem *contractPeriodType;
@property (nonatomic, strong) SelectItem *mode;
@property (nonatomic, strong) NSNumber *dismissDate;
@property (nonatomic, strong) NSNumber *hiringDate;
@property (nonatomic, assign) BOOL hasBonus;
@property (nonatomic, strong) SelectItem *staffPosition;
@property (nonatomic, strong) SelectItem *salaryPlan;
@property (nonatomic, strong) NSArray<SelectItem> *speciality;
/*  private Long id;
 private int contractPeriodCount;
 private SelectItem contractPeriodType;
 private SelectItem mode;
 private Date dismissDate;
 private Date hiringDate;
 private boolean hasBonus;
 private SelectItem staffPosition;
 private SelectItem salaryPlan;
 private List<SelectItem> speciality = new ArrayList<>();*/

@end
