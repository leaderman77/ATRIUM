//
// Created by Sanch0 on 5/5/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "OrderedDictionary.h"

@interface OrderedDictionary ()

@property (nonatomic, strong) NSMutableOrderedSet *orderedKeys;
@property (nonatomic, strong) NSMutableDictionary *valuesDic;
@property (nonatomic, strong) NSMutableArray *values;

@end

@implementation OrderedDictionary {

}


- (NSMutableOrderedSet *)orderedKeys {
    if (!_orderedKeys) {
        _orderedKeys = [[NSMutableOrderedSet alloc] init];
    }
    return _orderedKeys;
}

- (NSMutableDictionary *)valuesDic {
    if (!_valuesDic) {
        _valuesDic = [NSMutableDictionary new];
    }
    return _valuesDic;
}

- (void)setObject:(id)value forKey:(id)key {
    self.valuesDic[key] = value;
    [self.orderedKeys addObject:key];
}

- (void)removeObjectForKey:(id)key {
    [self.valuesDic removeObjectForKey:key];
    [self.orderedKeys removeObject:key];
}


- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
    [self.orderedKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(self.valuesDic[obj], idx, stop);
    }];
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block {
    [self.orderedKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, self.valuesDic[obj], stop);
    }];
}


- (NSArray *)allKeys {
    return [self.orderedKeys array];
}

- (void)removeAllObjects {
    [self.orderedKeys removeAllObjects];
    [self.valuesDic removeAllObjects];
}


- (NSArray *)allValues {
    @try {
        __block NSMutableArray *values = [[NSMutableArray alloc] init];
        [self.orderedKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [values addObject:self.valuesDic[obj]];
        }];
        return values;
    } @catch (NSException *ex) {
        return @[];
    }
}


- (id)objectAtIndex:(NSInteger)index {
    @try {
        return [self.valuesDic objectForKey:[self.orderedKeys objectAtIndex:index]];
    } @catch (NSException *ex) {
        return nil;
    }
}


- (void)removeObjectAtIndex:(NSInteger)index {
    @try {
        [self.valuesDic removeObjectForKey:[self.orderedKeys objectAtIndex:index]];
        [self.orderedKeys removeObjectAtIndex:index];
    } @catch (NSException *ex) {
        DLog(@"NSException (exception with remove) = %@", ex);
    }
}

- (id)objectForKey:(id)key {
    return key ? self.valuesDic[key] : nil;
}


- (BOOL)containsKey:(id)key {
    if (key) {
        return [self.valuesDic objectForKey:key] ? YES : NO;
    }
    return NO;
}

- (NSUInteger)count {
    return self.valuesDic.count;
}


@end