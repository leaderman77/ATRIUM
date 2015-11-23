//
// Created by Sanch0 on 4/2/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "ToothDetailsType.h"
#import "DentalTransactionBaseItem.h"
#import "OrderedDictionary.h"

@interface ToothDetailsType ()

@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) NSMutableDictionary *codesDic;
@property (nonatomic, strong) OrderedDictionary *positionCodesDic;
@property (nonatomic, strong) NSMutableDictionary *numeric1Dic;
@property (nonatomic, strong) NSMutableDictionary *numeric2Dic;
@property (nonatomic, strong) NSMutableDictionary *imageNamesDic;

- (instancetype)initWithId:(NSNumber *)objectId withPositionCode:(NSString *)positionCode withGenerationType:(GenerationType)generationType withRootCount:(NSNumber *)rootCount
          withQuadrantType:(QuadrantType)quadrantType withSextantType:(SextantType)sextantType withMouthType:(MouthType)mouthType withToothType:(ToothType)toothType
              withNumeric1:(NSString *)numeric1 withNumeric2:(NSString *)numeric2 withNumeric3:(NSString *)numeric3;

@end

@implementation ToothDetailsType {

}

- (NSString *)autocompleteString {
    return @"";
}


+ (ToothDetailsType *)sharedInstance {
    static dispatch_once_t onceToken;
    static ToothDetailsType *_instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [[ToothDetailsType alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _codesDic = [NSMutableDictionary new];
        _numeric1Dic = [NSMutableDictionary new];
        _numeric2Dic = [NSMutableDictionary new];
        _positionCodesDic = [OrderedDictionary new];

        _values = [[NSMutableArray alloc] init];
        _imageNamesDic = [NSMutableDictionary new];
        [self populateValues];

    }

    return self;
}

- (instancetype)initWithId:(NSNumber *)objectId withPositionCode:(NSString *)positionCode withGenerationType:(GenerationType)generationType withRootCount:(NSNumber *)rootCount
          withQuadrantType:(QuadrantType)quadrantType withSextantType:(SextantType)sextantType withMouthType:(MouthType)mouthType withToothType:(ToothType)toothType
              withNumeric1:(NSString *)numeric1 withNumeric2:(NSString *)numeric2 withNumeric3:(NSString *)numeric3 {
    self = [super init];
    if (self) {
        self.objectId = objectId;
        self.position = [[SelectItem alloc] initWithId:nil withName:positionCode withCode:positionCode];
        NSString *generationCode = [self generationCode:generationType];
        self.generation = [[SelectItem alloc] initWithId:@(generationType) withName:generationCode withCode:generationCode];
        self.rootCount = rootCount;
        self.quadrant = [DentalTransactionBaseItem selectItemWithTreatmentArea:kQuadrantTreatmentAreaType withEnum:quadrantType];
        self.sextant = [DentalTransactionBaseItem selectItemWithTreatmentArea:kSextantTreatmentAreaType withEnum:sextantType];
        self.mouth = [DentalTransactionBaseItem selectItemWithTreatmentArea:kMouthTreatmentAreaType withEnum:mouthType];
        self.toothType = [DentalTransactionBaseItem selectItemWithTreatmentArea:kToothTreatmentAreaType withEnum:toothType];
        self.numeric1 = numeric1;
        self.numeric2 = numeric2;
        self.numeric3 = numeric3;
        self.code = [generationCode stringByAppendingFormat:@"_%@", positionCode];
    }
    return self;
}


- (void)populateDicsWithLastItem {
    ToothDetailsType *item = [_values lastObject];
    _codesDic[item.code] = item;
    [_positionCodesDic setObject:item forKey:item.position.code];
//    _positionCodesDic[item.position.code] = item;
}

- (void)populateValues {


    //ADULT TEETH
    [_values addObject:[[ToothDetailsType alloc] initWithId:@22 withPositionCode:@"p1" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"1" withNumeric2:@"18" withNumeric3:@"51"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@23 withPositionCode:@"p2" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"2" withNumeric2:@"17" withNumeric3:@"52"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@24 withPositionCode:@"p3" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"3" withNumeric2:@"16" withNumeric3:@"53"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@25 withPositionCode:@"p4" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"4" withNumeric2:@"15" withNumeric3:@"54"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@26 withPositionCode:@"p5" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"5" withNumeric2:@"14" withNumeric3:@"55"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@27 withPositionCode:@"p6" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"6" withNumeric2:@"13" withNumeric3:@"56"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@28 withPositionCode:@"p7" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kLateralToothType
                                               withNumeric1:@"7" withNumeric2:@"12" withNumeric3:@"57"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@29 withPositionCode:@"p8" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCentralToothType
                                               withNumeric1:@"8" withNumeric2:@"11" withNumeric3:@"58"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@30 withPositionCode:@"p9" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCentralToothType
                                               withNumeric1:@"9" withNumeric2:@"21" withNumeric3:@"59"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@31 withPositionCode:@"p10" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kLateralToothType
                                               withNumeric1:@"10" withNumeric2:@"22" withNumeric3:@"60"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@32 withPositionCode:@"p11" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"11" withNumeric2:@"23" withNumeric3:@"61"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@33 withPositionCode:@"p12" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"12" withNumeric2:@"24" withNumeric3:@"62"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:@34 withPositionCode:@"p13" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"13" withNumeric2:@"25" withNumeric3:@"63"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@35 withPositionCode:@"p14" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"14" withNumeric2:@"26" withNumeric3:@"64"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@36 withPositionCode:@"p15" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"15" withNumeric2:@"27" withNumeric3:@"65"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@37 withPositionCode:@"p16" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"16" withNumeric2:@"28" withNumeric3:@"66"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:@38 withPositionCode:@"p17" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"17" withNumeric2:@"38" withNumeric3:@"67"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@39 withPositionCode:@"p18" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"18" withNumeric2:@"37" withNumeric3:@"68"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@40 withPositionCode:@"p19" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"19" withNumeric2:@"36" withNumeric3:@"69"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@41 withPositionCode:@"p20" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"20" withNumeric2:@"35" withNumeric3:@"70"]];


    [_values addObject:[[ToothDetailsType alloc] initWithId:@42 withPositionCode:@"p21" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"21" withNumeric2:@"34" withNumeric3:@"71"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@43 withPositionCode:@"p22" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"22" withNumeric2:@"33" withNumeric3:@"72"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@44 withPositionCode:@"p23" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kLateralToothType
                                               withNumeric1:@"23" withNumeric2:@"32" withNumeric3:@"73"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@45 withPositionCode:@"p24" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCentralToothType
                                               withNumeric1:@"24" withNumeric2:@"31" withNumeric3:@"74"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:@46 withPositionCode:@"p25" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCentralToothType
                                               withNumeric1:@"25" withNumeric2:@"41" withNumeric3:@"75"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@47 withPositionCode:@"p26" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kLateralToothType
                                               withNumeric1:@"26" withNumeric2:@"42" withNumeric3:@"76"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@48 withPositionCode:@"p27" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"27" withNumeric2:@"43" withNumeric3:@"77"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@49 withPositionCode:@"p28" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"28" withNumeric2:@"44" withNumeric3:@"78"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@50 withPositionCode:@"p29" withGenerationType:AdultGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"29" withNumeric2:@"45" withNumeric3:@"79"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:@51 withPositionCode:@"p30" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"30" withNumeric2:@"46" withNumeric3:@"80"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@52 withPositionCode:@"p31" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"31" withNumeric2:@"47" withNumeric3:@"81"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@53 withPositionCode:@"p32" withGenerationType:AdultGenerationType withRootCount:@3
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"32" withNumeric2:@"48" withNumeric3:@"82"]];

    //CHILD TEETH
    [_values addObject:[[ToothDetailsType alloc] initWithId:@2 withPositionCode:@"p4" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"A" withNumeric2:@"A" withNumeric3:@"54"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@3 withPositionCode:@"p5" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"B" withNumeric2:@"B" withNumeric3:@"55"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@4 withPositionCode:@"p6" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"C" withNumeric2:@"C" withNumeric3:@"56"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@5 withPositionCode:@"p7" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kLateralToothType
                                               withNumeric1:@"D" withNumeric2:@"D" withNumeric3:@"57"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@6 withPositionCode:@"p8" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCentralToothType
                                               withNumeric1:@"E" withNumeric2:@"E" withNumeric3:@"58"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@7 withPositionCode:@"p9" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCentralToothType
                                               withNumeric1:@"F" withNumeric2:@"F" withNumeric3:@"59"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@8 withPositionCode:@"p10" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kLateralToothType
                                               withNumeric1:@"G" withNumeric2:@"G" withNumeric3:@"60"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@9 withPositionCode:@"p11" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"H" withNumeric2:@"H" withNumeric3:@"61"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@10 withPositionCode:@"p12" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"I" withNumeric2:@"I" withNumeric3:@"62"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@11 withPositionCode:@"p13" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"J" withNumeric2:@"J" withNumeric3:@"63"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@12 withPositionCode:@"p20" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"K" withNumeric2:@"K" withNumeric3:@"70"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@13 withPositionCode:@"p21" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"L" withNumeric2:@"L" withNumeric3:@"71"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@14 withPositionCode:@"p22" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"M" withNumeric2:@"M" withNumeric3:@"72"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@15 withPositionCode:@"p23" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kLateralToothType
                                               withNumeric1:@"N" withNumeric2:@"N" withNumeric3:@"73"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@16 withPositionCode:@"p24" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCentralToothType
                                               withNumeric1:@"O" withNumeric2:@"O" withNumeric3:@"74"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@17 withPositionCode:@"p25" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCentralToothType
                                               withNumeric1:@"P" withNumeric2:@"P" withNumeric3:@"75"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@18 withPositionCode:@"p26" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kLateralToothType
                                               withNumeric1:@"Q" withNumeric2:@"Q" withNumeric3:@"76"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@19 withPositionCode:@"p27" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"R" withNumeric2:@"R" withNumeric3:@"77"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@20 withPositionCode:@"p28" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"S" withNumeric2:@"S" withNumeric3:@"78"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:@21 withPositionCode:@"p29" withGenerationType:ChildGenerationType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"T" withNumeric2:@"T" withNumeric3:@"79"]];

    //SUPERNUMERARY TEETH
    [_values addObject:[[ToothDetailsType alloc] initWithId:@54 withPositionCode:@"p1" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"51" withNumeric2:@"51" withNumeric3:@"51"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p2" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"52" withNumeric2:@"52" withNumeric3:@"52"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p3" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"53" withNumeric2:@"53" withNumeric3:@"53"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p4" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant1 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"54" withNumeric2:@"54" withNumeric3:@"54"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p5" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"55" withNumeric2:@"55" withNumeric3:@"55"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p6" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"56" withNumeric2:@"56" withNumeric3:@"56"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p7" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kLateralToothType
                                               withNumeric1:@"57" withNumeric2:@"57" withNumeric3:@"57"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p8" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperRightQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCentralToothType
                                               withNumeric1:@"58" withNumeric2:@"58" withNumeric3:@"58"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p9" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCentralToothType
                                               withNumeric1:@"59" withNumeric2:@"59" withNumeric3:@"59"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p10" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kLateralToothType
                                               withNumeric1:@"60" withNumeric2:@"60" withNumeric3:@"60"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p11" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"61" withNumeric2:@"62" withNumeric3:@"61"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p12" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant2 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"62" withNumeric2:@"62" withNumeric3:@"62"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p13" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"63" withNumeric2:@"63" withNumeric3:@"63"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p14" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"64" withNumeric2:@"64" withNumeric3:@"64"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p15" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"65" withNumeric2:@"65" withNumeric3:@"65"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p16" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kUpperLeftQuadrantType withSextantType:kSextant3 withMouthType:kUpperMouthType withToothType:kMolarToothType
                                               withNumeric1:@"66" withNumeric2:@"66" withNumeric3:@"66"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p17" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"67" withNumeric2:@"67" withNumeric3:@"67"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p18" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"68" withNumeric2:@"68" withNumeric3:@"68"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p19" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"69" withNumeric2:@"69" withNumeric3:@"69"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p20" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant4 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"70" withNumeric2:@"70" withNumeric3:@"70"]];


    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p21" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"71" withNumeric2:@"71" withNumeric3:@"71"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p22" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"72" withNumeric2:@"72" withNumeric3:@"72"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p23" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kLateralToothType
                                               withNumeric1:@"73" withNumeric2:@"73" withNumeric3:@"73"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p24" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerLeftQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCentralToothType
                                               withNumeric1:@"74" withNumeric2:@"74" withNumeric3:@"74"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p25" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCentralToothType
                                               withNumeric1:@"75" withNumeric2:@"75" withNumeric3:@"75"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p26" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kLateralToothType
                                               withNumeric1:@"76" withNumeric2:@"76" withNumeric3:@"76"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p27" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kCuspidToothType
                                               withNumeric1:@"77" withNumeric2:@"77" withNumeric3:@"77"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p28" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant5 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"78" withNumeric2:@"78" withNumeric3:@"78"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p29" withGenerationType:SupernumeraryType withRootCount:@1
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kBicuspidToothType
                                               withNumeric1:@"79" withNumeric2:@"79" withNumeric3:@"79"]];

    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p30" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"80" withNumeric2:@"80" withNumeric3:@"80"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p31" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"81" withNumeric2:@"81" withNumeric3:@"81"]];
    [_values addObject:[[ToothDetailsType alloc] initWithId:nil withPositionCode:@"p32" withGenerationType:SupernumeraryType withRootCount:@3
                                           withQuadrantType:kLowerRightQuadrantType withSextantType:kSextant6 withMouthType:kLowerMouthType withToothType:kMolarToothType
                                               withNumeric1:@"82" withNumeric2:@"82" withNumeric3:@"82"]];

    [_values enumerateObjectsUsingBlock:^(ToothDetailsType *item, NSUInteger idx, BOOL *stop) {
        _codesDic[item.code] = item;
        _numeric1Dic[item.numeric1] = item;
        _numeric2Dic[item.numeric2] = item;
//        _positionCodesDic[item.position.code] = item;
        [_positionCodesDic setObject:item forKey:item.position.code];
    }];

    _imageNamesDic[@"Adult_p1"] = @"18";
    _imageNamesDic[@"Adult_p2"] = @"17";
    _imageNamesDic[@"Adult_p3"] = @"16";
    _imageNamesDic[@"Adult_p4"] = @"15";
    _imageNamesDic[@"Adult_p5"] = @"14";
    _imageNamesDic[@"Adult_p6"] = @"13";
    _imageNamesDic[@"Adult_p7"] = @"12";
    _imageNamesDic[@"Adult_p8"] = @"11";
    _imageNamesDic[@"Adult_p9"] = @"21";
    _imageNamesDic[@"Adult_p10"] = @"22";
    _imageNamesDic[@"Adult_p11"] = @"23";
    _imageNamesDic[@"Adult_p12"] = @"24";
    _imageNamesDic[@"Adult_p13"] = @"25";
    _imageNamesDic[@"Adult_p14"] = @"26";
    _imageNamesDic[@"Adult_p15"] = @"27";
    _imageNamesDic[@"Adult_p16"] = @"28";

    _imageNamesDic[@"Adult_p17"] = @"38";
    _imageNamesDic[@"Adult_p18"] = @"37";
    _imageNamesDic[@"Adult_p19"] = @"36";
    _imageNamesDic[@"Adult_p20"] = @"35";
    _imageNamesDic[@"Adult_p21"] = @"34";
    _imageNamesDic[@"Adult_p22"] = @"33";
    _imageNamesDic[@"Adult_p23"] = @"32";
    _imageNamesDic[@"Adult_p24"] = @"31";
    _imageNamesDic[@"Adult_p25"] = @"41";
    _imageNamesDic[@"Adult_p26"] = @"42";
    _imageNamesDic[@"Adult_p27"] = @"43";
    _imageNamesDic[@"Adult_p28"] = @"44";
    _imageNamesDic[@"Adult_p29"] = @"45";
    _imageNamesDic[@"Adult_p30"] = @"46";
    _imageNamesDic[@"Adult_p31"] = @"47";
    _imageNamesDic[@"Adult_p32"] = @"48";

    _imageNamesDic[@"Child_p4"] = @"17";
    _imageNamesDic[@"Child_p5"] = @"16";
    _imageNamesDic[@"Child_p6"] = @"13";
    _imageNamesDic[@"Child_p7"] = @"12";
    _imageNamesDic[@"Child_p8"] = @"11";
    _imageNamesDic[@"Child_p9"] = @"21";
    _imageNamesDic[@"Child_p10"] = @"22";
    _imageNamesDic[@"Child_p11"] = @"23";
    _imageNamesDic[@"Child_p12"] = @"26";
    _imageNamesDic[@"Child_p13"] = @"27";

    _imageNamesDic[@"Child_p20"] = @"37";
    _imageNamesDic[@"Child_p21"] = @"36";
    _imageNamesDic[@"Child_p22"] = @"33";
    _imageNamesDic[@"Child_p23"] = @"32";
    _imageNamesDic[@"Child_p24"] = @"31";
    _imageNamesDic[@"Child_p25"] = @"41";
    _imageNamesDic[@"Child_p26"] = @"42";
    _imageNamesDic[@"Child_p27"] = @"43";
    _imageNamesDic[@"Child_p28"] = @"46";
    _imageNamesDic[@"Child_p29"] = @"47";

}

- (ToothDetailsType *)toothDetailsWithPositionCode:(NSString *)positionCode {
    return [_positionCodesDic objectForKey:positionCode];
}

- (ToothDetailsType *)toothDetailsWithCode:(NSString *)code {
    return _codesDic[code];
}


- (ToothDetailsType *)childToothDetailsWithPosition:(NSInteger)position {
    NSString *code = [@"Child_" stringByAppendingFormat:@"%ld", (long) position];
    return _codesDic[code];
}

- (ToothDetailsType *)adultToothDetailsWithPosition:(NSInteger)position {
    NSString *code = [@"Adult_" stringByAppendingFormat:@"%ld", (long) position];
    return _codesDic[code];
}

- (ToothDetailsType *)toothDetailsWithCompanyNumeric:(NSString *)numeric {
    SessionData *sessionData = [[SettingsManager sharedManager] sessionData];
    ToothDetailsType *toothDetailsType = nil;
    if (!sessionData.toothNumericType.code || [sessionData.toothNumericType.code isEqualToString:@"Index1"]) {
        toothDetailsType = self.numeric1Dic[numeric];
    } else if ([sessionData.toothNumericType.code isEqualToString:@"Index2"]) {
        toothDetailsType = self.numeric2Dic[numeric];
    }
    return toothDetailsType;
}

- (ToothDetailsType *)toothDetailsWithNumeric1:(NSString *)numeric1 {
    return numeric1 ? _numeric1Dic[numeric1] : nil;
}

- (ToothDetailsType *)toothDetailsWithNumeric2:(NSString *)numeric2 {
    return numeric2 ? _numeric2Dic[numeric2] : nil;
}

- (NSString *)generationCode:(GenerationType)generationType {
    return generationType == AdultGenerationType ? ADULT_TOOTH_CODE : generationType == ChildGenerationType ? CHILD_TOOTH_CODE : SUPERNUMERARY_TOOTH_CODE;
}

- (ToothDetailsType *)toothDetailsWithPositionCode:(NSString *)positionCode withGenerationType:(GenerationType)generationType {
    NSString *code = [NSString stringWithFormat:@"%@_%@", [self generationCode:generationType], positionCode];
    return _codesDic[code];
}

- (ToothDetailsType *)toothDetailsWithPositionCode:(NSString *)positionCode withGenerationCode:(NSString *)generationCode {
    NSString *code = [NSString stringWithFormat:@"%@_%@", generationCode, positionCode];
    return _codesDic[code];
}


- (NSString *)numeric {
    SessionData *sessionData = [[SettingsManager sharedManager] sessionData];
    return [sessionData.toothNumericType.code isEqualToString:@"Index1"] ? _numeric1 : _numeric2;
}

- (NSArray *)childToothItems {
    return [_values subarrayWithRange:NSMakeRange(0, 20)];
}

- (NSArray *)adultToothItems {
    return [_values subarrayWithRange:NSMakeRange(20, _values.count - 20)];
}

- (NSArray *)allToothValues {
    return [_values copy];
}

- (NSArray *)allToothItems {
    //TODO need to return Patient all teeth instead of all tooth
    return self.adultToothItems;
}

- (NSArray *)allPositionCodes {
    return [_positionCodesDic allKeys];
}


- (NSArray *)allToothItemsWithPatientKey:(NSString *)patientKey {
    NSMutableArray *toothItems = [[NSMutableArray alloc] init];
    NSDictionary *toothItemTypesDic = [[SettingsManager sharedManager] toothTypesDicWithPatientKey:patientKey];
    for (int i = 1; i <= 32; i++) {
        NSString *positionCode = [[NSString alloc] initWithFormat:@"p%d", i];
        GenerationType generationType = [toothItemTypesDic[positionCode] boolValue] ? ChildGenerationType : AdultGenerationType;
        ToothDetailsType *toothDetailsType = [[ToothDetailsType sharedInstance] toothDetailsWithPositionCode:positionCode withGenerationType:generationType];
        [toothItems addObject:toothDetailsType];
    }
    return toothItems;
}


- (SelectItem *)toSelectItem {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:self.objectId withName:self.name withCode:self.code];
    return selectItem;
}

- (NSString *)imageNameWithCode:(NSString *)code {
    return code ? [ToothDetailsType sharedInstance].imageNamesDic[code] : nil;
}

- (NSString *)imageNameWithPositionCode:(NSString *)code {
    return code ? [ToothDetailsType sharedInstance].imageNamesDic[[@"Adult_" stringByAppendingString:code]] : nil;
}


- (NSString *)imageName {
    return [ToothDetailsType sharedInstance].imageNamesDic[self.code];
}

- (UIImage *)toothImage {
    if(_toothImage) {
        return _toothImage;
    }
    if ([self.generation.code isEqualIgnoreCase:SUPERNUMERARY_TOOTH_CODE]) {
        return nil;
    }
    NSString *imageName = [NSString stringWithFormat:@"%@_1.png", [ToothDetailsType sharedInstance].imageNamesDic[self.code]];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)toothSurfaceImage {
    if ([self.generation.code isEqualIgnoreCase:SUPERNUMERARY_TOOTH_CODE]) {
        return nil;
    }
    NSString *imageName = [NSString stringWithFormat:@"%@_2.png", [ToothDetailsType sharedInstance].imageNamesDic[self.code]];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)toothImageForCarousel {
    NSString *imageNameCode = [ToothDetailsType sharedInstance].imageNamesDic[self.code];
    if (imageNameCode) {
        NSString *imageName = [NSString stringWithFormat:@"%@_1.png", imageNameCode];
        return [UIImage imageNamed:imageName];
    } else {
        return nil;
    }

}

- (UIImage *)toothImageWithPositionCode:(NSString *)positionCode withPrimaryType:(BOOL)isPrimary {
    NSString *imageName = nil;
    NSInteger numeric = positionCode.integerValue;
    if (isPrimary) {
//      if ([@[@"11", @"12", @"13", @"21", @"22", @"23", @"41", @"42", @"43", @"31", @"32", @"33"] containsObject:positionCode]) {
        if ([@[@"p8", @"p7", @"p6", @"p9", @"p10", @"p11", @"p25", @"p26", @"p27", @"p24", @"p23", @"p22"] containsObject:positionCode]) {
            imageName = [NSString stringWithFormat:@"%ld_1.png", (long) numeric];
//        } else if ([@[@"14", @"15", @"44", @"45", @"24", @"25", @"33", @"34", @"35"] containsObject:positionCode]) {
        } else if ([@[@"p5", @"p4", @"p28", @"p29", @"p12", @"p13", @"p22", @"p21", @"p20"] containsObject:positionCode]) {
            imageName = [NSString stringWithFormat:@"%ld_1.png", (long) (numeric + 2)];
        }
    } else {
        imageName = [NSString stringWithFormat:@"%ld_1.png", (long) numeric];
    }

    return [UIImage imageNamed:imageName];
}

- (UIImage *)toothSurfaceImageWithPositionCode:(NSString *)positionCode withPrimaryType:(BOOL)isPrimary {
    NSString *imageName = nil;
    NSInteger numeric = positionCode.integerValue;
    if (isPrimary) {
        //      if ([@[@"11", @"12", @"13", @"21", @"22", @"23", @"41", @"42", @"43", @"31", @"32", @"33"] containsObject:positionCode]) {
        if ([@[@"p8", @"p7", @"p6", @"p9", @"p10", @"p11", @"p25", @"p26", @"p27", @"p24", @"p23", @"p22"] containsObject:positionCode]) {
            imageName = [NSString stringWithFormat:@"%ld_2.png", (long) numeric];
//        } else if ([@[@"14", @"15", @"44", @"45", @"24", @"25", @"33", @"34", @"35"] containsObject:positionCode]) {
        } else if ([@[@"p5", @"p4", @"p28", @"p29", @"p12", @"p13", @"p22", @"p21", @"p20"] containsObject:positionCode]) {
            imageName = [NSString stringWithFormat:@"%ld_2.png", (long) (numeric + 2)];
        }
    } else {
        imageName = [NSString stringWithFormat:@"%ld_2.png", (long) numeric];
    }

    return [UIImage imageNamed:imageName];
}


@end