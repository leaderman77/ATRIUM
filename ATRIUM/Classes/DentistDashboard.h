//
//  DentistDashboard.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@class Member, MemberWorkingHoursCollection,DentalTransactionFullItemList, StaffSignedFormList;
@interface DentistDashboard : BaseObject

@property (nonatomic, strong) Member *memberDetails;
@property (nonatomic, strong) MemberWorkingHoursCollection *memberWorkingHours;
@property (nonatomic, strong) DentalTransactionFullItemList *recentTreatments;
@property (nonatomic, strong) StaffSignedFormList *needSignForms;
/*private MemberTO memberDetails;
 private MemberWorkingHoursCollection memberWorkingHours;
 private TableList<DentalTransactionFullItemTO> recentTreatments;
 private TableList<StaffSignedFormTO> needSignForms;*/
///
@end
