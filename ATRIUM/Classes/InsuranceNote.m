//
//  InsuranceNote.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 8/13/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "InsuranceNote.h"

@implementation InsuranceNote

- (NSString *)getNoteWithTitle {
    if(self.name.length) {
        return [NSString stringWithFormat:@"%@\n%@", self.name, self.body];
    } 
    return self.body;
}

@end
