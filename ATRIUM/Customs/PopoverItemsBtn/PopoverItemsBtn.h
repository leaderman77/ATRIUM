//
// Created by Sanch0 on 1/20/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PopoverItemsBtn : CustomBtn

@property (nonatomic, strong) NSString *popoverTitle;
@property (nonatomic, strong) NSArray *popoverItems;
@property (nonatomic, strong) NSNumber *selectedIndex;

@end