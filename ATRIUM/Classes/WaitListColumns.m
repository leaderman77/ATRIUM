//
// Created by Sanch0 on 1/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "WaitListColumns.h"
#import "FollowUpTableList.h"
#import "WaitingTableList.h"
#import "DentalChartTableList.h"


@implementation WaitListColumns {

}

- (NSArray *)listByColumn:(NSInteger)column {
    NSArray *list = self.followUp.list;
    switch (column) {
        case 0:
            list = self.followUp.list;
            break;
        case 1:
            list = self.dentalChart.list;
            break;
        case 2:
            list = self.waiting.list;
            break;
    }
    return list;
}

@end