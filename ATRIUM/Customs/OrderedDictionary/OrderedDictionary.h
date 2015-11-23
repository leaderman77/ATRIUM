//
// Created by Sanch0 on 5/5/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OrderedDictionary : NSObject

@property (nonatomic, readonly) NSUInteger count;

- (NSArray *)allValues;

- (NSArray *)allKeys;

- (void)removeAllObjects;

- (id)objectAtIndex:(NSInteger)index;

- (id)objectForKey:(id)key;

- (void)removeObjectAtIndex:(NSInteger)index;

- (void)insertObject:(id)object atIndex:(NSInteger)index;

- (BOOL)containsKey:(id)key;

- (void)setObject:(id)value forKey:(id)key;

- (void)removeObjectForKey:(id)key;

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block;
@end