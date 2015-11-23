//
//  SEFilterControl.m
//  SEFilterControl_Test
//
//  Created by Shady A. Elyaski on 6/13/12.
//  Copyright (c) 2012 mash, ltd. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SEFilterControl.h"

#define LEFT_OFFSET 25
#define RIGHT_OFFSET 25
#define TITLE_SELECTED_DISTANCE 5
#define TITLE_FADE_ALPHA 1.0f
//#define TITLE_FONT [UIFont fontWithName:@"Helvetica Neue" size:15]
#define TITLE_FONT FONT_SANSUMI(15)
#define TITLE_SHADOW_COLOR [UIColor lightGrayColor]
#define TITLE_COLOR [UIColor blackColor]

//#define TITLE_COLOR [UIColor blackColor]
@interface SEFilterControl () {
    SEFilterKnob *handler;
    CGPoint diffPoint;
    NSArray *titlesArr;
    NSArray *activeImagesArray;
    float oneSlotSize;
    UIColor *titleColor;
    UIImageView *lineBG;
}

@end

@implementation SEFilterControl
@synthesize SelectedIndex, progressColor;

- (CGPoint)getCenterPointForIndex:(NSInteger)i {
    CGPoint point = CGPointMake((i / (float) (titlesArr.count - 1)) * (self.frame.size.width - RIGHT_OFFSET - LEFT_OFFSET) + LEFT_OFFSET, self.frame.size.height - 55);
    if (self.labelValuePosition == kTopBottomPosition) {
        if (i % 2) {
            point.y += 55;
        }
        else {
            point.y -= 8;
        }
    } else if (self.labelValuePosition == kTopPosition) {
        point.y -= 8;
    } else if (self.labelValuePosition == kBottomPosition) {
        point.y += 55;
    }

    return point;
}

- (CGPoint)fixFinalPoint:(CGPoint)pnt {
    if (pnt.x < LEFT_OFFSET - (handler.frame.size.width / 2.f)) {
        pnt.x = LEFT_OFFSET - (handler.frame.size.width / 2.f);
    } else if (pnt.x + (handler.frame.size.width / 2.f) > self.frame.size.width - RIGHT_OFFSET) {
        pnt.x = self.frame.size.width - RIGHT_OFFSET - (handler.frame.size.width / 2.f);
    }
    return pnt;
}

- (id)initWithFrame:(CGRect)frame imageNames:(NSArray *)titles and:(NSArray *)activImages {
    self.itemsIsImage = YES;
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 90)]) {
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        activeImagesArray = [[NSArray alloc] initWithArray:activImages];
        CGRect rect = self.frame;
        UIImage *image = [UIImage imageNamed:@"line_new.png"];
        lineBG = [[UIImageView alloc] initWithImage:image];
        [lineBG setFrame:CGRectMake(LEFT_OFFSET, rect.size.height - 31, rect.size.width - RIGHT_OFFSET - LEFT_OFFSET, 3.75)];
        [self addSubview:lineBG];
        //[self setProgressColor:[UIColor colorWithRed:157/255.f green:157/255.f blue:157/255.f alpha:1]];
        [self setProgressColor:[UIColor colorWithRed:205 / 255.f green:205 / 255.f blue:205 / 255.f alpha:1]];
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        [gest release];
        int i;
        NSString *title;
        oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);


        for (i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_small_bg.png"]];
            imgView.tag = 100 + i;

            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
//            point.y = self.frame.size.height - 30;
//            imgView.center = point;
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            imgView.backgroundColor = [UIColor clearColor];
            [self addSubview:imgView];
            [imgView release];
            title = [titlesArr objectAtIndex:i];
            if (i == 0) {
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, oneSlotSize, 25)];
                title = [titlesArr objectAtIndex:0];
                [lbl setText:title];
                [lbl setFont:TITLE_FONT];
                //[lbl setShadowColor:TITLE_SHADOW_COLOR];
                [lbl setTextColor:TITLE_COLOR];
                //[lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
                //[lbl setAdjustsFontSizeToFitWidth:YES];
                //[lbl setMinimumFontSize:8];
                [lbl setTextAlignment:NSTextAlignmentCenter];
                //[lbl setShadowOffset:CGSizeMake(0, 1)];
                [lbl setBackgroundColor:[UIColor clearColor]];
                [lbl setTag:50];
                [lbl setCenter:[self getCenterPointForIndex:0]];
                [self addSubview:lbl];
                [lbl release];
            }
            else {
                UIImage *img = [UIImage imageNamed:title];
                imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, 25)];
                [imgView setImage:img];
                [imgView setTag:i + 50];
                [imgView setCenter:[self getCenterPointForIndex:i]];
                [self addSubview:imgView];
                [imgView release];
            }
        }
        handler = [[SEFilterKnob buttonWithType:UIButtonTypeCustom] retain];
        [handler setFrame:CGRectMake(LEFT_OFFSET, 10, 35, 55)];
        [handler setAdjustsImageWhenHighlighted:NO];
        [handler setCenter:CGPointMake(handler.center.x - (handler.frame.size.width / 2.f), self.frame.size.height - 19.5f)];
        [handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        [self addSubview:handler];

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 90)]) {
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        [self setProgressColor:[UIColor colorWithRed:205 / 255.f green:205 / 255.f blue:205 / 255.f alpha:1]];
        CGRect rect = self.frame;
        UIImage *image = [UIImage imageNamed:@"line_new.png"];
        lineBG = [[UIImageView alloc] initWithImage:image];
        [lineBG setFrame:CGRectMake(LEFT_OFFSET, rect.size.height - 31, rect.size.width - RIGHT_OFFSET - LEFT_OFFSET, 3.75)];
        [self addSubview:lineBG];

        //[self setProgressColor:[UIColor colorWithRed:157/255.f green:157/255.f blue:157/255.f alpha:1]];

        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        [gest release];


//        UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_small_bg.png"]];
//        //imgView.center = CGPointMake(30, 45);
//        [imgView setFrame:CGRectMake(45, 50, 19, 21)];
//        [self addSubview:imgView];
//        [imgView release];
        int i;
        NSString *title;
        UILabel *lbl;
        oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
        for (i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_small_bg.png"]];
            imgView.tag = 100 + i;
            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
            point.y = self.frame.size.height - 30;
            point.y = 50;
            //imgView.center = point;
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            //imgView.backgroundColor = [UIColor clearColor];
            [self addSubview:imgView];
            [imgView release];
            title = [titlesArr objectAtIndex:i];
            UIFont *font = FONT_SANSUMI(15);
            if (!font) {
                NSLog(@"dssdf");
            }
            CGSize size = [title sizeWithFont:font];
            //NSLog(@"size %f", size.width);
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 25)];
            //NSLog(@"size %f", oneSlotSize);
            [lbl setText:title];
            [lbl setFont:font];
            [lbl setTextColor:TITLE_COLOR];
            //[lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
            //[lbl setAdjustsFontSizeToFitWidth:YES];
            //[lbl setMinimumFontSize:8];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            //[lbl setShadowOffset:CGSizeMake(0, 1)];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setTag:i + 50];
            if (!i) {
                [lbl setTextColor:[UIColor colorWithRed:25 / 255.0f green:111 / 256.0f blue:156 / 255.0f alpha:1]];
            }

            [lbl setCenter:[self getCenterPointForIndex:i]];
            lbl.left--;
            [self addSubview:lbl];
            [lbl release];
        }

        handler = [[SEFilterKnob buttonWithType:UIButtonTypeCustom] retain];
        [handler setFrame:CGRectMake(LEFT_OFFSET, 10, 35, 55)];
        [handler setAdjustsImageWhenHighlighted:NO];
        [handler setCenter:CGPointMake(handler.center.x - (handler.frame.size.width / 2.f), self.frame.size.height - 19.5f)];
        [handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        [self addSubview:handler];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles withLabelValuePosition:(LabelValuePosition)position {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 90)]) {
        self.labelValuePosition = position;
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        [self setProgressColor:[UIColor colorWithRed:205 / 255.f green:205 / 255.f blue:205 / 255.f alpha:1]];
        CGRect rect = self.frame;
        UIImage *image = [UIImage imageNamed:@"line_new.png"];
        lineBG = [[UIImageView alloc] initWithImage:image];
        [lineBG setFrame:CGRectMake(LEFT_OFFSET, rect.size.height - 31, rect.size.width - RIGHT_OFFSET - LEFT_OFFSET, 3.75)];
        [self addSubview:lineBG];

        //[self setProgressColor:[UIColor colorWithRed:157/255.f green:157/255.f blue:157/255.f alpha:1]];

        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        [gest release];


//        UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_small_bg.png"]];
//        //imgView.center = CGPointMake(30, 45);
//        [imgView setFrame:CGRectMake(45, 50, 19, 21)];
//        [self addSubview:imgView];
//        [imgView release];
        int i;
        NSString *title;
        UILabel *lbl;
        oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
        for (i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_small_bg.png"]];
            imgView.tag = 100 + i;
            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
            point.y = self.frame.size.height - 30;
            point.y = 50;
            //imgView.center = point;
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            //imgView.backgroundColor = [UIColor clearColor];
            [self addSubview:imgView];
            [imgView release];
            title = [titlesArr objectAtIndex:i];
            UIFont *font = FONT_SANSUMI(15);
            if (!font) {
                NSLog(@"dssdf");
            }
            CGSize size = [title sizeWithFont:font];
            //NSLog(@"size %f", size.width);
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 25)];
            //NSLog(@"size %f", oneSlotSize);
            [lbl setText:title];
            [lbl setFont:font];
            [lbl setTextColor:TITLE_COLOR];
            //[lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
            //[lbl setAdjustsFontSizeToFitWidth:YES];
            //[lbl setMinimumFontSize:8];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            //[lbl setShadowOffset:CGSizeMake(0, 1)];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setTag:i + 50];
            if (!i) {
                [lbl setTextColor:[UIColor colorWithRed:25 / 255.0f green:111 / 256.0f blue:156 / 255.0f alpha:1]];
            }

            [lbl setCenter:[self getCenterPointForIndex:i]];
            lbl.left--;
            [self addSubview:lbl];
            [lbl release];
        }

        handler = [[SEFilterKnob buttonWithType:UIButtonTypeCustom] retain];
        [handler setFrame:CGRectMake(LEFT_OFFSET, 10, 35, 55)];
        [handler setAdjustsImageWhenHighlighted:NO];
        [handler setCenter:CGPointMake(handler.center.x - (handler.frame.size.width / 2.f), self.frame.size.height - 19.5f)];
        [handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        [self addSubview:handler];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Fill Main Path

    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height - 31, rect.size.width - RIGHT_OFFSET - LEFT_OFFSET, 2));

    CGContextSaveGState(context);
    return;
}

- (void)setHandlerColor:(UIColor *)color {
    [handler setHandlerColor:color];
}

- (void)TouchDown:(UIButton *)btn withEvent:(UIEvent *)ev {
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    diffPoint = CGPointMake(currPoint.x - btn.frame.origin.x, currPoint.y - btn.frame.origin.y);
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)setTitlesColor:(UIColor *)color {
    [titleColor release];
    titleColor = [color retain];
    return;
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *) [self viewWithTag:i + 50];
        [lbl setTextColor:color];
    }
}

- (void)setTitlesFont:(UIFont *)font {
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *) [self viewWithTag:i + 50];
        [lbl setFont:font];
    }
}

- (void)animateTitlesToIndex:(NSInteger)index {

    if (self.itemsIsImage) {
        int i;
        UILabel *lbl;
        if (index == 0) {
            lbl = (UILabel *) [self viewWithTag:50];
            CGPoint cen = [self getCenterPointForIndex:0];
            cen.y -= 5;
            [lbl setCenter:cen];
            [lbl setTextColor:[UIColor colorWithRed:25 / 255.0f green:111 / 256.0f blue:156 / 255.0f alpha:1]];
        }
        else {
            lbl = (UILabel *) [self viewWithTag:50];
            [lbl setTextColor:titleColor];
            [lbl setCenter:[self getCenterPointForIndex:0]];
        }
        UIImageView *img;
        for (i = 1; i < titlesArr.count; i++) {
            img = (UIImageView *) [self viewWithTag:i + 50];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationBeginsFromCurrentState:YES];
            if (i == index) {
                [img setImage:[UIImage imageNamed:[activeImagesArray objectAtIndex:i]]];
                CGPoint cen = [self getCenterPointForIndex:i];
                if (self.labelValuePosition == kTopBottomPosition) {
                    cen.y += (i % 2) ? 5 : -5;
                } else {
                    cen.y += self.labelValuePosition == kBottomPosition ? 5 : -5;
                }
                [img setCenter:cen];
            }
            else {
                [img setImage:[UIImage imageNamed:[titlesArr objectAtIndex:i]]];
                [img setCenter:[self getCenterPointForIndex:i]];
            }
            [UIView commitAnimations];
        }
    }
    else {
        int i;
        UILabel *lbl;
        for (i = 0; i < titlesArr.count; i++) {
            lbl = (UILabel *) [self viewWithTag:i + 50];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationBeginsFromCurrentState:YES];
            if (i == index) {
                CGPoint cen = [self getCenterPointForIndex:i];
                if (self.labelValuePosition == kTopBottomPosition) {
                    cen.y += (i % 2) ? 5 : -5;
                } else {
                    cen.y += self.labelValuePosition == kBottomPosition ? 5 : -5;
                }

                [lbl setCenter:cen];
                [lbl setTextColor:[UIColor colorWithRed:25 / 255.0f green:111 / 256.0f blue:156 / 255.0f alpha:1]];
            } else {
                //[lbl setCenter:CGPointMake(lbl.center.x, self.frame.size.height-55)];
                [lbl setCenter:[self getCenterPointForIndex:i]];

                [lbl setAlpha:TITLE_FADE_ALPHA];
                [lbl setTextColor:titleColor];
            }
            [UIView commitAnimations];
        }
    }
}

- (void)animateHandlerToIndex:(NSInteger)index {
    CGPoint toPoint = [self getCenterPointForIndex:index];
    toPoint = CGPointMake(toPoint.x - (handler.frame.size.width / 2.f), handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint];

    [UIView beginAnimations:nil context:nil];
    [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];
    [UIView commitAnimations];
}

- (void)setSelectedIndex:(NSInteger)index {
    SelectedIndex = index;
    [self animateTitlesToIndex:index];
    [self animateHandlerToIndex:index];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setNewSelectedIndex:(NSUInteger)index {
    SelectedIndex = index;
    [self animateTitlesToIndex:index];
    [self animateHandlerToIndex:index];
}

- (int)getSelectedTitleInPoint:(CGPoint)pnt {
    return round((pnt.x - LEFT_OFFSET) / oneSlotSize);
}

- (void)ItemSelected:(UITapGestureRecognizer *)tap {
    SelectedIndex = [self getSelectedTitleInPoint:[tap locationInView:self]];
    [self setSelectedIndex:SelectedIndex];

    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)TouchUp:(UIButton *)btn {

    SelectedIndex = [self getSelectedTitleInPoint:btn.center];
    [self animateHandlerToIndex:SelectedIndex];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)TouchMove:(UIButton *)btn withEvent:(UIEvent *)ev {
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];

    CGPoint toPoint = CGPointMake(currPoint.x - diffPoint.x, handler.frame.origin.y);

    toPoint = [self fixFinalPoint:toPoint];

    [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];

    int selected = [self getSelectedTitleInPoint:btn.center];
    [self animateTitlesToIndex:selected];

    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}

- (void)setupPositions:(CGRect)newFrame {
    [self setFrame:newFrame];
    CGRect rectim = lineBG.frame;
    rectim.size.width = newFrame.size.width - RIGHT_OFFSET - LEFT_OFFSET;
    [lineBG setFrame:rectim];
    oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
    if (self.itemsIsImage) {
        for (int i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = (UIImageView *) [self viewWithTag:100 + i];
            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
            //point.y = self.frame.size.height - 30;
            //imgView.center = point;
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            if (i == 0) {
                UILabel *lbl = (UILabel *) [self viewWithTag:50];
                point = [self getCenterPointForIndex:i];
                if (i == SelectedIndex) {
                    if (i % 2) {
                        point.y += 5;
                    }
                    else {
                        point.y -= 5;
                    }
                }
                [lbl setCenter:point];
            }
            else {
                imgView = (UIImageView *) [self viewWithTag:50 + i];
                point = [self getCenterPointForIndex:i];
                if (i == SelectedIndex) {
                    if (i % 2) {
                        point.y += 5;
                    }
                    else {
                        point.y -= 5;
                    }
                }
                [imgView setCenter:point];
            }
        }
    }
    else {
        for (int i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = (UIImageView *) [self viewWithTag:100 + i];
            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
            point.y = self.frame.size.height - 30;
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            //  imgView.center = point;
            UILabel *lbl = (UILabel *) [self viewWithTag:50 + i];
            point = [self getCenterPointForIndex:i];
            if (i == SelectedIndex) {
                if (i % 2) {
                    point.y += 5;
                }
                else {
                    point.y -= 5;
                }
            }
            [lbl setCenter:point];
        }
    }
    [self setSelectedIndex:SelectedIndex];
}

- (void)setupPositionsWithoutChangeValue:(CGRect)newFrame {
    [self setFrame:newFrame];
    CGRect rectim = lineBG.frame;
    rectim.size.width = newFrame.size.width - RIGHT_OFFSET - LEFT_OFFSET;
    [lineBG setFrame:rectim];
    oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
    if (self.itemsIsImage) {
        for (int i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = (UIImageView *) [self viewWithTag:100 + i];
            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
            //point.y = self.frame.size.height - 30;
            //imgView.center = point;
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            if (i == 0) {
                UILabel *lbl = (UILabel *) [self viewWithTag:50];
                point = [self getCenterPointForIndex:i];
                if (i == SelectedIndex) {
                    if (i % 2) {
                        point.y += 5;
                    }
                    else {
                        point.y -= 5;
                    }
                }
                [lbl setCenter:point];
            }
            else {
                imgView = (UIImageView *) [self viewWithTag:50 + i];
                point = [self getCenterPointForIndex:i];
                if (i == SelectedIndex) {
                    if (i % 2) {
                        point.y += 5;
                    }
                    else {
                        point.y -= 5;
                    }
                }
                [imgView setCenter:point];
            }
        }
    }
    else {
        for (int i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = (UIImageView *) [self viewWithTag:100 + i];
            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
            point.y = self.frame.size.height - 30;
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            //  imgView.center = point;
            UILabel *lbl = (UILabel *) [self viewWithTag:50 + i];
            point = [self getCenterPointForIndex:i];
            if (i == SelectedIndex) {
                if (i % 2) {
                    point.y += 5;
                }
                else {
                    point.y -= 5;
                }
            }
            [lbl setCenter:point];
        }
    }
//    SelectedIndex = index;
//    [self animateTitlesToIndex:index];
//    [self animateHandlerToIndex:index];
//    [self setSelectedIndex:SelectedIndex];
}

- (void)dealloc {
    [handler removeTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [handler removeTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [handler removeTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    [handler release];
    [titlesArr release];
    [progressColor release];
    [super dealloc];
}

@end