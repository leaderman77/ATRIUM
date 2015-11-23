//
//  SearchViewForPopover.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/15/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "SearchViewForPopover.h"
#import "CustomSearchBar.h"
#import "BaseCell.h"
#import "TPKeyboardAvoidingTableView.h"

@interface SearchViewForPopover()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentControll;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *filteredItems;
@property (nonatomic, assign) BOOL isShowingSelectedItems;
@property (nonatomic, strong) NSMutableArray *selectedItems;

@end

@implementation SearchViewForPopover

- (void)createAndLayoutSubviews {
    self.backgroundColor = [UIColor whiteColor];
    _segmentControll = [[UISegmentedControl alloc] initWithFrame:CGRectMake(15, 10, self.width - 30, 35)];
    [_segmentControll setTintColor:LIME_BUTTON_BG_COLOR];
    [_segmentControll insertSegmentWithTitle:TRANSLATE(@"All") atIndex:0 animated:NO];
    [_segmentControll insertSegmentWithTitle:TRANSLATE(@"Selected") atIndex:1 animated:NO];
    [_segmentControll setSelectedSegmentIndex:0];
    [_segmentControll setTitleTextAttributes:@{NSFontAttributeName : FONT_SANSUMI(16)} forState:UIControlStateNormal];
    [_segmentControll addTarget:self action:@selector(segmentControllChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_segmentControll];
    self.customSearchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(0, _segmentControll.bottom + 10, self.width, 44)];
    [self addSubview:self.customSearchBar];
    self.customSearchBar.delegate = self;
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, _customSearchBar.bottom, self.width, self.height - _customSearchBar.bottom)];
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
//    if(self.isPatientPicker) {
//        __weak SearchViewForPopover *weakSelf = self;
//        [self.tableView addInfiniteScrollingWithActionHandler:^{
//            NSMutableDictionary *params = [@{@"start" : @(weakSelf.items.count),
//                                             @"limit" : LIMIT} mutableCopy];
//            if(weakSelf.customSearchBar.text.length) {
//                [params setObject:weakSelf.customSearchBar.text forKey:@"name"];
//            }
//            [[RestClient sharedClient] callMethodByPath:METHOD_GET_PATIENT_LIST withHTTPMethodType:HTTP_GET withParameters:params callback:^(NSDictionary *responseDic, NSError *error) {
//                if(SUCCEED_RESPONSE(responseDic, error)) { //PatientForList
//                    NSArray *newItems = [weakSelf selectItemsFromPatientListJson:[[responseDic objectForKey:@"data"] objectForKey:@"list"]];
//                    if(!weakSelf.items) {
//                        weakSelf.items = [NSMutableArray arrayWithCapacity:0];
//                    }
//                    [weakSelf.items addObjectsFromArray:newItems];
//                    weakSelf.filteredItems = [weakSelf.items copy];
//                    [weakSelf.tableView reloadData];
//                }
//                [weakSelf.tableView.infiniteScrollingView stopAnimating];
//            }];
//        }];
//        [self.tableView triggerInfiniteScrolling];
//    } else {
//        [self getDentistItems];
//    }
//    if(!self.selectedItems) {
//        self.selectedItems = [NSMutableArray arrayWithCapacity:0];
//    }
}

- (NSArray *)selectItemsFromPatientListJson:(NSArray *)patients {
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    for(NSDictionary *dic in patients) {
        SelectItem *item = [[SelectItem alloc] initWithId:dic[@"companyPatientId"] withName:dic[@"fullname"] withCode:dic[@"chartNumber"]];
        [items addObject:item];
    }
    return items;
}

- (void)setDisplaySelectedItems:(NSArray *)selectedItems {
    self.selectedItems = [NSMutableArray arrayWithArray:selectedItems];
    [self.tableView reloadData];
}

- (NSArray *)getSelectedItem {
    return [self.selectedItems copy];
}

- (void)segmentControllChanged:(UISegmentedControl *)segmentControll {
    self.isShowingSelectedItems = segmentControll.selectedSegmentIndex == 1;
    self.customSearchBar.text = @"";
    [self filterItemsWithSearchText:nil];
//    [self.tableView reloadData];
}

- (void)getDentistItems {
    [self showLoading:YES];
    __weak SearchViewForPopover *weakSelf = self;
//    [[RestClient sharedClient] callMethodByPath:METHOD_GET_MEMBERS_TYPE_HEAD withHTTPMethodType:HTTP_GET withParameters:nil callback:^(NSDictionary *responseDic, NSError *error) {
//        [weakSelf showLoading:NO];
//        if(SUCCEED_RESPONSE(responseDic, error)) {
//            
//        }
//        weakSelf.items = [SelectItem arrayOfModelsFromDictionaries:[responseDic objectForKey:@"data"]];
//        weakSelf.filteredItems = [weakSelf.items copy];
//        [weakSelf.tableView reloadData];
//    }];
}

- (void)filterItemsWithSearchText:(NSString *)searchText {
    if(self.isShowingSelectedItems) {
        if(searchText.length) {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
            self.filteredItems = [[self.selectedItems filteredArrayUsingPredicate:pred] mutableCopy];
        } else {
            self.filteredItems = [self.selectedItems copy];
        }
    } else {
//        if(self.isPatientPicker) {
//            NSDictionary *params = nil;
//            if(searchText.length) {
//                [self.customSearchBar showRightLoader:YES];
//                params = @{@"name" : self.customSearchBar.text};
//            }
//            __weak SearchViewForPopover *weakSelf = self;
//            [[RestClient sharedClient] callMethodByPath:METHOD_GET_PATIENT_LIST withHTTPMethodType:HTTP_GET withParameters:params callback:^(NSDictionary *responseDic, NSError *error) {
//                if(SUCCEED_RESPONSE(responseDic, error)) { //PatientForList
//                    NSArray *newItems = [weakSelf selectItemsFromPatientListJson:[[responseDic objectForKey:@"data"] objectForKey:@"list"]];
//                    weakSelf.items = [newItems mutableCopy];
//                    if(searchText.length) {
//                        [weakSelf.customSearchBar showRightLoader:NO];
//                    }
//                    weakSelf.filteredItems = [newItems copy];
//                    [weakSelf.tableView reloadData];
//                }
//            }];
//        } else {
//            if(searchText.length) {
//                NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
//                self.filteredItems = [[self.items filteredArrayUsingPredicate:pred] mutableCopy];
//            } else {
//                self.filteredItems = [self.items copy];
//            }
//        }
    }
    [self.tableView reloadData];
}

#pragma mark UITableView delagate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.isShowingSelectedItems) ? self.selectedItems.count : self.filteredItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    if(!cell) {
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchCell"];
    }
    SelectItem *item = (self.isShowingSelectedItems) ? [self.selectedItems objectAtIndex:indexPath.row] : [self.filteredItems objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    cell.accessoryType = ([self.selectedItems containsObject:item]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SelectItem *item = (self.isShowingSelectedItems) ? [self.selectedItems objectAtIndex:indexPath.row] : [self.filteredItems objectAtIndex:indexPath.row];
    if([self.selectedItems containsObject:item]) {
        [self.selectedItems removeObject:item];
    } else {
        [self.selectedItems addObject:item];
    }
    [self.tableView reloadData];
}

#pragma mark Custom SearchBar 



- (void)searchBar:(CustomSearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterItemsWithSearchText:searchText];
}

@end
