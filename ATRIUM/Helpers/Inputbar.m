//
//  Inputbar.h
//  Whatsapp
//
//  Created by Rafael Castro on 7/11/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import "Inputbar.h"
#import "HPGrowingTextView.h"

@interface Inputbar() <HPGrowingTextViewDelegate>
@property (nonatomic, strong) HPGrowingTextView *textView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *takePhotoButton;
@end

#define RIGHT_BUTTON_SIZE 60
#define LEFT_BUTTON_SIZE 45

@implementation Inputbar

-(id)init
{
    self = [super init];
    if (self)
    {
        [self addContent];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    {
        [self addContent];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self addContent];
    }
    return self;
}
-(void)addContent
{
    [self addTextView];
    [self addRightButton];
//    [self addLeftButton];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}
-(void)addTextView
{
    CGSize size = self.frame.size;
    _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(5,
                                                                    20,
                                                                    size.width - RIGHT_BUTTON_SIZE - 50,
                                                                    size.height)];
    _textView.isScrollable = NO;
    _textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    _textView.minNumberOfLines = 1;
    _textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
    _textView.returnKeyType = UIReturnKeyGo; //just as an example
    _textView.font = [UIFont systemFontOfSize:15.0f];
    _textView.delegate = self;
    _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    _textView.backgroundColor = [UIColor clearColor];  //rgbColor(228, 239, 243);     //[UIColor whiteColor];
    _textView.placeholder = _placeholder;
    
    //textView.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.returnKeyType = UIReturnKeyDefault;
    _textView.enablesReturnKeyAutomatically = YES;
    //textView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, -1.0, 0.0, 1.0);
    //textView.textContainerInset = UIEdgeInsetsMake(8.0, 4.0, 8.0, 0.0);
//    _textView.layer.cornerRadius = 5.0;
//    _textView.layer.borderWidth = 0.5;
//    _textView.layer.borderColor =  [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
    
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [self addSubview:_textView];
}
-(void)addRightButton
{
    CGSize size = self.frame.size;
    
    self.takePhotoButton = [[UIButton alloc] init];
    self.takePhotoButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    self.takePhotoButton.frame = CGRectMake(size.width - RIGHT_BUTTON_SIZE - 40, 25, RIGHT_BUTTON_SIZE - 37, size.height - 40);
    [self.takePhotoButton setImage:[UIImage imageNamed:@"attach_photo.png"] forState:UIControlStateNormal];
    [self.takePhotoButton addTarget:self action:@selector(didPressTakePhotoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.takePhotoButton];
    
    [self.takePhotoButton setSelected:YES];
    
    self.rightButton = [[UIButton alloc] init];
    self.rightButton.frame = CGRectMake(size.width - RIGHT_BUTTON_SIZE + 10, 25, RIGHT_BUTTON_SIZE - 37, size.height - 40);
    self.rightButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
//    [self.rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
//    [self.rightButton setTitle:@"Done" forState:UIControlStateNormal];
//    self.rightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    [self.rightButton setImage:[UIImage imageNamed:@"send.png"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(didPressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.rightButton];
    
    [self.rightButton setSelected:YES];
    
}
-(void)addLeftButton
{
    CGSize size = self.frame.size;
    self.leftButton = [[UIButton alloc] init];
    self.leftButton.frame = CGRectMake(0, 0, LEFT_BUTTON_SIZE, size.height);
    self.leftButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.leftButton setImage:self.leftButtonImage forState:UIControlStateNormal];
    
    [self.leftButton addTarget:self action:@selector(didPressLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.leftButton];
}
-(void)resignFirstResponder
{
    [_textView resignFirstResponder];
}
-(NSString *)text
{
    return _textView.text;
}


#pragma mark - Delegate

-(void)didPressRightButton:(UIButton *)sender
{
    if (self.rightButton.isSelected) return;
    
    [self.delegate inputbarDidPressRightButton:self];
    self.textView.text = @"";
}
-(void)didPressTakePhotoButton:(UIButton *)sender
{
    if (self.takePhotoButton.isSelected) return;
    
    [self.delegate inputbarDidPressTakePhotButton:self];
    self.textView.text = @"";
}
-(void)didPressLeftButton:(UIButton *)sender
{
    [self.delegate inputbarDidPressLeftButton:self];
}

#pragma mark - Set Methods

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textView.placeholder = placeholder;
}
-(void)setLeftButtonImage:(UIImage *)leftButtonImage
{
    [self.leftButton setImage:leftButtonImage forState:UIControlStateNormal];
}
-(void)setRightButtonImage:(UIImage *)rightButtonImage
{
    [self.leftButton setImage:rightButtonImage forState:UIControlStateNormal];
}
-(void)setRightButtonTextColor:(UIColor *)righButtonTextColor
{
    [self.rightButton setTitleColor:righButtonTextColor forState:UIControlStateNormal];
}
-(void)setRightButtonText:(NSString *)rightButtonText
{
    [self.rightButton setTitle:rightButtonText forState:UIControlStateNormal];
}

#pragma mark - TextViewDelegate

-(void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputbarDidChangeHeight:)])
    {
        [self.delegate inputbarDidChangeHeight:self.frame.size.height];
    }
}
-(void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputbarDidBecomeFirstResponder:)])
    {
        [self.delegate inputbarDidBecomeFirstResponder:self];
    }
}
- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    NSString *text = [growingTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([text isEqualToString:@""])
        [self.rightButton setSelected:YES];
    else
        [self.rightButton setSelected:NO];
}

@end
