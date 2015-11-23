//
//  CLTokenInputViewController.m
//  CLTokenInputView
//
//  Created by Rizwan Sattar on 2/24/14.
//  Copyright (c) 2014 Cluster Labs, Inc. All rights reserved.
//

#import "CLTokenInputViewController.h"

#import "CLToken.h"

@interface CLTokenInputViewController ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, retain) UIButton *backButton;

@property (strong, nonatomic) NSArray *names;
@property (strong, nonatomic) NSArray *filteredNames;

@property (strong, nonatomic) NSMutableArray *selectedNames;

@end

@implementation CLTokenInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.names = @[@"Brenden Mulligan",
                       @"Cluster Labs, Inc.",
                       @"Pat Fives",
                       @"Rizwan Sattar",
                       @"Taylor Hughes"];
        self.filteredNames = nil;
        self.selectedNames = [NSMutableArray arrayWithCapacity:self.names.count];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavigationBar];
    [self configureControls];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = rgbColor(22, 168, 235);
}
- (void)viewDidAppear:(BOOL)animated
{
    if (!self.tokenInputView.editing) {
        [self.tokenInputView beginEditing];
    }
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
//    self.topView.layer.borderWidth = 2;
    self.topView.backgroundColor = rgbColor(22, 168, 235);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(@"Chat") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    [self.view addSubview:self.topView];
}
- (void)configureControls {
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height + 30)];
    //        self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
//    self.scrollView.layer.borderWidth = 2;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = [UIColor clearColor]; //rgbColor(22, 168, 235);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    [self.view addSubview:self.scrollView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.topView.width, 1.5)];
    self.lineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.lineView.backgroundColor = rgbColorWithAlpha(255, 255, 255, 0.9);
    [self.scrollView addSubview:self.lineView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 10, 40, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.backButton.width, self.backButton.height)];
    [imageView setImage:[UIImage imageNamed:@"messages_passive.png"]];
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
    [self.scrollView addSubview:self.backButton];

    
    // Do any additional setup after loading the view from its nib.
    if (![self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.tokenInputTopSpace.constant = 0.0;
    }
    self.tokenInputView = [[CLTokenInputView alloc]initWithFrame:CGRectMake(10, self.backButton.height + 20, 300, 40)];
    self.tokenInputView.backgroundColor = rgbColor(22, 168, 235);
//    self.tokenInputView.fieldName = @"To:";
//    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
//    [infoButton addTarget:self action:@selector(onFieldInfoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    self.tokenInputView.fieldView = infoButton;
    self.tokenInputView.placeholderText = @"Search Contacts";
    
    UIButton *contactAddButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [contactAddButton addTarget:self action:@selector(onAccessoryContactAddButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.tokenInputView.delegate = self;
//    self.tokenInputView.accessoryView = contactAddButton;
    self.tokenInputView.drawBottomBorder = YES;
    [self.scrollView addSubview:self.tokenInputView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.backButton.height + self.tokenInputView.height + 20, 300, 100)
                                                  style:UITableViewStyleGrouped];
    //        self.tableView.layer.borderWidth = 2;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = 35.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = rgbColor(22, 168, 235);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.scrollView addSubview:self.tableView];
    
//    if (![self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.tokenInputTopSpace.constant = 20.0;
//    }
    self.tokenInputViewGroup = [[CLTokenInputView alloc]initWithFrame:CGRectMake(10, 270, 300, 40)];
    self.tokenInputViewGroup.backgroundColor = rgbColor(22, 168, 235);
//    self.tokenInputViewGroup.fieldName = @"To:";
//    UIButton *infoButtonGroup = [UIButton buttonWithType:UIButtonTypeInfoDark];
//    [infoButton addTarget:self action:@selector(onFieldInfoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    self.tokenInputViewGroup.fieldView = infoButton;
    self.tokenInputViewGroup.placeholderText = @"Search Contacts";
    UIButton *contactAddButtonGroup = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [contactAddButtonGroup addTarget:self action:@selector(onAccessoryContactAddButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.tokenInputViewGroup.accessoryView = contactAddButtonGroup;
    self.tokenInputViewGroup.drawBottomBorder = YES;
    [self.scrollView addSubview:self.tokenInputViewGroup];
    
    self.scrollView.contentSize = CGSizeMake(0, 550);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 20) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cencelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CLTokenInputViewDelegate

- (void)tokenInputView:(CLTokenInputView *)view didChangeText:(NSString *)text
{
    if ([text isEqualToString:@""]){
        self.filteredNames = nil;
        self.tableView.hidden = YES;
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@", text];
        self.filteredNames = [self.names filteredArrayUsingPredicate:predicate];
        self.tableView.hidden = NO;
    }
    [self.tableView reloadData];
}

- (void)tokenInputView:(CLTokenInputView *)view didAddToken:(CLToken *)token
{
    NSString *name = token.displayText;
    [self.selectedNames addObject:name];
}

- (void)tokenInputView:(CLTokenInputView *)view didRemoveToken:(CLToken *)token
{
    NSString *name = token.displayText;
    [self.selectedNames removeObject:name];
}

- (CLToken *)tokenInputView:(CLTokenInputView *)view tokenForText:(NSString *)text
{
    if (self.filteredNames.count > 0) {
        NSString *matchingName = self.filteredNames[0];
        CLToken *match = [[CLToken alloc] initWithDisplayText:matchingName context:nil];
        return match;
    }
    // TODO: Perhaps if the text is a valid phone number, or email address, create a token
    // to "accept" it.
    return nil;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *name = self.filteredNames[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = rgbColor(22, 168, 235);
    cell.textLabel.backgroundColor = rgbColor(22, 168, 235);
    cell.textLabel.text = name;
    if ([self.selectedNames containsObject:name]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *name = self.filteredNames[indexPath.row];
    CLToken *token = [[CLToken alloc] initWithDisplayText:name context:nil];
    [self.tokenInputView addToken:token];
}


#pragma mark - Demo Button Actions


- (void)onFieldInfoButtonTapped:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Field View Button"
                                                        message:@"This view is optional and can be a UIButton, etc."
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    [alertView show];
}


- (void)onAccessoryContactAddButtonTapped:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Accessory View Button"
                                                        message:@"This view is optional and can be a UIButton, etc."
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net