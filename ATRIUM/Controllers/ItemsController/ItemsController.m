//
// Created by Sanch0 on 12/1/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "ItemsController.h"

@interface ItemsController ()

@property (nonatomic, strong) UILabel *headerView;
@end


@implementation ItemsController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.selectedIndexSet = [[NSMutableIndexSet alloc] init];
//    [self configureControls];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = !_withNavigationItem;
    [self.tableView reloadData];
}

- (void)configureNavigationBar {
    self.navigationItem.titleView = self.titleView;
    self.titleView.text = self.title;
}

- (void)setWithNavigationItem:(BOOL)withNavigationItem {
    _withNavigationItem = withNavigationItem;
}


- (void)configureControls {
    [super configureControls];

    if ([self.controllerDelegate respondsToSelector:@selector(headerViewForItemsController:)]) {
        self.tableView.tableHeaderView = [self.controllerDelegate headerViewForItemsController:self];
    }

    if ([self.controllerDelegate respondsToSelector:@selector(footerViewForItemsController:)]) {
        self.tableView.tableFooterView = [self.controllerDelegate footerViewForItemsController:self];
    }

    CGFloat top = kPortraitNavbarHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, top, self.view.width, self.view.height - top)];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.rowHeight = _tableViewRowHeight > 0 ? _tableViewRowHeight : 44.f;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)reloadData {

    if ([self.controllerDelegate respondsToSelector:@selector(headerViewForItemsController:)]) {
        self.tableView.tableHeaderView = [self.controllerDelegate headerViewForItemsController:self];
    }

    if ([self.controllerDelegate respondsToSelector:@selector(footerViewForItemsController:)]) {
        self.tableView.tableFooterView = [self.controllerDelegate footerViewForItemsController:self];
    }
    [self.tableView reloadData];
}


- (void)setTableViewRowHeight:(CGFloat)tableViewRowHeight {
    _tableViewRowHeight = tableViewRowHeight;
    self.tableView.rowHeight = _tableViewRowHeight;
}


- (UILabel *)headerView {
    if (!_headerView) {
        _headerView = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.width - 20, 70)];
        _headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _headerView.textAlignment = NSTextAlignmentCenter;
        _headerView.numberOfLines = 0.;
        _headerView.layer.masksToBounds = NO;
        [self.view addSubview:self.headerView];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-10, _headerView.height - 1, self.view.width, 1)];
        line.backgroundColor = [UIColor grayColor];
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.headerView addSubview:line];
//        [self.headerView addBottomBorderWithHeight:1 andColor:[UIColor grayColor]];
    }

    return _headerView;
}

- (void)configureWithHeaderTitle:(NSString *)headerTitle {
    self.headerView.attributedText = [NSAttributedString attributedStringWithTitle:headerTitle ? headerTitle : TRANSLATE(@"Patient(s) assosiated\nwith this number")
                                                                     withTextColor:[UIColor blackColor]
                                                                  withBoldFontSize:17.f];


    self.tableView.top = self.headerView.height;
    self.tableView.height = self.view.height - self.tableView.top;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([self.controllerDelegate respondsToSelector:@selector(itemsController:cellForRowAtIndexPath:)]) {
        cell = [self.controllerDelegate itemsController:self cellForRowAtIndexPath:indexPath];
    }
    if (cell == nil) {
        id item = self.items[indexPath.row];
        BaseCell *baseCell = [BaseCell cellForTableView:tableView withItem:item];
        if ([self.controllerDelegate respondsToSelector:@selector(itemsController:textForRowAtIndex:)]) {
            id text = [self.controllerDelegate itemsController:self textForRowAtIndex:indexPath.row];
            if ([text isKindOfClass:[NSAttributedString class]]) {
                baseCell.cellTitleLabel.attributedText = text;
            } else if ([text isKindOfClass:[NSString class]]) {
                baseCell.cellTitleLabel.text = text;
            }
        } else if ([item respondsToSelector:@selector(name)]) {
            baseCell.cellTitleLabel.text = [item name];
        }
        baseCell.separatorInset = UIEdgeInsetsZero;
        cell = baseCell;
    }

    cell.accessoryType = ([self.selectedIndexSet containsIndex:indexPath.row])//kMultipleChoicePopoverType
            || (self.selectedIndex && self.selectedIndex.integerValue == indexPath.row)
            ? UITableViewCellAccessoryCheckmark
            : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.controllerDelegate respondsToSelector:@selector(itemsController:didSelectItem:atIndex:)]) {
        [self.controllerDelegate itemsController:self didSelectItem:self.items.count >= indexPath.row ? self.items[indexPath.row] : nil atIndex:indexPath.row];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
