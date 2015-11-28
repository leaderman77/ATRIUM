//
//  SearchAnnouncementsController.m
//  ATRIUM
//
//  Created by Admin on 10/15/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "SearchAnnouncementsController.h"
#import "SearchAnnouncementsCell.h"
#import "AnnouncementDetailsController.h"

@interface SearchAnnouncementsController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, AnnounceDetailsControllerDelegate>
{
    NSArray *usersNames;
//    NSArray *filteredContent;
    BOOL isSearchTextFieldActive;
}
@property (nonatomic, strong) UITableView *chatsTableView;
@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, retain) UIToolbar *toolbar;

@property (strong, nonatomic) CustomTextField *searchContactsTextFiled;

@property (nonatomic, retain) UIButton *titleViewButton;
@property (nonatomic, retain) UIButton *backButton;

@end

@implementation SearchAnnouncementsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = rgbColor(22, 168, 235);
    usersNames = [[NSMutableArray alloc] init];
    isSearchTextFieldActive = NO;
    [self callApiMethods];
    [self configureControls];
    [self configureNavigationBar];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.barTintColor = rgbColor(255, 255, 255);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)callApiMethods {
        [self.view showLoading:YES];
        
        [[RestClient sharedFormClient] callMethodByPath:METHOD_GET_LIST_ALL_TRANDS_ANNOUNCEMETS withHTTPMethodType:HTTP_POST withParameters:nil callback:^(NSDictionary *responseDic, NSError *error) {
            [self.view showLoading:NO];
            if (!error && [responseDic[@"status"] integerValue] == 1 && responseDic[@"data"]) {
                DLog(@"success 1 fields");
                //                                                   self.titleArray = [responseDic valueForKey:@"title"];
                self.announceNames = [[responseDic valueForKey:@"data"] valueForKey:@"title"];
                self.announceID = [[responseDic valueForKey:@"data"] valueForKey:@"id"];
                self.createdDate = [[responseDic valueForKey:@"data"] valueForKey:@"createdAt"];
                self.announcePhoto = [[responseDic valueForKey:@"data"] valueForKey:@"photo"];
                self.announceText = [[responseDic valueForKey:@"data"] valueForKey:@"text"];
                int count;
                self.announceDescription = [[NSMutableArray alloc]initWithCapacity:0];
                for (count = 0; count < self.announceNames.count; count++) {
                    NSArray *array = [[[responseDic valueForKey:@"data"] objectAtIndex:count] valueForKey:@"user"];
                    if (array.count != 0) {
                        NSString *string = [[[[[responseDic valueForKey:@"data"] objectAtIndex:count] valueForKey:@"user"] objectAtIndex:0] valueForKey:@"fullName"];
                        
                        [self.announceDescription addObject:string];
                    } else {
                        NSString *string = @"";
                        [self.announceDescription addObject:string];
                    }
                    
                }
                
                
                [self configureControls];
                
                [self.chatsTableView reloadData];
            } else {
                ALERT(@"Error with saving profile.");
            }
        }];

}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(255, 255, 255);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(55, 25, 230, 30)];
    titleButton.text = [TRANSLATE(@"Announcements") uppercaseString];
    titleButton.titleColor = rgbColor(37, 66, 97);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    [self.view addSubview:self.topView];
}
- (void)configureControls {
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - self.topView.height)];
    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.mainView.backgroundColor = rgbColor(22, 168, 235);
    [self.view addSubview:self.mainView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 10, 35, 35)];
    //    self.titleViewButton.layer.borderWidth = 2;
//    self.backButton.titleLabel.font = FONT_SANSUMI_BOLD(15);
//    self.backButton.titleColor = [UIColor blackColor];
//    self.backButton.title = [TRANSLATE(@"Cencel") uppercaseString];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.backButton.width, self.backButton.height)];
    [imageView setImage:[UIImage imageNamed:@"announcements_passive.png"]];
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
    
    self.searchContactsTextFiled = [[CustomTextField alloc]initWithFrame:CGRectMake(10, self.backButton.height + 20, 290, 30)];
    self.searchContactsTextFiled.placeholder = [TRANSLATE(@"Search for trades/announcements") uppercaseString];
    self.searchContactsTextFiled.delegate = self;
    self.searchContactsTextFiled.font = FONT_SANSUMI(12);
    self.searchContactsTextFiled.textColor = [UIColor whiteColor];
    self.searchContactsTextFiled.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[TRANSLATE(@"Search for trades/announcements") uppercaseString] attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.searchContactsTextFiled.leftView = paddingView;
    self.searchContactsTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.searchContactsTextFiled.layer.cornerRadius = 5.f;
    self.searchContactsTextFiled.layer.masksToBounds = YES;
    self.searchContactsTextFiled.returnKeyType = UIReturnKeyDone;
    [self.searchContactsTextFiled addBottomBorderWithHeight:1.f andColor:rgbColorWithAlpha(255, 255, 255, 0.7)];
    [self.mainView addSubview:self.searchContactsTextFiled];
    
//    self.announceNames = [[NSMutableArray alloc]initWithObjects:@"James Bont", @"Abrahm Lincoln", nil];
//    self.announceDescription = [[NSMutableArray alloc]initWithObjects:@"Teacher", @"Student", nil];
//    autocompleteUrls = [[NSMutableArray alloc] init];
    
    self.chatsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.backButton.height + self.searchContactsTextFiled.height + 30, self.searchContactsTextFiled.width, self.mainView.height-100) style:UITableViewStylePlain];
//    self.chatsTableView.layer.borderWidth = 2;
    self.chatsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.chatsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.chatsTableView.rowHeight = 40.f;
    self.chatsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatsTableView.delegate = self;
    self.chatsTableView.dataSource = self;
    self.chatsTableView.hidden = YES;
    self.chatsTableView.backgroundColor = rgbColor(22, 168, 235);
    [self.mainView addSubview:self.chatsTableView];
}
- (IBAction)cencelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)goPressed {
    
    // Clean up UI
    [self.searchContactsTextFiled resignFirstResponder];
    self.chatsTableView.hidden = YES;
    
    // Add the URL to the list of entered URLS as long as it isn't already there
    if (![usersNames containsObject:self.searchContactsTextFiled.text]) {
//        [usersNames addObject:self.searchContactsTextFiled.text];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (isSearchTextFieldActive) {
        return usersNames.count;
    } else {
        return self.announceNames.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"LBLeftSideViewCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    //    cell.contentView.layer.borderWidth = 2;
//    cell.textLabel.text = self.announcementTypes[indexPath.row];
//    cell.contentView.backgroundColor = rgbColor(22, 168, 235);
//    cell.contentView.tintColor = rgbColor(255, 255, 255);
    
    SearchAnnouncementsCell *cell = [SearchAnnouncementsCell cellForTableView:tableView withItem:nil];
    cell.baseDelegate = self;
    cell.indexPath = indexPath;
    
    if (isSearchTextFieldActive) {
        cell.announceNameLabel.text = [NSString stringWithFormat:@"%@", [usersNames objectAtIndex:indexPath.row]];
        //    cell.announceDescLabel.text = [NSString stringWithFormat:@"%@", [self.announceDescription objectAtIndex:indexPath.row]];
    } else {
        cell.announceNameLabel.text = [NSString stringWithFormat:@"%@", [self.announceNames objectAtIndex:indexPath.row]];
        cell.announceDescLabel.text = [NSString stringWithFormat:@"%@", [self.announceDescription objectAtIndex:indexPath.row]];
    }
   

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnnouncementDetailsController *announcementDetailsController = [[AnnouncementDetailsController alloc]init];
    announcementDetailsController.delegate = self;
    announcementDetailsController.announceCreateBy = self.announceDescription[indexPath.row];
    announcementDetailsController.announceID = self.announceID[indexPath.row];
    announcementDetailsController.announceTitle = self.announceNames[indexPath.row];
    announcementDetailsController.myAnnounceText = self.announceText[indexPath.row];
    self.photoUrl = self.announcePhoto[indexPath.row];
    announcementDetailsController.isViewMode = YES;
    announcementDetailsController.photoUrl = self.photoUrl;
    announcementDetailsController.isViewMode = NO;
    announcementDetailsController.isSearch = YES;
    [self.navigationController pushViewController:announcementDetailsController animated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
//    [autocompleteUrls removeAllObjects];
    for(NSString *curString in usersNames) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
//            [autocompleteUrls addObject:curString];
        }
    }
    [self.chatsTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.searchContactsTextFiled isEqual:textField]) {
        self.chatsTableView.hidden = NO;
        isSearchTextFieldActive = YES;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self beginswith[cd] %@",textField.text];
        usersNames = [self.announceNames filteredArrayUsingPredicate:predicate];
        
//        NSString *substring = [NSString stringWithString:textField.text];
//        substring = [substring stringByReplacingCharactersInRange:range withString:string];
//        [self searchAutocompleteEntriesWithSubstring:substring];
    }
    [self.chatsTableView reloadData];
    if ([string isEqualToString:@""]) {
        isSearchTextFieldActive = NO;
        [self.chatsTableView reloadData];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.searchContactsTextFiled isEqual:textField]) {
        [self.searchContactsTextFiled resignFirstResponder];
    }
    
    return YES;
}
- (void)callAppMethodOfAnnounceByDetails {
    [self callApiMethods];
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
