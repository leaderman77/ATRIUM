//
// Created by Sanch0 on 4/2/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeethChartingEnums.h"


#define ADULT_TOOTH_CODE @"Adult"
#define CHILD_TOOTH_CODE @"Child"
#define SUPERNUMERARY_TOOTH_CODE @"Supernumerary"



@interface ToothDetailsType : BaseObject <SelectItem>

@property (nonatomic, strong) NSNumber *objectId;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) SelectItem *position;
@property (nonatomic, strong) SelectItem *generation;
@property (nonatomic, strong) SelectItem *quadrant;
@property (nonatomic, strong) NSNumber *rootCount;
@property (nonatomic, strong) SelectItem *sextant;
@property (nonatomic, strong) SelectItem *mouth;
@property (nonatomic, strong) SelectItem *toothType;
@property (nonatomic, strong) NSString *numeric1;
@property (nonatomic, strong) NSString *numeric2;
@property (nonatomic, strong) NSString *numeric3;
@property (nonatomic, strong) UIImage *toothImage;

+ (ToothDetailsType *)sharedInstance;


//SHARED INSTANCE METHODS
- (ToothDetailsType *)toothDetailsWithPositionCode:(NSString *)positionCode;

- (ToothDetailsType *)toothDetailsWithCode:(NSString *)code;

- (ToothDetailsType *)childToothDetailsWithPosition:(NSInteger)position;

- (ToothDetailsType *)adultToothDetailsWithPosition:(NSInteger)position;

- (ToothDetailsType *)toothDetailsWithPositionCode:(NSString *)positionCode withGenerationType:(GenerationType)generationType;

- (ToothDetailsType *)toothDetailsWithPositionCode:(NSString *)positionCode withGenerationCode:(NSString *)generationCode;

- (NSString *)numeric;

- (NSString *)imageNameWithCode:(NSString *)code;

- (NSString *)imageNameWithPositionCode:(NSString *)code;

- (NSArray *)allToothItems;

- (NSArray *)allToothValues;

- (NSArray *)allPositionCodes;

- (NSArray *)allToothItemsWithPatientKey:(NSString *)patientKey;

- (UIImage *)toothImageWithPositionCode:(NSString *)positionCode withPrimaryType:(BOOL)isPrimary;

- (UIImage *)toothSurfaceImageWithPositionCode:(NSString *)positionCode withPrimaryType:(BOOL)isPrimary;


- (NSString *)generationCode:(GenerationType)generationType;

- (ToothDetailsType *)toothDetailsWithCompanyNumeric:(NSString *)numeric;

- (ToothDetailsType *)toothDetailsWithNumeric1:(NSString *)numeric1;

- (ToothDetailsType *)toothDetailsWithNumeric2:(NSString *)numeric2;


// INSTANCE METHODS
- (NSString *)imageName;

//- (UIImage *)toothImage;

- (UIImage *)toothSurfaceImage;

- (UIImage *)toothImageForCarousel;

@end