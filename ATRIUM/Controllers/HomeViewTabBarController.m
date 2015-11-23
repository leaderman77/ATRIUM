//
//  HomeViewTabBarController.m
//  ATRIUM
//
//  Created by Admin on 10/16/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "HomeViewTabBarController.h"

@interface HomeViewTabBarController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, retain) UIPickerView *dobPickerView;
@property (nonatomic, retain) NSMutableArray *pickerDays;
@property (nonatomic, retain) NSMutableArray *pickerMonths;
@property (nonatomic, retain) NSMutableArray *pickerYears;
@end

@implementation HomeViewTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.pickerDays= [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", nil];
    
    self.pickerMonths= [[NSMutableArray alloc] initWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"Semtember", @"October", @"Novomber", @"December", nil];
    
    self.dobPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    self.dobPickerView.showsSelectionIndicator = YES;
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(25, 10, 100, 20)];
    right.titleColor = [UIColor blackColor];
    [right setTitle:TRANSLATE(@"Days") forState:UIControlStateNormal];
    [self.dobPickerView addSubview:right];
    self.dobPickerView.backgroundColor = [UIColor whiteColor];
    self.dobPickerView.hidden = NO;
    self.dobPickerView.dataSource = self;
    self.dobPickerView.delegate = self;
    [self.view addSubview:self.dobPickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UIPickerViewDataSource

//Columns in picker views

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {
    return 1;
}
//Rows in each Column

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    return self.pickerMonths.count;
}

#pragma  UIPickerViewDelegate

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerMonths objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    //Write the required logic here that should happen after you select a row in Picker View.
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
