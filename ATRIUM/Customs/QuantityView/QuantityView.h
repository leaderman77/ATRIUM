//
//  QuantityView.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/22/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CountValueChanged)(NSUInteger count);

@interface QuantityView : UIView



@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, copy) CountValueChanged valueChangedBlock;;
@end
