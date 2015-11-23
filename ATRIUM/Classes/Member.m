//
//  Member.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/16/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "Member.h"
#import "Photo.h"
#import "MemberPermission.h"
#import "MemberEmployment.h"
#import "Photo.h"


@implementation Member

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

/*@property (nonatomic, strong) NSNumber *companyId;
 @property (nonatomic, strong) SelectItem *status;
 @property (nonatomic, strong) NSString *clinicianId;
 @property (nonatomic, strong) NSString *firstName;
 @property (nonatomic, strong) NSString *lastName;
 @property (nonatomic, strong) NSString *middleName;
 @property (nonatomic, strong) NSNumber *birthDate;
 @property (nonatomic, strong) NSString *email;
 @property (nonatomic, strong) NSString *homePhoneNumber;
 @property (nonatomic, strong) NSString *workPhoneNumber;
 @property (nonatomic, strong) NSString *mobilePhoneNumber;
 @property (nonatomic, strong) MemberEmployment *employment;
 @property (nonatomic, strong) Bank *bank;
 @property (nonatomic, strong) Photo *photo;
 @property (nonatomic, strong) NSNumber *patientToCompanyId;
 @property (nonatomic, strong) MemberPermission *memberPermission;
 @property (nonatomic, strong) NSNumber *breakTimeBetweenAppointment;
 @property (nonatomic, strong) SelectItem *gender;*/

- (instancetype)initWithMember:(Member *)member  {
    self = [super init];
    if(self) {
        self.companyId = member.companyId;
        self.status = member.status;
        self.clinicianId = member.clinicianId;
        self.firstName = member.firstName;
        self.lastName = member.lastName;
        self.middleName = member.middleName;
        self.birthDate = member.birthDate;
//        self.
    }
    return self;
}

@end
