//
//  DashboardItemBtn.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/15/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "CustomBtn.h"

@class DashboardItemBtn;

typedef enum {
    DashBoardTypeNone,
    DashBoardTypeTopSingle,
    DashBoardTypeTopDouble,
    DashBoardTypeBottomSingle,
    DashBoardTypeTableView,
    DashBoardTypeTableViewWithBottom,
}DashBoardType;

typedef enum {
    DashBoardCenterView,
    DashBoardTopLeftView,
    DashBoardTopRightView,
    DashBoardBottomLeftView
}DashBoardSubViewType;

@protocol DashboardItemBtnDelegate<NSObject>


@optional
- (NSAttributedString *)dashboardView:(DashboardItemBtn *)dashboardView attributedTitleForSubView:
        (DashBoardSubViewType)subViewType;
- (void)dashboardView:(DashboardItemBtn *)dashboardView didSelectViewType:(DashBoardSubViewType)viewType;
- (UIColor *)dashboardSubViewBackgroundColor:(DashBoardSubViewType)viewType;

@end

@interface DashboardItemBtn : CustomBtn

@property (nonatomic, copy) NSString *bottomTitle;
@property (nonatomic, copy) NSString *bottomIconName;
@property (nonatomic, copy) NSString *valueStr;

@property(nonatomic, strong) CustomBtn *leftTopBtn;
@property(nonatomic, strong) CustomBtn *rightTopBtn;
@property(nonatomic, strong) CustomBtn *leftBottomBtn;
@property(nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) id value;
@property (nonatomic, assign) DashBoardType dashBoardType;
@property (nonatomic, weak) id<DashboardItemBtnDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withBottomTitle:(NSString *)bottomTitle withBottomIconName:(NSString *)bottomIconName;
- (void)configureWithDashBoardType:(DashBoardType)dashBoardType;
- (void)reloadView;

- (void)setInfoText:(id)text;

@end
