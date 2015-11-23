//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TreatmentItem : SelectItem

@property (nonatomic, strong) NSNumber *sortNo;
@property (nonatomic, strong) NSString *descrip2;
@property (nonatomic, strong) NSNumber *principalDiagnosisCodeId;
@property (nonatomic, strong) NSNumber *secondaryDiagnosisCodeId;
@property (nonatomic, strong) NSURL<Ignore> *favoriteImageUrl;
//- (SelectItem *)toSelectItem;
@end