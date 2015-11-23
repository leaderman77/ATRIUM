//
//  ChatsBottomView.m
//  ATRIUM
//
//  Created by Admin on 10/13/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "ChatsBottomView.h"
@interface ChatsBottomView() <UITextFieldDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *searchContactsTextFiled;
@property (nonatomic, strong) UITextField *searchGroupsTextFiled;
@end

@implementation ChatsBottomView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}
- (void)createAndLayoutTopNavigationView {
    padding = 10.f;
    top = 20.f;
//    height = kPortraitNavbarHeight;
    //TOP NAVIGATION VIEW
//    self.topNavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kPortraitNavbarHeight + top)];
    self.topNavigationView.backgroundColor = rgbColor(22, 168, 235);
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding, top, 80, height)];
    backBtn.tag = 1;
    
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    backBtn.titleLabel.font = FONT_SANSUMI_BOLD(15.f);
    backBtn.title = [TRANSLATE(@"Back") uppercaseString];
    backBtn.image = [UIImage imageNamed:@"back_white.png"];
    [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topNavigationView addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, 235, height)];
    titleLabel.tag = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = FONT_SANSUMI(18);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [TRANSLATE(self.title) uppercaseString];
    titleLabel.left = 0.5 * (self.topNavigationView.width - titleLabel.width);
    [self.topNavigationView addSubview:titleLabel];
    [self addSubview:self.topNavigationView];
}
- (void)createAndLayoutSubviews {
    [super createAndLayoutSubviews];
    self.backgroundColor = rgbColor(22, 168, 235);
    
    self.searchContactsTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 70, 350, 30)];
    self.searchContactsTextFiled.placeholder = [TRANSLATE(@"Search contacts") uppercaseString];
    self.searchContactsTextFiled.delegate = self;
    self.searchContactsTextFiled.font = FONT_SANSUMI(16);
    self.searchContactsTextFiled.textColor = [UIColor whiteColor];
    self.searchContactsTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[TRANSLATE(@"Search contacts") uppercaseString] attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.searchContactsTextFiled.leftView = paddingView;
    self.searchContactsTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.searchContactsTextFiled.layer.cornerRadius = 5.f;
    self.searchContactsTextFiled.layer.masksToBounds = YES;
    self.searchContactsTextFiled.returnKeyType = UIReturnKeyNext;
    [self.searchContactsTextFiled addBottomBorderWithHeight:1.f andColor:rgbColorWithAlpha(255, 255, 255, 0.7)];
    [self addSubview:self.searchContactsTextFiled];

    self.searchGroupsTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 300, 350, 30)];
    self.searchGroupsTextFiled.placeholder = [TRANSLATE(@"Search groups") uppercaseString];
    self.searchGroupsTextFiled.delegate = self;
    self.searchGroupsTextFiled.font = FONT_SANSUMI(16);
    self.searchGroupsTextFiled.textColor = [UIColor whiteColor];
    self.searchGroupsTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[TRANSLATE(@"Search groups") uppercaseString] attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.searchGroupsTextFiled.leftView = paddingView1;
    self.searchGroupsTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.searchGroupsTextFiled.layer.cornerRadius = 5.f;
    self.searchGroupsTextFiled.layer.masksToBounds = YES;
    self.searchGroupsTextFiled.returnKeyType = UIReturnKeyNext;
    [self.searchGroupsTextFiled addBottomBorderWithHeight:1.f andColor:rgbColorWithAlpha(255, 255, 255, 0.7)];
    [self addSubview:self.searchGroupsTextFiled];
}

@end
