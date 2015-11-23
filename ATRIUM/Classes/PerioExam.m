//
//  PerioExam.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 5/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PerioExam.h"

@implementation PerioExam
/* private Long id;
 private String patientKey;
 private Long dentistId;
 private Date createdDate;
 private SelectItem tooth;
 private SelectItem plaqueStatus;
 private SelectItem mobilityStatus;
 private SelectItem boneLossStatus;
 private Long furcationStatus;
 private Boolean mucogingivalDefectStatus = false;
 
 private Long probingDepthDistal;
 private Long probingDepthCentral;
 private Long probingDepthMesial;
 
 private Long gingivalMarginDistal;
 private Long gingivalMarginCentral;
 private Long gingivalMarginMesial;
 
 private Long clinicalAttachmentDistal;
 private Long clinicalAttachmentCentral;
 private Long clinicalAttachmentMesial;
 
 private Boolean bleedingDistal = false;
 private Boolean bleedingCentral = false;
 private Boolean bleedingMesial = false;
 
 private Boolean suppurationDistal = false;
 private Boolean suppurationCentral = false;
 private Boolean suppurationMesial = false;*/
- (instancetype)init {
    self = [super init];
    if(self) {
        _probingDepthCentral = _probingDepthMesial = _probingDepthDistal = [NSNumber numberWithInt:0];
        _gingivalMarginDistal = _gingivalMarginCentral = _gingivalMarginMesial = [NSNumber numberWithInt:0];
        _clinicalAttachmentDistal = _clinicalAttachmentCentral = _clinicalAttachmentMesial = [NSNumber numberWithInt:0];
    }
    return self;
}

+ (SelectItem *)plaqueStatusWith:(NSInteger)type {
    SelectItem *plaque = nil;
    switch (type) {
        case 0:
            plaque = [[SelectItem alloc] initWithId:@1 withName:@"PlaqueStatus_None" withCode:@"PlaqueStatus_None"];
            break;
        case 1:
            plaque = [[SelectItem alloc] initWithId:@2 withName:@"PlaqueStatus_Light" withCode:@"PlaqueStatus_Light"];
            break;
        case 2:
            plaque = [[SelectItem alloc] initWithId:@3 withName:@"PlaqueStatus_Moderate" withCode:@"PlaqueStatus_Moderate"];
            break;
        case 3:
            plaque = [[SelectItem alloc] initWithId:@4 withName:@"PlaqueStatus_Heavy" withCode:@"PlaqueStatus_Heavy"];
            break;
        default:
            break;
    }
    return plaque;
}

- (BOOL)isFrontSide {
    return [self.toothSide.code isEqualToString:@"Front_Side"];
}

+ (SelectItem *)mobilityStatusWith:(NSInteger)type {
    SelectItem *mobility = nil;
    switch (type) {
        case 0:
            mobility = [[SelectItem alloc] initWithId:@4 withName:@"MobilityStatus_None" withCode:@"MobilityStatus_None"];
            break;
        case 1:
            mobility = [[SelectItem alloc] initWithId:@1 withName:@"MobilityStatus_Category1" withCode:@"MobilityStatus_Category1"];
            break;
        case 2:
            mobility = [[SelectItem alloc] initWithId:@2 withName:@"MobilityStatus_Category2" withCode:@"MobilityStatus_Category2"];
            break;
        case 3:
            mobility = [[SelectItem alloc] initWithId:@3 withName:@"MobilityStatus_Category3" withCode:@"MobilityStatus_Category3"];
            break;
       
        default:
            break;
    }
    return mobility;
}
+ (SelectItem *)boneLossStatusWith:(NSInteger)type {
    SelectItem *boneLoss = nil;
    switch (type) {
        case 0:
            boneLoss = [[SelectItem alloc] initWithId:@1 withName:@"BoneLossStatus_None" withCode:@"BoneLossStatus_None"];
            break;
        case 1:
            boneLoss = [[SelectItem alloc] initWithId:@2 withName:@"BoneLossStatus_Light" withCode:@"BoneLossStatus_Light"];
            break;
        case 2:
            boneLoss = [[SelectItem alloc] initWithId:@3 withName:@"BoneLossStatus_Moderate" withCode:@"BoneLossStatus_Moderate"];
            break;
        case 3:
            boneLoss = [[SelectItem alloc] initWithId:@4 withName:@"BoneLossStatus_Heavy" withCode:@"BoneLossStatus_Heavy"];
            break;
        default:
            break;
    }
    return boneLoss;
}
/*

[5/28/15, 2:31:14 PM] Ilxom Lutfullaev:     None(1, "PlaqueStatus_None"),
Category1(2, "PlaqueStatus_Category1"),
Category2(3, "PlaqueStatus_Category2"),
Category3(4, "PlaqueStatus_Category3");
[5/28/15, 2:31:18 PM] Ilxom Lutfullaev: -------------------------------------------------
[5/28/15, 2:31:27 PM] Ilxom Lutfullaev: PerioExamPlaqueStatus {
    
    None(1, "PlaqueStatus_None"),
    Light(2, "PlaqueStatus_Light"),
    Moderate(3, "PlaqueStatus_Moderate"),
    Heavy(4, "PlaqueStatus_Heavy");
    [5/28/15, 2:31:31 PM] Ilxom Lutfullaev: -----------------------------------------------------
    [5/28/15, 2:31:55 PM] Ilxom Lutfullaev: PerioExamBoneLossStatus {
        
        None(1, "PlaqueStatus_None"),
        Mild(2, "PlaqueStatus_Mild"),
        Moderate(3, "PlaqueStatus_Moderate"),
        Severe(4, "PlaqueStatus_Severe");
*/





@end
