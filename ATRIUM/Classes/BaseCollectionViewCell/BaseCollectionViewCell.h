//
// Created by Sanch0 on 1/6/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseCollectionViewCell;


@protocol BaseCollectionViewCellDelegate <NSObject>

- (void)collectionViewCell:(BaseCollectionViewCell *)collectionViewCell didAction:(NSInteger)actionType withValue:(id)value;

@end

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id tagObject;
@property (nonatomic, weak) id <BaseCollectionViewCellDelegate> baseDelegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end