//
//  QuantityView.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/22/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "QuantityView.h"

@interface QuantityView ()<UITextFieldDelegate> {
    UIButton *incBtn;
    UIButton *decBtn;
    UITextField *countTextField;
}

@end

@implementation QuantityView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, self.height)];
    [decBtn setTitle:@"-" forState:UIControlStateNormal];
    [decBtn setTitleColor:[UIColor blackColor]];
    [decBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [decBtn addTarget:self action:@selector(incDecBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    decBtn.titleLabel.font = FONT_SANSUMI(30);//[UIFont boldSystemFontOfSize:30];
    decBtn.tag = 1;
    countTextField = [[UITextField alloc] initWithFrame:CGRectMake(decBtn.right + 5, 0, 50, self.height)];
    [countTextField makeBorderWithCornerRadius];
    countTextField.keyboardType = UIKeyboardTypeNumberPad;
    countTextField.textAlignment = NSTextAlignmentCenter;
    countTextField.font = FONT_SANSUMI(15);//[UIFont systemFontOfSize:15];
//    countTextField.text = @"1";
    countTextField.delegate = self;
    [countTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    incBtn = [[UIButton alloc] initWithFrame:CGRectMake(countTextField.right + 5, 0, 30, self.height)];
    [incBtn setTitle:@"+" forState:UIControlStateNormal];
    [incBtn setTitleColor:[UIColor blackColor]];
     incBtn.titleLabel.font = FONT_SANSUMI_BOLD(25);//[UIFont boldSystemFontOfSize:25];
    [incBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    incBtn.tag = 2;
    [incBtn addTarget:self action:@selector(incDecBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:decBtn];
    [self addSubview:countTextField];
    [self addSubview:incBtn];
    self.count = 1;
}

- (void)dealloc {
    self.valueChangedBlock = nil;
}

- (void)setCount:(NSUInteger)count {
    if(count == 0) {
        count = 1;
    }
    _count = count;
    countTextField.text = [NSString stringWithFormat:@"%ld",(unsigned long)_count];
    if(self.valueChangedBlock) {
        self.valueChangedBlock(_count);
    }
}

- (void)incDecBtnClicked:(UIButton *)sender {
    if(sender.tag == 1) {
        if(self.count > 1) {
            self.count --;
        }
    } else {
        self.count ++;
    }
//    countTextField.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.count];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // allow backspace
//    if (!string.length && textField.text.length == 1)
//    {
//        return NO;
//    }
    // Prevent invalid character input, if keyboard is numberpad
    if (textField.keyboardType == UIKeyboardTypeNumberPad)
    {
        if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
        {
            // BasicAlert(@"", @"This field accepts only numeric entries.");
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidChange:(UITextField *)sender {
    if(sender.text.length == 0) {
        sender.text = @"1";
    }
    _count = [sender.text integerValue];
}

@end
