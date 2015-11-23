//
//  TreatmentMonitor.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/7/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"
#import "TeethChartingEnums.h"
@protocol MonitorComment;

@interface TreatmentMonitor : BaseObject

/*private String description;
 private BigDecimal price;
 private Long diagnosisId;
 private SelectItem status;
 private SelectItem diagnosis;
 private ArrayList<MonitorCommentTO> dentistComments = new ArrayList<>();
 private SelectItem treatmentArea;
 private String treatmentAreaDetails;
*/
@property (nonatomic, strong) NSString *patientKey;
@property (nonatomic, strong) NSString *descrip;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *createdDate;
@property (nonatomic, strong) NSNumber *diagnosisId;
@property (nonatomic, strong) SelectItem *status;
@property (nonatomic, strong) SelectItem *diagnosis;
@property (nonatomic, strong) NSMutableArray <MonitorComment> *dentistComments;
@property (nonatomic, strong) SelectItem *treatmentArea;
@property (nonatomic, strong) NSString *treatmentAreaDetails;
@property (nonatomic, strong) NSString<Ignore> *treatmentFixAreaDetails;
+ (SelectItem *)getStatusBy:(TransactionMonitorStatusType)statusType;

@end
