//
// Created by Sanch0 on 12/3/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "BaseNeedSignFormList.h"
#import "BaseNeedSignForm.h"




@implementation BaseNeedSignFormList

- (void)sortBaseNeedSignFormListWithUnSignedFirst {
   self.list = (id)[self.list sortedArrayWithOptions:0 usingComparator: ^(BaseNeedSignForm *obj1, BaseNeedSignForm *obj2) {
        if([obj1.statusCode isEqualToString:kDocumentSignStatus_UnSigned] && ![obj2.statusCode isEqualToString:kDocumentSignStatus_UnSigned]) {
            return NSOrderedAscending;
        } else  if(![obj1.statusCode isEqualToString:kDocumentSignStatus_UnSigned] && [obj2.statusCode isEqualToString:kDocumentSignStatus_UnSigned]) {
            return NSOrderedDescending;
        } else {
            return [obj1.createdDate compare:obj2.createdDate];
        }
    }];
}

- (NSArray *)getUnSignedItems; {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"statusCode CONTAINS[cd] %@", kDocumentSignStatus_UnSigned];
    return [self.list filteredArrayUsingPredicate:pred];
//    self.list = (id)[self.list sortedArrayWithOptions:0 usingComparator: ^(BaseNeedSignForm *obj1, BaseNeedSignForm *obj2) {
//        if([obj1.statusCode isEqualToString:kDocumentSignStatus_UnSigned] && ![obj2.statusCode isEqualToString:kDocumentSignStatus_UnSigned]) {
//            return NSOrderedAscending;
//        } else  if(![obj1.statusCode isEqualToString:kDocumentSignStatus_UnSigned] && [obj2.statusCode isEqualToString:kDocumentSignStatus_UnSigned]) {
//            return NSOrderedDescending;
//        } else {
//            return [obj1.createdDate compare:obj2.createdDate];
//        }
//    }];
}

@end