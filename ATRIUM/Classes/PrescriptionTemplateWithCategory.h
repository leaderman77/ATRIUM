//
// Created by Sanch0 on 3/19/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PrescriptionTemplateWithCategory : NSObject

@property (nonatomic, strong) SelectItem *template;
@property (nonatomic, strong) SelectItem *category;

@end