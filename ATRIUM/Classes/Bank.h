//
//  Bank.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface Bank : BaseObject

@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *swiftCode;
@property (nonatomic, strong) NSString *sortCode;
@property (nonatomic, strong) NSString *ibanCode;
@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, strong) NSString *accountCode;
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *bankAddress;

@end
