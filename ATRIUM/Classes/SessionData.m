//
//  SessionData.m
//  Dental-iPad
//
//  Created by Sanch0 on 10/15/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

@implementation SessionData

- (NSSet <Ignore> *)permissionsSet {
    if (!_permissionsSet) {
        _permissionsSet = [[NSSet alloc] initWithArray:self.permissions];
    }
    return _permissionsSet;
}

- (void)setPermissions:(NSArray *)permissions {
    _permissions = permissions;
    self.permissionsSet = nil;
}


@end
