//
//  DashboardItemBtn.m
//  Dental-iPad
//
//  Created by Sanch0 on 10/15/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "DashboardItemBtn.h"

#define PADDING 15.f
#define BOTTOM_BTN_HEIGHT 55.f

@interface DashboardItemBtn ()
@property (nonatomic, strong) UILabel *bottomTitleLabel;
@property (nonatomic, strong) UIImageView *bottomIcon;

@end

@implementation DashboardItemBtn
@synthesize dashBoardType = _dashBoardType;

- (id)initWithFrame:(CGRect)frame withBottomTitle:(NSString *)bottomTitle withBottomIconName:(NSString *)bottomIconName {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.bottomTitle = bottomTitle;
        self.bottomIconName = bottomIconName;
        [self configureBottomLayout];

    }
    return self;
}


- (void)configureBottomLayout {
    CGFloat padding = 10.f;
    CGFloat labelHeight = 25.f;
    UIImage *icon = [UIImage imageNamed:self.bottomIconName];

    self.bottomTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, self.height - labelHeight - padding,
            self.width - icon.size.width - 2 * padding, labelHeight)];
    self.bottomTitleLabel.textAlignment = NSTextAlignmentLeft;
//    self.bottomTitleLabel.layer.borderWidth = 1.f;
    self.bottomTitleLabel.textColor = [UIColor whiteColor];
    self.bottomTitleLabel.backgroundColor = [UIColor clearColor];
    self.bottomTitleLabel.text = [TRANSLATE(self.bottomTitle) uppercaseString];
    self.bottomTitleLabel.font = FONT_SANSUMI_BOLD(15.f);
    [self addSubview:self.bottomTitleLabel];

    self.bottomIcon = [[UIImageView alloc] initWithImage:icon];
//    self.bottomIcon.layer.borderWidth = 1.f;
    self.bottomIcon.layer.borderColor = [[UIColor redColor] CGColor];
    self.bottomIcon.left = self.bottomTitleLabel.left + self.bottomTitleLabel.width;
    self.bottomIcon.top = self.bottomTitleLabel.top;
    self.bottomIcon.top = self.height - self.bottomIcon.height - padding;
    [self addSubview:self.bottomIcon];
    self.titleLabel.font = FONT_SANSUMI(20.f);
    self.titleColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 0;
    

}

- (void)setInfoText:(id)text {
    self.text = text;
    self.image = nil;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 0, 10);
    self.titleLabel.numberOfLines = 0;
}


- (void)setDashBoardType:(DashBoardType)dashBoardType {
    _dashBoardType = dashBoardType;
    [self configureWithDashBoardType:dashBoardType];
}

- (void)setDelegate:(id <DashboardItemBtnDelegate>)delegate {
    _delegate = delegate;
//    self.tableView.dataSource = delegate;
//    self.tableView.delegate = delegate;
}


- (void)configureWithDashBoardType:(DashBoardType)dashBoardType {
    switch (dashBoardType) {
        case DashBoardTypeNone : {
            _dashBoardType = dashBoardType;
            [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.tag = DashBoardCenterView;
//    [self setBackgroundColorForSubView:self];

        }
            break;
        case DashBoardTypeTopSingle: {
            self.leftTopBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 2)];
            [self.leftTopBtn addTarget:self action:@selector(btnClicked:)
                      forControlEvents:UIControlEventTouchUpInside];
            self.leftTopBtn.tag = DashBoardTopLeftView;
            self.leftTopBtn.titleLabel.numberOfLines = 0;
//            self.leftTopBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
            self.titleEdgeInsets = UIEdgeInsetsMake(self.leftTopBtn.height, 0, self.bottomTitleLabel.top, 0);
//            [self setBackgroundColorForSubView:self.leftTopBtn];
            [self addSubview:self.leftTopBtn];
        }
            break;
        case DashBoardTypeTopDouble: {
            self.leftTopBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(0, 0, self.width / 2, self.height / 2)];
            [self.leftTopBtn addTarget:self action:@selector(btnClicked:)
                      forControlEvents:UIControlEventTouchUpInside];
            self.leftTopBtn.tag = DashBoardTopLeftView;
            self.leftTopBtn.titleLabel.numberOfLines = 0;
            [self addSubview:self.leftTopBtn];
//            [self setBackgroundColorForSubView:self.leftTopBtn];


            self.rightTopBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(self.leftTopBtn.width, 0, self.width / 2,
                    self.height / 2)];
            self.rightTopBtn.tag = DashBoardTopRightView;
            [self.rightTopBtn addTarget:self action:@selector(btnClicked:)
                       forControlEvents:UIControlEventTouchUpInside];
//            [self setBackgroundColorForSubView:self.rightTopBtn];
            self.rightTopBtn.titleLabel.numberOfLines = 0;
//            self.rightTopBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
//            self.rightTopBtn.titleLabel.layer.borderWidth = 1.f;
            [self addSubview:self.rightTopBtn];

            self.titleEdgeInsets = UIEdgeInsetsMake(self.leftTopBtn.height, 0, self.bottomTitleLabel.height + 20, 0);
        }
            break;
        case DashBoardTypeBottomSingle: {
            self.leftBottomBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(PADDING, self.height - BOTTOM_BTN_HEIGHT - PADDING, self.width - 2 * PADDING, BOTTOM_BTN_HEIGHT)];
            [self.leftBottomBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.leftBottomBtn.tag = DashBoardBottomLeftView;
            self.leftBottomBtn.titleLabel.numberOfLines = 0;
//            self.leftTopBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
            self.titleEdgeInsets = UIEdgeInsetsMake(PADDING, 0, self.leftBottomBtn.height + PADDING + 5, 0);
//            [self setBackgroundColorForSubView:self.leftTopBtn];
            [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.leftBottomBtn];
        }break;
            break;
        case DashBoardTypeTableView: {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - BOTTOM_BTN_HEIGHT + 10)];
            self.tableView.backgroundColor = [UIColor clearColor];
            self.tableView.tag = self.type;
            [self addSubview:self.tableView];
            self.tag = DashBoardCenterView;
            _tableView.delegate = (id) self.delegate;
            _tableView.dataSource = (id) self.delegate;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.rowHeight = 35;
            [_tableView reloadData];
        }
            break;//
        case DashBoardTypeTableViewWithBottom: {
            self.leftBottomBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(PADDING, self.height - BOTTOM_BTN_HEIGHT - PADDING, self.width - 2 * PADDING, BOTTOM_BTN_HEIGHT)];
            [self.leftBottomBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            self.leftBottomBtn.tag = DashBoardBottomLeftView;
            self.leftBottomBtn.titleLabel.numberOfLines = 0;
            self.titleEdgeInsets = UIEdgeInsetsMake(PADDING, 0, self.leftBottomBtn.height + PADDING + 5, 0);
            [self addSubview:self.leftBottomBtn];

            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, self.width, self.height - (BOTTOM_BTN_HEIGHT + 35))];
            self.tableView.backgroundColor = [UIColor clearColor];
            self.tableView.tag = self.type;
            [self addSubview:self.tableView];
            self.tag = DashBoardCenterView;
            _tableView.delegate = (id) self.delegate;
            _tableView.dataSource = (id) self.delegate;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.rowHeight = 35;
            [_tableView reloadData];
        }
            break;
        default:
            break;
    }
    _dashBoardType = dashBoardType;
    [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.tag = DashBoardCenterView;

}

- (void)setBackgroundColorForSubView:(UIButton *)subView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dashboardSubViewBackgroundColor:)]) {
        subView.backgroundColor = [self.delegate dashboardSubViewBackgroundColor:(DashBoardSubViewType) subView.tag];
    }
}

- (CustomBtn *)btnByType:(DashBoardSubViewType)type {
    switch (type) {
        case DashBoardCenterView:
            return self;
        case DashBoardTopLeftView:
            return self.leftTopBtn;
        case DashBoardTopRightView:
            return self.rightTopBtn;
        case DashBoardBottomLeftView:
            return self.leftBottomBtn;
    }
    return self;
}

- (void)btnClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dashboardView:didSelectViewType:)]) {
        [self.delegate dashboardView:self didSelectViewType:(DashBoardSubViewType) sender.tag];
    }
}

- (void)reloadView {
    if (self.delegate) {
        for (int i = 0; i <= self.dashBoardType; i++) {
            CustomBtn *btn = [self btnByType:i];
            if ([self.delegate respondsToSelector:@selector(dashboardView:attributedTitleForSubView:)]) {
                NSAttributedString *attributedString = [self.delegate dashboardView:self
                                                          attributedTitleForSubView:i];
                [btn setAttributedTitle:attributedString forState:UIControlStateNormal];
            }
            [self setBackgroundColorForSubView:btn];
        }
    }

}

#pragma mark UITableView delegate 

//- (NSUInteger)tab

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
