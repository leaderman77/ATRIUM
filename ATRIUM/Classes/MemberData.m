//
//  MemberData.m
//  ATRIUM
//
//  Created by Admin on 10/19/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "MemberData.h"

@implementation MemberData
- (NSString*)email {
    NSMutableString *emailAddress = [[NSMutableString alloc]initWithString:self.email];
    return emailAddress;
}

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
