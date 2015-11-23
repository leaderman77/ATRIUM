//
//  NewsDetailsController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "NewsDetailsController.h"

@interface NewsDetailsController ()
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, retain) UITextView *detailsTextView;
@end

@implementation NewsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 27, 200, 30)];
    titleButton.text = [TRANSLATE(@"News Details") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    [self.view addSubview:self.topView];
}

- (void)configureControls {
//    [super configureControls];
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63, self.view.bounds.size.width, 160)];
//    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.backgroundColor = [UIColor blueColor];
    self.profileImageView.image = [UIImage imageNamed:@"addimage.png"];
    [self.view addSubview:self.profileImageView];
    
    self.detailsTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, self.profileImageView.height + 68, 290, 235)];
//    self.detailsTextView.layer.borderWidth = 2;
    self.detailsTextView.backgroundColor = [UIColor whiteColor];
    self.detailsTextView.text = @"";
    self.detailsTextView.editable = NO;
    self.detailsTextView.textColor = rgbColor(37, 66, 97);
    self.detailsTextView.scrollEnabled = YES;
    self.detailsTextView.font = FONT_SANSUMI_BOLD(15);
    [self.view addSubview:self.detailsTextView];
}
- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
