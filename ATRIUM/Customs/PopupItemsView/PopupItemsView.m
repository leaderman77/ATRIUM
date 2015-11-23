//
// Created by Sanch0 on 4/29/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PopupItemsView.h"
#import "BaseCell.h"

#define PADDING_TOP_LEFT 60.f

@interface PopupItemsView () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *filteredItems;

@end

@implementation PopupItemsView {

}

- (void)createAndLayoutSubviews {
    [super createAndLayoutSubviews];
    self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    self.alpha = 0;

    CGFloat left = PADDING_TOP_LEFT;
    CGFloat top = PADDING_TOP_LEFT;
    CGFloat width = 0, height = 0;

    width = self.width - 2 * left;
    height = self.height - 2 * top;

    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(left, top, width, height)];
    [self.bgView makeBorderWithCornerRadius];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];

    left = top = 0;
    width = self.bgView.width;

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:_title ? _title : @"" withBoldFontSize:20];
    [self.bgView addSubview:_titleLabel];

    CGFloat closeBtnHeightWidth = 45.f;
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bgView.width - closeBtnHeightWidth, top, closeBtnHeightWidth, closeBtnHeightWidth)];
//    self.closeBtn.layer.borderWidth = 1.f;
    _closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _closeBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _closeBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 10);
    _closeBtn.image = [UIImage imageNamed:@"close-visit.png"];
    [_closeBtn addTarget:self action:@selector(closeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:_closeBtn];

    top += _titleLabel.height;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(left, top, width, 50)];
    _searchBar.placeholder = TRANSLATE(@"Search");
    _searchBar.delegate = self;
    [self.bgView addSubview:_searchBar];

    top += _searchBar.height;
    height = self.bgView.height - top;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(left, top, width, height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.rowHeight = 40.f;
    [self.bgView addSubview:_tableView];

    self.bgView.top = self.height;
}

- (void)closeClicked:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.top = self.height + 10;
        self.alpha = 0;
    }                completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)closeView {
    [self closeClicked:nil];
}

- (void)showView {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.top = 30;
        self.alpha = 1;
    }                completion:^(BOOL finished) {

    }];

}

- (void)setItems:(NSMutableArray *)items {
    _items = items;
    _filteredItems = [_items copy];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filteredItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell *cell = nil;
    id item = _filteredItems[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(cellForPopupItemsView:withItem:atIndex:)]) {
        cell = [self.delegate cellForPopupItemsView:self withItem:item atIndex:indexPath.row];
    } else {
        cell = [BaseCell cellForTableView:tableView withItem:nil];
        if ([self.delegate respondsToSelector:@selector(textForPopupItemsView:withItem:atIndex:)]) {
            id text = [self.delegate textForPopupItemsView:self withItem:item atIndex:indexPath.row];
            if ([text isKindOfClass:[NSString class]]) {
                cell.cellTitleLabel.text = text;
            } else if ([text isKindOfClass:[NSAttributedString class]]) {
                cell.cellTitleLabel.attributedText = text;
            }
        } else if ([item respondsToSelector:@selector(name)]) {
            cell.cellTitleLabel.attributedText = [NSAttributedString attributedStringWithTitle:[item name] withFontSize:13];
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectItemAndCloseBlock) {
        __weak PopupItemsView *weakSelf = self;
        self.selectItemAndCloseBlock(weakSelf, _items[indexPath.row], indexPath.row);
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length > 0) {
        NSPredicate *predicate = nil;
        if ([self.delegate respondsToSelector:@selector(predicatePopupItemsView:withSearchKey:)]) {
            predicate = [self.delegate predicatePopupItemsView:self withSearchKey:searchText];
        }
        if (!predicate) {
            predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchText];
        }
        self.filteredItems = [self.items filteredArrayUsingPredicate:predicate];
    } else {
        self.filteredItems = [self.items mutableCopy];
    }

    [self.tableView reloadData];
}


@end