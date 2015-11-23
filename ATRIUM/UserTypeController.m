//
//  UserTypeController.m
//  ATRIUM
//
//  Created by Admin on 10/9/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "UserTypeController.h"
#import "StudentRegistrationController.h"
#import "ProfessorRegistrationController.h"

@interface UserTypeController ()
@property (nonatomic, strong) UIView *topView;

@property (retain, nonatomic) UILabel *facultyMemberLabel;
@property (nonatomic, strong) UIButton *facultyMemberButton;

@property (nonatomic, strong) UIButton *studentMemberButton;
@property (retain, nonatomic) UILabel *studentMemberLabel;
@end

@implementation UserTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
    
//    self.view.backgroundColor = rgbColor(22, 168, 235);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)configureNavigationBar {
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
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
//    [super configureControls];   
    
    //create faculty member select button
    self.facultyMemberButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    self.facultyMemberButton.backgroundColor = rgbColor(22, 168, 235);
    //    self.facultyMemberButton.titleColor = [UIColor whiteColor];
    //    self.facultyMemberButton.titleLabel.font = FONT_SANSUMI(12);
    //    self.facultyMemberButton.title = @"OR SET UP NEW ACCOUNT";
    self.facultyMemberButton.enabled = YES;
    [self.facultyMemberButton addTarget:self action:@selector(facultyMemberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.facultyMemberButton];
    
    
    self.facultyMemberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 290, 90)];
//    self.facultyMemberLabel.layer.borderWidth = 2;
    self.facultyMemberLabel.numberOfLines = 0.f;
    self.facultyMemberLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.facultyMemberLabel.textAlignment = NSTextAlignmentCenter;
//    self.facultyMemberLabel.font = FONT_SANSUMI_BOLD(15);
    self.facultyMemberLabel.textColor = rgbColor(255, 255, 255);
    
    NSString *title = @"ARE YOU A";
    NSMutableAttributedString *facultyTitle = [[NSMutableAttributedString alloc]
                                          initWithAttributedString:[NSAttributedString attributedStringWithTitle:title withTextColor:[UIColor whiteColor] withFontSize:20]];
    NSString *additionalTitle = @" \nFACULTY MEMBER?";
    NSMutableAttributedString *facultyTitle2 = [[NSMutableAttributedString alloc]
                                               initWithAttributedString:[NSAttributedString attributedStringWithTitle:additionalTitle withTextColor:[UIColor whiteColor] withBoldFontSize:20]];
    [facultyTitle appendAttributedString:facultyTitle2];
    self.facultyMemberLabel.attributedText = facultyTitle;
    //    self.loginTitleLabel.hidden = YES;
    self.facultyMemberLabel.backgroundColor = [UIColor clearColor];
    [self.facultyMemberButton addSubview:self.facultyMemberLabel];
    
    
    //create student select button
    self.studentMemberButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    self.studentMemberButton.backgroundColor = rgbColor(255, 255, 255);
    //    self.facultyMemberButton.titleColor = [UIColor whiteColor];
    //    self.facultyMemberButton.titleLabel.font = FONT_SANSUMI(12);
    //    self.facultyMemberButton.title = @"OR SET UP NEW ACCOUNT";
    self.studentMemberButton.enabled = YES;
    [self.studentMemberButton addTarget:self action:@selector(studentMemberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.studentMemberButton];
    
    self.studentMemberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 290, 90)];
//    self.studentMemberLabel.layer.borderWidth = 2;
//    self.studentMemberLabel.textColor = rgbColor(63, 183, 232);
    self.studentMemberLabel.numberOfLines = 0.f;
    self.studentMemberLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.studentMemberLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *studentTitle = [TRANSLATE(@"Or a") uppercaseString];
    NSMutableAttributedString *studentMemberTitle = [[NSMutableAttributedString alloc]
                                               initWithAttributedString:[NSAttributedString attributedStringWithTitle:studentTitle withTextColor:rgbColor(73, 108, 148) withFontSize:20]];
    NSString *additionalTitle2 = [TRANSLATE(@" \nStudent?") uppercaseString];
    NSMutableAttributedString *studentMemberTitle2 = [[NSMutableAttributedString alloc]
                                                initWithAttributedString:[NSAttributedString attributedStringWithTitle:additionalTitle2 withTextColor:rgbColor(73, 108, 148) withBoldFontSize:20]];
    [studentMemberTitle appendAttributedString:studentMemberTitle2];
    
    self.studentMemberLabel.attributedText = studentMemberTitle;
    self.studentMemberLabel.backgroundColor = [UIColor clearColor];
    [self.studentMemberButton addSubview:self.studentMemberLabel];
}
- (void)facultyMemberButtonClicked:(id)sender {
    DLog(@"faculty member pressed");
    ProfessorRegistrationController *professorRegisterController = [[ProfessorRegistrationController alloc]init];
    [self.navigationController pushViewController:professorRegisterController animated:YES];
}
- (void)studentMemberButtonClicked:(id)sender {
    DLog(@"student member pressed");
    StudentRegistrationController *studentRegisterController = [[StudentRegistrationController alloc]init];
    [self.navigationController pushViewController:studentRegisterController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
