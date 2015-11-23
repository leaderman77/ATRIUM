//
// Created by Sanch0 on 12/12/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "BaseGridViewCell.h"
#import "PFGridView.h"

@implementation BaseGridViewCell {

}

+ (instancetype)gridViewCellForGridView:(PFGridView *)gridView withItem:(id)item {
    static NSString *identifier = @"BaseGridViewCell";
    BaseGridViewCell *cell = (BaseGridViewCell *) [gridView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BaseGridViewCell alloc] initWithReuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundColor = [UIColor clearColor];
    return cell;
}

@end