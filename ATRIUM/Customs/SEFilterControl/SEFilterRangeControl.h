//
//  SEFilterRangeControl.h
//  iPadMotors
//
//  Created by Mirzohidbek on 12/6/13.
//
//

#import <UIKit/UIKit.h>
#import "SEFilterKnob.h"


@interface SEFilterRangeControl : UIControl
- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles;

- (void)setSelectedIndex:(int)minIndex and:(int)maxIndex;

- (void)setTitlesColor:(UIColor *)color;

- (void)setTitlesFont:(UIFont *)font;

- (void)setupPostions:(CGRect)newFrame;

- (void)setupPositionsWithoutValueChange:(CGRect)newFrame;

@property (nonatomic, retain) UIColor *progressColor;
@property (nonatomic, readonly) NSInteger minSelectedIndex;
@property (nonatomic, readonly) NSInteger maxSelectedIndex;
@end
