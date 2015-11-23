//
//  PatientSignedDocumentForSave.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/22/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "PatientSignedDocumentForSave.h"

@implementation PatientSignedDocumentForSave


- (SelectItem *)guardian {
    if (!_guardian) {
        _guardian = [SelectItem new];
    }
    return _guardian;
}

@end
