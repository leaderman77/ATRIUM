//
//  PatientSearchPopupView.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/25/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientSearchPopupView.h"
#import "BaseCell.h"
#import "CustomSearchBar.h"
//#import "PatientSearchParameters.h"
//#import "PatientForList.h"

@interface PatientSearchPopupView ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    CGFloat top, left, padding, height, width;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CustomSearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *items;
//@property (nonatomic, strong) PatientForList *selectedItem;
//@property (nonatomic, strong) PatientSearchParameters *searchParameters;
@end

@implementation PatientSearchPopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)createAndLayoutSubviews {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    height = 400;
    top = (self.height - height) / 2.0;
    width = 440;
    left = (self.width - width) / 2.0;
    padding = 25;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(left, top, width, height)];
    _contentView.backgroundColor = rgbColor(235, 234, 233);
    [_contentView makeBorderWithCornerRadius];
    [self addSubview:_contentView];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, width - 2 *padding, 45)];
    _titleLabel.font = FONT_SANSUMI(25);
    _titleLabel.text = @"Please select Patient";
    [_contentView addSubview:_titleLabel];
    _searchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(padding, _titleLabel.bottom, width - 2 * padding, 45)];
    _searchBar.delegate = self;
    [_contentView addSubview:_searchBar];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(padding, _searchBar.bottom - 2, width - 2 * padding, 275)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 75;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    __weak PatientSearchPopupView *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getPatientList:weakSelf.searchParameters isLazyLoading:YES];
    }];
    [_tableView makeBorderWithCornerRadius];
    _contentView.layer.borderWidth = 1;
    
    [_contentView addSubview:_tableView];
    width = 250;
    _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(_contentView.width - (width + padding), _tableView.bottom, width, 35)];
    [_nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_nextButton setTitle:@"Done"];
    [_nextButton setTitleColor:LIME_BUTTON_BG_COLOR];
    [_nextButton addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_nextButton];
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(padding, _tableView.bottom, width, 35)];
    [_backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_backButton setTitle:@"Close"];
    [_backButton setTitleColor:LIME_BUTTON_BG_COLOR];
    [_backButton addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_backButton];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.nextButton.enabled = NO;
    [self searchBar:self.searchBar textDidChange:@""];
    self.searchParameters = [[PatientSearchParameters alloc] initWithStart:@0 withLimit:LIMIT];
//    [self getPatientList:self.searchParameters isLazyLoading:NO];
    [self.tableView triggerInfiniteScrolling];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    //    NSDictionary* userInfo = [notif userInfo];
    
    // get the size of the keyboard
    //    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.top -= 170;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    //    NSDictionary* userInfo = [notif userInfo];
    
    // get the size of the keyboard
    //    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.top += 170;
    }];
}

- (void)doneBtnClicked:(UIButton *)sender {
    if(self.patientSearchCompleted) {
        self.patientSearchCompleted(self.selectedItem, NO);
    }
}

- (void)backBtnClicked:(UIButton *)sender {
    if(self.patientSearchCompleted) {
        self.patientSearchCompleted(nil, NO);
    }
}

- (void)showInWindow {
    self.alpha = 0;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.width = window.width;
    self.height = window.height;
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark UITableViewDelgate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *BaseCellID = @"BaseCell";
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:BaseCellID];
    if (!cell) {
        CGFloat btnHeightWidth = tableView.rowHeight - 10;
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BaseCellID];
        cell.cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 5, btnHeightWidth, btnHeightWidth)];
        cell.cellImageView.layer.cornerRadius = 0.5 * btnHeightWidth;
        cell.cellImageView.layer.masksToBounds = YES;
        cell.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:cell.cellImageView];
        
        cell.cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(btnHeightWidth + 12, 5, tableView.width - btnHeightWidth - 15, btnHeightWidth)];
        cell.cellTitleLabel.numberOfLines = 2.f;
        cell.cellTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.cellImageView setImage:[UIImage imageNamed:@"default_avatar.png"]];
        [cell.contentView addSubview:cell.cellTitleLabel];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.cellTitleLabel.attributedText =  [NSAttributedString attributedStringWithTitle:@"Jason Born" withBoldFontSize:16.f];
    }
    PatientForList *patient = self.items[indexPath.row];
    [cell.cellImageView setImageWithURL:patient.photoUrl placeholderImage:[UIImage imageNamed:@"default_avatar.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.cellTitleLabel.attributedText = [NSAttributedString attributedStringWithTitle:[NSString stringWithFormat:@"%@ %@", patient.lastName, patient.firstName] withBoldFontSize:16.f];
    cell.accessoryType = (self.selectedItem && [self.selectedItem.objectId isEqualToNumber:patient.objectId]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedItem = [self.items objectAtIndex:indexPath.row];
    self.nextButton.enabled = YES;
    [self.tableView reloadData];
}




#pragma mark UISearchBar Delegate


- (void)getPatientList:(PatientSearchParameters *)searchParameters isLazyLoading:(BOOL)lazyLoad {
    
//    [self showLoading:YES];
    __weak PatientSearchPopupView *weakSelf = self;
    [[RestClient sharedClient] callMethodByPath:METHOD_GET_PATIENT_LIST withHTTPMethodType:HTTP_GET withParameters:[searchParameters toDictionary]
                                       callback:^(NSDictionary *responseDic, NSError *error) {
                                           [weakSelf showLoading:NO];
                                           [weakSelf.searchBar showRightLoader:NO];
                                           [weakSelf.tableView.infiniteScrollingView stopAnimating];
                                           if (SUCCEED_RESPONSE(responseDic, error)) {
                                               NSMutableArray *newItems = [PatientForList arrayOfModelsFromDictionaries:responseDic[@"data"][@"list"]];
                                               if (lazyLoad && weakSelf.items) {
                                                   if (weakSelf.items.count > 0) {
                                                       [weakSelf.items  addObjectsFromArray:newItems];
                                                   }
                                               } else {
                                                   self.items = newItems;
                                               }
                                               weakSelf.searchParameters.start = @(weakSelf.items.count);
                                               [weakSelf.tableView reloadData];
                                           }
                                       }];
}



- (void)searchBar:(CustomSearchBar *)searchBar textDidChange:(NSString *)searchText {
    /// GET Params: String filterKey
    
    if(searchBar.text.length >= 1) {
        [searchBar showRightLoader:YES];
        self.searchParameters.filterKey = searchText;
        self.searchParameters.start = @0;
        [self getPatientList:self.searchParameters isLazyLoading:NO];
    }
}

@end
