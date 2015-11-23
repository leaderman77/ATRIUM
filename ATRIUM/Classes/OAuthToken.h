//
//  OAuthToken.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/14/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@interface OAuthToken : BaseObject

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *token_type;
@property (nonatomic, strong) NSString *refresh_token;
@property (nonatomic, strong) NSNumber *expires_in;
@property (nonatomic, strong) NSString *scope;

@end
