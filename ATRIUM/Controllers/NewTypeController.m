//
//  NewTypeController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "NewTypeController.h"

@interface NewTypeController ()
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *lineView;

@property (retain, nonatomic) UILabel *sectionLabel;
@property (nonatomic, retain) NSMutableArray *announcementTypes;

@property (nonatomic, retain) NSMutableArray *listSection;

@property (nonatomic, strong) UITextField *searchContactsTextFiled;
@property (nonatomic, strong) UITextField *searchGroupsTextFiled;

@property (nonatomic, retain) UIButton *scienenceNewsButton;
@property (nonatomic, retain) UIButton *economicNewsButton;

@property (nonatomic, retain) UIButton *campusNewsButton;
@property (nonatomic, retain) UIButton *politicsNewsButton;

@property (nonatomic, retain) UIButton *backButton;
@end

@implementation NewTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self configureControls];
    [self configureNavigationBar];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.backgroundColor = rgbColor(22, 168, 235);
    self.navigationController.navigationBar.barTintColor = rgbColor(22, 168, 235);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(@"News") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    [self.view addSubview:self.topView];
}
- (void)configureControls {
//    [super configureControls];
    
//    self.titleView.text = [TRANSLATE(@"News") uppercaseString];
//    self.titleView.titleColor = rgbColor(255, 255, 255);
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.mainView.backgroundColor = rgbColor(22, 168, 235);
    [self.view addSubview:self.mainView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.mainView.width, 1)];
    self.lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.lineView.backgroundColor = [UIColor blackColor];
    [self.mainView addSubview:self.lineView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 75, 40, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.backButton.width, self.backButton.height)];
    [imageView setImage:[UIImage imageNamed:@"news_passive.png"]];
    //    imageView.layer.borderWidth = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.left = 0.5 * (imageView.width - imageView.width);
    imageView.top = 0.5 * (imageView.height - imageView.height);
    imageView.layer.borderWidth = 1.0f;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.cornerRadius = 0.5 * imageView.width;
    imageView.layer.masksToBounds = YES;
    [self.backButton addSubview:imageView];
    [self.backButton addTarget:self action:@selector(cencelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.backButton];
    
    CGFloat top = 130;
    CGFloat left = 55;
    CGFloat width = 200;
    CGFloat height = 30;
    self.economicNewsButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, height)];
    //    self.titleViewButton.layer.borderWidth = 2;
    self.economicNewsButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    self.economicNewsButton.titleColor = rgbColor(255, 255, 255);
    self.economicNewsButton.title = [TRANSLATE(@"Economics") uppercaseString];
    [self.economicNewsButton addTarget:self action:@selector(cencelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.economicNewsButton];
    top += 35;
    self.scienenceNewsButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, height)];
    //    self.titleViewButton.layer.borderWidth = 2;
    self.scienenceNewsButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    self.scienenceNewsButton.titleColor = rgbColor(255, 255, 255);
    self.scienenceNewsButton.title = [TRANSLATE(@"Sciences") uppercaseString];
    [self.mainView addSubview:self.scienenceNewsButton];
    top += 35;
    self.campusNewsButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, height)];
    //    self.titleViewButton.layer.borderWidth = 2;
    self.campusNewsButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    self.campusNewsButton.titleColor = rgbColor(255, 255, 255);
    self.campusNewsButton.title = [TRANSLATE(@"Campus") uppercaseString];
    [self.mainView addSubview:self.campusNewsButton];
    top += 35;
    self.politicsNewsButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top, width, height)];
    //    self.titleViewButton.layer.borderWidth = 2;
    self.politicsNewsButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    self.politicsNewsButton.titleColor = rgbColor(255, 255, 255);
    self.politicsNewsButton.title = [TRANSLATE(@"Politics") uppercaseString];
    [self.politicsNewsButton addTarget:self action:@selector(cencelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.politicsNewsButton];
    
}
- (IBAction)cencelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
