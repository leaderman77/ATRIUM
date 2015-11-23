//
//  NewsController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "NewsController.h"
#import "NewTypeController.h"
#import "NewsDetailsController.h"

@interface NewsController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *newsListtableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *lineView;

@property (retain, nonatomic) UILabel *sectionLabel;
@property (nonatomic, retain) NSMutableArray *announcementTypes;

@property (nonatomic, retain) NSMutableArray *listSection;

@property (nonatomic, strong) UITextField *searchContactsTextFiled;
@property (nonatomic, strong) UITextField *searchGroupsTextFiled;

@property (nonatomic, retain) UIButton *titleViewButton;
@property (nonatomic, retain) UIButton *backButton;

@property (nonatomic, retain) UIButton *newsButton;
@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self configureControls];
   
   
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
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
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
    
    self.announcementTypes = [[NSMutableArray alloc]initWithObjects:@"BART SIMSON", @"BART DONER", @"BART SIMSON", nil];
    
//    self.newsButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 550, 50, 50)];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.newsButton.width, self.newsButton.height)];
//    [imageView setImage:[UIImage imageNamed:@"news_passive.png"]];
//    //    imageView.layer.borderWidth = 1;
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.left = 0.5 * (imageView.width - imageView.width);
//    imageView.top = 0.5 * (imageView.height - imageView.height);
//    imageView.layer.borderWidth = 1.0f;
//    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    imageView.layer.cornerRadius = 0.5 * imageView.width;
//    imageView.layer.masksToBounds = YES;
//    [self.newsButton addSubview:imageView];
    

    
//    self.newsButton.layer.borderWidth = 2;
//    self.newsButton.titleLabel.font = FONT_SANSUMI_BOLD(15);
//    self.newsButton.titleColor = [UIColor blackColor];
//    self.newsButton.title = [TRANSLATE(@"Cencel") uppercaseString];
    
    
    self.newsListtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    //        self.tableView.layer.borderWidth = 2;
    self.newsListtableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    self.newsListtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.newsListtableView.rowHeight = 40.f;
//    self.newsListtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.newsListtableView.delegate = self;
    self.newsListtableView.dataSource = self;
    self.newsListtableView.backgroundColor = [UIColor clearColor]; //rgbColor(22, 168, 235);
    [self.view addSubview:self.newsListtableView];
    
//    self.newsButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 550, 50, 50)];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.newsButton.width, self.newsButton.height)];
//    [imageView setImage:[UIImage imageNamed:@"news_passive.png"]];
//    //    imageView.layer.borderWidth = 1;
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.left = 0.5 * (imageView.width - imageView.width);
//    imageView.top = 0.5 * (imageView.height - imageView.height);
//    imageView.layer.borderWidth = 1.0f;
//    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    imageView.layer.cornerRadius = 0.5 * imageView.width;
//    imageView.layer.masksToBounds = YES;
//    [self.newsButton addSubview:imageView];
//    [self.newsButton addTarget:self action:@selector(newsPresentControllerClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.newsButton];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.announcementTypes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBLeftSideViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //    cell.contentView.layer.borderWidth = 2;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.textLabel.text = self.announcementTypes[indexPath.row];
    cell.contentView.backgroundColor = [UIColor whiteColor]; //rgbColor(22, 168, 235);
    cell.contentView.tintColor = rgbColor(255, 255, 255);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailsController *newsDetailsController = [[NewsDetailsController alloc]init];
    if ([self.newsDelegate respondsToSelector:@selector(openNewsDetailsController:)]) {
        [self.newsDelegate openNewsDetailsController:newsDetailsController];
    }
//    [self.navigationController pushViewController:newsDetailsController animated:YES];
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
