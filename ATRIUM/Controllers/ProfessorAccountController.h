//
//  ProfessorAccountController.h
//  ATRIUM
//
//  Created by Admin on 10/30/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "BaseController.h"

@class AuthorizationController;
@class UIImagePickerController;

@protocol ProfessorProfileDelegate <NSObject>

-(void)presentController:(UIImagePickerController*)imagePickerController;
-(void)dismissController:(UIImagePickerController*)pickerController;

-(void)backController:(AuthorizationController*)authorizationController;
@end

@interface ProfessorAccountController : BaseController
@property (nonatomic, weak) id <ProfessorProfileDelegate> professorProfileDelegate;
@property (nonatomic, assign) BOOL isViewMode;

- (void)setIsViewMode:(BOOL)isViewMode;
@end
