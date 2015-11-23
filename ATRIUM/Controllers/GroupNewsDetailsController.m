//
//  GroupNewsDetailsController.m
//  ATRIUM
//
//  Created by Admin on 11/23/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "GroupNewsDetailsController.h"

@interface GroupNewsDetailsController ()
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, retain) UITextView *detailsTextView;
@end

@implementation GroupNewsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureControls];
    [self configureNavigationBar];
    
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
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(255, 255, 255);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 25, 270, 30)];
//    titleButton.layer.borderWidth = 1;
    titleButton.text = [TRANSLATE(self.groupNewsTitle) uppercaseString];
    titleButton.titleColor = rgbColor(22, 168, 235);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(12);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    [self.view addSubview:self.topView];
}
- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configureControls {
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 53, self.view.bounds.size.width, 180)];
    //    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.backgroundColor = [UIColor blueColor];
    [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:nil];
    [self.view addSubview:self.profileImageView];
    
    self.detailsTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, self.profileImageView.height + 70, 290, 220)];
    //        self.detailsTextView.layer.borderWidth = 2;
    self.detailsTextView.backgroundColor = [UIColor whiteColor];
    self.detailsTextView.text = self.groupNewstext;
    self.detailsTextView.editable = NO;
    self.detailsTextView.textColor = rgbColor(37, 66, 97);
    self.detailsTextView.scrollEnabled = YES;
    self.detailsTextView.font = FONT_SANSUMI_BOLD(15);
    [self.view addSubview:self.detailsTextView];
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
