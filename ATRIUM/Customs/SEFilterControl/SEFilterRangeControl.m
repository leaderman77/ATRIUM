//
//  SEFilterRangeControl.m
//  iPadMotors
//
//  Created by Mirzohidbek on 12/6/13.
//
//

#import "SEFilterRangeControl.h"

#define LEFT_OFFSET 15
#define RIGHT_OFFSET 15
#define TITLE_SELECTED_DISTANCE 5
#define TITLE_FADE_ALPHA 1.0f
#define TITLE_FONT FONT_SANSUMI(15)
//[UIFont fontWithName:@"Helvetica Neue" size:15]
#define TITLE_SHADOW_COLOR [UIColor lightGrayColor]
//#define TITLE_COLOR [UIColor blackColor]
#define TITLE_COLOR titleColor
#define minHandlerTag 1501
#define maxHandlerTag 1502

@interface SEFilterRangeControl () {
    UIButton *minHandler;
    UIButton *maxHandler;
    CGPoint diffPoint;
    NSArray *titlesArr;
    float oneSlotSize;
    UIColor *titleColor;
    UIImageView *lineBG;
}
@end


@implementation SEFilterRangeControl
@synthesize minSelectedIndex, maxSelectedIndex, progressColor;

- (CGPoint)getCenterPointForIndex:(NSInteger)i {
    CGPoint point = CGPointMake((i / (float) (titlesArr.count - 1)) * (self.frame.size.width - RIGHT_OFFSET - LEFT_OFFSET) + LEFT_OFFSET, self.frame.size.height - 55);
    if (i % 2) {
        point.y += 55;
    }
    else {
        point.y -= 8;
    }
    return point;
}
//-(CGPoint)fixFinalPoint:(CGPoint)pnt{
//    if (pnt.x < LEFT_OFFSET-(handler.frame.size.width/2.f)) {
//        pnt.x = LEFT_OFFSET-(handler.frame.size.width/2.f);
//    }else if (pnt.x+(handler.frame.size.width/2.f) > self.frame.size.width-RIGHT_OFFSET){
//        pnt.x = self.frame.size.width-RIGHT_OFFSET- (handler.frame.size.width/2.f);
//    }
//    return pnt;
//}

- (CGPoint)fixFinalPoint:(CGPoint)pnt to:(UIButton *)btn {
    if (pnt.x < LEFT_OFFSET - (btn.frame.size.width / 2.f)) {
        pnt.x = LEFT_OFFSET - (btn.frame.size.width / 2.f);
    }
    else if (pnt.x + (btn.frame.size.width / 2.f) > self.frame.size.width - RIGHT_OFFSET) {
        pnt.x = self.frame.size.width - RIGHT_OFFSET - (btn.frame.size.width / 2.f);
    }
    return pnt;
}


- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 90)]) {
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArr = [[NSArray alloc] initWithArray:titles];
        [self setProgressColor:[UIColor colorWithRed:205 / 255.f green:205 / 255.f blue:205 / 255.f alpha:1]];
        UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ItemSelected:)];
        [self addGestureRecognizer:gest];
        [gest release];
        CGRect rect = self.frame;
        UIImage *image = [UIImage imageNamed:@"line_new.png"];
        lineBG = [[UIImageView alloc] initWithImage:image];
        [lineBG setFrame:CGRectMake(LEFT_OFFSET, rect.size.height - 31, rect.size.width - RIGHT_OFFSET - LEFT_OFFSET, 3.75)];
        [self addSubview:lineBG];
        minSelectedIndex = 0;
        maxSelectedIndex = titles.count - 1;
        int i;
        NSString *title;
        UILabel *lbl;
        oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
        for (i = 0; i < titlesArr.count; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_small_bg.png"]];
            imgView.tag = 100 + i;
            CGPoint point = [self getCenterPointForIndex:i];
            point.x = point.x - 1.5;
//            point.y = self.frame.size.height - 30;
//            imgView.center = point;
//            imgView.backgroundColor = [UIColor clearColor];
            [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
            [self addSubview:imgView];
            [imgView release];
            title = [titlesArr objectAtIndex:i];
            CGSize size = [title sizeWithFont:TITLE_FONT];
            //lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, oneSlotSize, 25)];
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 25)];
            //NSLog(@"size %f", oneSlotSize);
            [lbl setText:title];
            UIFont *font = FONT_SANSUMI(15);//[UIFont fontWithName:@"Helvetica Neue" size:15];
            [lbl setFont:font];
            [lbl setTextColor:TITLE_COLOR];
            //[lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
            //[lbl setAdjustsFontSizeToFitWidth:YES];
            //[lbl setMinimumFontSize:8];
            [lbl setTextAlignment:NSTextAlignmentCenter];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setTag:i + 50];

            if (i == 0 || i == titlesArr.count - 1) {
                [lbl setTextColor:[UIColor colorWithRed:25 / 255.0f green:111 / 256.0f blue:156 / 255.0f alpha:1]];
            }
            [lbl setCenter:[self getCenterPointForIndex:i]];
            //lbl.layer.borderWidth = 1;
            [self addSubview:lbl];
            [lbl release];
        }


        minHandler = [[UIButton alloc] initWithFrame:CGRectMake(LEFT_OFFSET, 10, 35, 55)];
        minHandler.tag = minHandlerTag;
        [minHandler setImage:[UIImage imageNamed:@"circle_big_bg_new.png"] forState:UIControlStateNormal];
        //[minHandler setFrame:CGRectMake(LEFT_OFFSET, 10, 35, 55)];
        [minHandler setAdjustsImageWhenHighlighted:NO];
        //[minHandler setFrame:CGRectMake(LEFT_OFFSET, 55 - 19.5f - (55 / 2), 35, 55)];
        [minHandler setCenter:CGPointMake(minHandler.center.x - (minHandler.frame.size.width / 2.f), self.frame.size.height - 19.5f)];
        [minHandler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [minHandler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [minHandler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        minHandler.imageEdgeInsets = UIEdgeInsetsMake(-1, -2, 22, 0);
        [self addSubview:minHandler];

        maxHandler = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - RIGHT_OFFSET, 10, 35, 55)];
        maxHandler.tag = maxHandlerTag;
        //[maxHandler setFrame:CGRectMake(self.frame.size.width - RIGHT_OFFSET, 10, 35, 55)];
        [maxHandler setImage:[UIImage imageNamed:@"circle_big_bg_new.png"] forState:UIControlStateNormal];

        [maxHandler setAdjustsImageWhenHighlighted:NO];
        [maxHandler setCenter:CGPointMake(maxHandler.center.x - (maxHandler.frame.size.width / 2.f), self.frame.size.height - 19.5f)];
        [maxHandler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
        [maxHandler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [maxHandler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        maxHandler.imageEdgeInsets = UIEdgeInsetsMake(-1, -2, 22, 0);
        [self addSubview:maxHandler];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //Fill Main Path
//    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
//    
//    CGContextFillRect(context, CGRectMake(LEFT_OFFSET, rect.size.height-31, rect.size.width-RIGHT_OFFSET-LEFT_OFFSET, 1));
//    
//    
//    CGContextSaveGState(context);
    return;
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
    int i;
    UILabel *lbl;
    for (i = 0; i < titlesArr.count; i++) {
        lbl = (UILabel *) [self viewWithTag:i + 50];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        CGPoint point = [self getCenterPointForIndex:i];
        if (i == maxSelectedIndex || minSelectedIndex == i) {
            if (i == titlesArr.count - 1) {
                point.x -= 5;
            }
//            CGPoint cen = [self getCenterPointForIndex:i];
            point.y += (i % 2) ? 5 : -5;
            [lbl setCenter:point];
            [lbl setTextColor:[UIColor colorWithRed:25 / 255.0f green:111 / 256.0f blue:156 / 255.0f alpha:1]];
        } else {
            if (i == titlesArr.count - 1) {
                point.x -= 5;
            }
            [lbl setCenter:point];
            [lbl setTextColor:TITLE_COLOR];
        }
        [UIView commitAnimations];
    }
}

- (void)animateHandler:(UIButton *)handler ToIndex:(NSInteger)index {
    CGPoint toPoint = [self getCenterPointForIndex:index];
    toPoint = CGPointMake(toPoint.x - (handler.frame.size.width / 2.f), handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint to:handler];
    [UIView beginAnimations:nil context:nil];
    [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];
    [UIView commitAnimations];
}

- (void)setSelectedIndex:(int)minIndex and:(int)maxIndex {
    [self setSelectedIndex:minIndex withHandler:minHandler];
    [self setSelectedIndex:maxIndex withHandler:maxHandler];
}

- (void)setSelectedIndex:(int)index withHandler:(UIButton *)handler {
    if (handler.tag == minHandlerTag) {
        minSelectedIndex = index;
    }
    else {
        maxSelectedIndex = index;
    }
    [self animateTitlesToIndex:index];
    [self animateHandler:handler ToIndex:index];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (int)getSelectedTitleInPoint:(CGPoint)pnt {
    return round((pnt.x - LEFT_OFFSET) / oneSlotSize);
}

- (void)ItemSelected:(UITapGestureRecognizer *)tap {
    int index = [self getSelectedTitleInPoint:[tap locationInView:self]];
    if (index <= maxSelectedIndex && index >= minSelectedIndex) {
        return;
    }
    if (maxSelectedIndex < index) {
        [self setSelectedIndex:index withHandler:maxHandler];
        maxSelectedIndex = index;
    }
    else {
        [self setSelectedIndex:index withHandler:minHandler];
        minSelectedIndex = index;
    }

    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)TouchUp:(SEFilterKnob *)btn {
    NSInteger index = [self getSelectedTitleInPoint:btn.center];
//    if((btn.tag == maxHandlerTag && maxSelectedIndex == index || (btn.tag == minHandlerTag && minSelectedIndex == index))
//       {
//           [self animateHandler:btn ToIndex:index];
//           [self animateTitlesToIndex:index];
//           return;
//       }
    if (btn.tag == maxHandlerTag) {
        index = maxSelectedIndex;
    }
    else {
        index = minSelectedIndex;
    }
    [self animateHandler:btn ToIndex:index];
    [self animateTitlesToIndex:index];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)TouchMove:(SEFilterKnob *)handler withEvent:(UIEvent *)ev {
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    CGPoint toPoint = CGPointMake(currPoint.x - diffPoint.x, handler.frame.origin.y);

    toPoint = [self fixFinalPoint:toPoint to:handler];
    if (handler.tag == maxHandlerTag) {
        if (toPoint.x < (minSelectedIndex) * oneSlotSize + LEFT_OFFSET + 15) {
            [self sendActionsForControlEvents:UIControlEventTouchDragInside];
            return;
        }
    }
    else if (toPoint.x > (maxSelectedIndex) * oneSlotSize - 21) {
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
        return;
    }
    [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];
    int selected = [self getSelectedTitleInPoint:handler.center];
    if (handler.tag == maxHandlerTag) {
        maxSelectedIndex = selected;
    }
    else {
        minSelectedIndex = selected;
    }
    [self animateTitlesToIndex:selected];
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}

- (void)dealloc {
    [minHandler removeTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [minHandler removeTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [minHandler removeTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    [minHandler release];

    [maxHandler removeTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [maxHandler removeTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [maxHandler removeTarget:self action:@selector(TouchMove:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    [maxHandler release];
    [titlesArr release];
    [progressColor release];
    [super dealloc];
}

- (void)setupPostions:(CGRect)newFrame {
    if (CGRectEqualToRect(self.frame, newFrame)) {
        return;
    }
    [self setFrame:newFrame];
    CGRect rectim = lineBG.frame;
    rectim.size.width = newFrame.size.width - RIGHT_OFFSET - LEFT_OFFSET;
    [lineBG setFrame:rectim];
    oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
    for (int i = 0; i < titlesArr.count; i++) {
        UIImageView *imgView = (UIImageView *) [self viewWithTag:100 + i];

        CGPoint point = [self getCenterPointForIndex:i];
        point.x = point.x - 1.5;
//        point.y = self.frame.size.height - 30;
//        imgView.center = point;
        [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
        UILabel *lbl = (UILabel *) [self viewWithTag:50 + i];
        point = [self getCenterPointForIndex:i];
        if (i == minSelectedIndex) {
            if (i % 2) {
                point.y += 5;
            }
            else {
                point.y -= 5;
            }
        }
        else if (i == maxSelectedIndex) {
            if (i % 2) {
                point.y += 5;
            }
            else {
                point.y -= 5;
            }
        }
        [lbl setCenter:point];
    }
    [self setSelectedIndex:minSelectedIndex and:maxSelectedIndex];
}

- (void)setupPositionsWithoutValueChange:(CGRect)newFrame {
    if (CGRectEqualToRect(self.frame, newFrame)) {
        return;
    }
    [self setFrame:newFrame];
    CGRect rectim = lineBG.frame;
    rectim.size.width = newFrame.size.width - RIGHT_OFFSET - LEFT_OFFSET;
    [lineBG setFrame:rectim];
    oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
    for (int i = 0; i < titlesArr.count; i++) {
        UIImageView *imgView = (UIImageView *) [self viewWithTag:100 + i];

        CGPoint point = [self getCenterPointForIndex:i];
        point.x = point.x - 1.5;
        //        point.y = self.frame.size.height - 30;
        //        imgView.center = point;
        [imgView setFrame:CGRectMake(point.x - 19 / 2.0, 50, 19, 21)];
        UILabel *lbl = (UILabel *) [self viewWithTag:50 + i];
        point = [self getCenterPointForIndex:i];
        if (i == minSelectedIndex) {
            if (i % 2) {
                point.y += 5;
            }
            else {
                point.y -= 5;
            }
        }
        else if (i == maxSelectedIndex) {
            if (i % 2) {
                point.y += 5;
            }
            else {
                point.y -= 5;
            }
        }
        [lbl setCenter:point];
    }


    [self animateTitlesToIndex:minSelectedIndex];
    [self animateHandler:minHandler ToIndex:minSelectedIndex];
    [self animateTitlesToIndex:maxSelectedIndex];
    [self animateHandler:maxHandler ToIndex:maxSelectedIndex];
//    [self setSelectedIndex:minSelectedIndex and:maxSelectedIndex];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
