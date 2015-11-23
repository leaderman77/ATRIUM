//
//  StaffData.m
//  Dental-iPad
//
//  Created by Sanch0 on 10/14/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

@implementation StaffData

- (NSString *)name {
    NSMutableString *fullName = [[NSMutableString alloc] initWithString:self.firstName ? self.firstName : @""];
    if (self.lastName) {
        if (fullName.length > 0) {
            [fullName appendString:@" "];
        }
        [fullName appendString:self.lastName];
    }
    return fullName;
}


- (SelectItem *)toSelectItem {
    SelectItem *selectItem = [[SelectItem alloc] initWithId:self.objectId withName:self.name];
    return selectItem;
}

- (NSString *)autocompleteString {
    return self.name;
}

@end
