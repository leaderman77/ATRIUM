//
//  PatientDocument.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 2/18/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientDocument.h"

@implementation PatientDocument

//+(JSONKeyMapper*)keyMapper
//{
//	return [self keyMapperWithDic:@{
//                                    @"template": @"formTemplate",
//                                    @"signed": @"isSigned",
//									}];
//}


+ (void)sortPatientDocumentsWithUnSignedFirst:(NSMutableArray *)documents {
    [documents sortWithOptions:0 usingComparator: ^(PatientDocument *obj1, PatientDocument *obj2) {
        if([obj1.statusCode isEqualToString:kPatientDocumentUnSigned] && ![obj2.statusCode isEqualToString:kPatientDocumentUnSigned]) {
            return NSOrderedAscending;
        } else  if(![obj1.statusCode isEqualToString:kPatientDocumentUnSigned] && [obj2.statusCode isEqualToString:kPatientDocumentUnSigned]) {
            return NSOrderedDescending;
        } else {
            return [obj1.createdDate compare:obj2.createdDate];
        }
    }];
}

+ (NSMutableArray *)getUnsignedPatientDocumentsSortPostedFirst:(NSMutableArray *)documents {
    [self sortPatientDocumentsWithUnSignedFirst:documents];
    NSMutableArray *unsignedDocs = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < documents.count; i++) {
        PatientDocument *doc = [documents objectAtIndex:i];
        if([doc.statusCode isEqualToString:kPatientDocumentUnSigned]) {
            [unsignedDocs addObject:doc];
        } else {
            break;
        }
    }
    return unsignedDocs;
}

@end
