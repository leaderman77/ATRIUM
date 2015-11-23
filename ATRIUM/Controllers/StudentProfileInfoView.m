//
//  StudentProfileInfoView.m
//  ATRIUM
//
//  Created by Admin on 11/1/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "StudentProfileInfoView.h"
#import "DateTimePicker.h"

@interface StudentProfileInfoView() <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) DateTimePicker* picker;
@end
@implementation StudentProfileInfoView
@synthesize isViewMode = _isViewMode;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //    [self setNeedsUpdateConstraints];
}
- (void)createAndLayoutSubviews {
//    [super createAndLayoutSubviews];
    //create faculty member select button
    left = 15.f;
    top = 0.f;
    
    self.profileImageBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(left + 70, top, 130, 130)];
    //    self.profileImageBtn.layer.borderWidth = 2;
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.profileImageBtn.width, self.profileImageBtn.height)];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.left = 0.5 * (self.profileImageBtn.width - self.profileImageView.width);
    self.profileImageView.top = 0.5 * (self.profileImageBtn.height - self.profileImageView.height);
    self.profileImageView.layer.cornerRadius = 0.5 * self.profileImageView.width;
    self.profileImageView.layer.masksToBounds = YES;
    //    self.profileImageView.layer.borderWidth = 1.0f;
    //    self.profileImageView.layer.borderColor = [UIColor blueColor].CGColor;
    self.profileImageView.backgroundColor = [UIColor whiteColor];
//    self.profileImageView.image = [UIImage imageNamed:@"Scofield.png"];  //[UIImage imageNamed:@"add_photo_student.png"];
        [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]];
    [self.profileImageBtn addSubview:self.profileImageView];
    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
    self.profileImageBtn.backgroundColor = [UIColor clearColor];
    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
        [self.profileImageBtn addTarget:self action:@selector(addPhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.profileImageBtn];
    
    top = 150;
    labelWidth = 270;
    labelHeight = 12.f;
    textFieldHeight = 30.f;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    _picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2 - 35, screenWidth, screenHeight/2 + 35)];
    [_picker addTargetForDoneButton:self action:@selector(donePressed)];
    //    [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
    //    [self.view addSubview:picker];
    _picker.hidden = NO;
    [_picker setMode:UIDatePickerModeDate];
    [_picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    self.emailNameLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                  withTitle:[TRANSLATE(@"E-mail") uppercaseString]];
    top += self.emailNameLabel.height;
    self.emailTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    self.emailTextField.placeholder = @"SAMPLE@EMAIL.COM";
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    
    top += self.emailTextField.height;
    self.dobLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                     withTitle:TRANSLATE(@"Date of birth")];
    top += self.dobLabel.height;
    self.dobDateTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:!self.isViewMode];
    self.dobDateTextField.placeholder = @"23 February 1987";
    self.dobDateTextField.inputView = self.picker;
    
    top += self.dobDateTextField.height;
    self.phoneLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                               withTitle:TRANSLATE(@"Phone Number")];
    top += self.phoneLabel.height;
    self.phoneTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    self.phoneTextField.placeholder = @"189 98 89 23";

    
//    self.emailNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)];
//    self.emailNameLabel.font = FONT_SANSUMI_BOLD(10);
//    
//    self.emailNameLabel.text = [TRANSLATE(@"E-mail") uppercaseString];
//    //    self.loginTitleLabel.hidden = YES;
//    self.emailNameLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.emailNameLabel];
//    
//    self.emailTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top + 15, textFieldWidth, textFieldHeight)];
//    self.emailTextField.delegate = self;
//    self.emailTextField.placeholder = @"SAMPLE@EMAIL.COM";
//    self.emailTextField.backgroundColor = [UIColor clearColor];     //rgbColor(236, 243, 249);
//    self.emailTextField.font = FONT_SANSUMI(20);
//    self.emailTextField.textColor = rgbColor(0, 65, 107);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.emailTextField.leftView = paddingView2;
//    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.emailTextField.layer.cornerRadius = 5.f;
//    self.emailTextField.layer.masksToBounds = YES;
//    self.emailTextField.returnKeyType = UIReturnKeyNext;
//    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
//    [self.scrollView addSubview:self.emailTextField];
//    
//    self.dobLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top + 60, labelWidth, labelHeight)];
//    self.dobLabel.font = FONT_SANSUMI_BOLD(10);
//    self.dobLabel.textColor = rgbColor(0, 164, 234);
//    self.dobLabel.text = [TRANSLATE(@"Date of birth") uppercaseString];
//    //    self.loginTitleLabel.hidden = YES;
//    self.dobLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.dobLabel];
//    
//    self.dobDateTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top + 75, textFieldWidth, textFieldHeight)];
//    self.dobDateTextField.delegate = self;
//    self.dobDateTextField.placeholder = @"23 February 1987";
//    [self.dobDateTextField setRightArrowVisible:NO];
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.dobDateTextField.backgroundColor = [UIColor clearColor];   //rgbColor(236, 243, 249);
//    self.dobDateTextField.font = FONT_SANSUMI(20);
//    self.dobDateTextField.textColor = rgbColor(0, 65, 107);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.dobDateTextField.leftView = paddingView3;
//    self.dobDateTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.dobDateTextField.layer.cornerRadius = 5.f;
//    self.dobDateTextField.layer.masksToBounds = YES;
//    self.dobDateTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.dobDateTextField];
//    
//    //    self.dobMonthTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 90, top + 177, textFieldWidth / 2 - 30, textFieldHeight)];
//    //    self.dobMonthTextField.delegate = self;
//    //    [self.dobMonthTextField setRightArrowVisible:YES];
//    //    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    //    self.dobMonthTextField.backgroundColor = rgbColor(236, 243, 249);
//    //    self.dobMonthTextField.font = FONT_SANSUMI(20);
//    //    self.dobMonthTextField.textColor = rgbColor(121, 143, 172);
//    //    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    //    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    //    self.dobMonthTextField.leftView = paddingView7;
//    //    self.dobMonthTextField.leftViewMode = UITextFieldViewModeAlways;
//    //    self.dobMonthTextField.layer.cornerRadius = 5.f;
//    //    self.dobMonthTextField.layer.masksToBounds = YES;
//    //    self.dobMonthTextField.returnKeyType = UIReturnKeyNext;
//    //    [self.scrollView addSubview:self.dobMonthTextField];
//    //
//    //    self.dobYearTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left + 240, top + 177, textFieldWidth / 2 - 65, textFieldHeight)];
//    //    self.dobYearTextField.delegate = self;
//    //    [self.dobYearTextField setRightArrowVisible:YES];
//    //    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    //    self.dobYearTextField.backgroundColor = rgbColor(236, 243, 249);
//    //    self.dobYearTextField.font = FONT_SANSUMI(20);
//    //    self.dobYearTextField.textColor = rgbColor(121, 143, 172);
//    //    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    //    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    //    self.dobYearTextField.leftView = paddingView8;
//    //    self.dobYearTextField.leftViewMode = UITextFieldViewModeAlways;
//    //    self.dobYearTextField.layer.cornerRadius = 5.f;
//    //    self.dobYearTextField.layer.masksToBounds = YES;
//    //    self.dobYearTextField.returnKeyType = UIReturnKeyNext;
//    //    [self.scrollView addSubview:self.dobYearTextField];
//    
//    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 10, top + 125, labelWidth, labelHeight)];
//    self.phoneLabel.font = FONT_SANSUMI_BOLD(10);
//    self.phoneLabel.textColor = rgbColor(0, 164, 234);
//    self.phoneLabel.text = [TRANSLATE(@"Phone Number") uppercaseString];
//    //    self.loginTitleLabel.hidden = YES;
//    self.phoneLabel.backgroundColor = [UIColor clearColor];
//    [self.scrollView addSubview:self.phoneLabel];
//    
//    self.phoneTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top + 140, textFieldWidth, textFieldHeight)];
//    self.phoneTextField.delegate = self;
//    self.phoneTextField.placeholder = @"189 98 89 23";
//    //    self.passwordTextField.borderStyle = UITextBorderStyleNone;
//    self.phoneTextField.backgroundColor = [UIColor clearColor];   //rgbColor(236, 243, 249);
//    self.phoneTextField.font = FONT_SANSUMI(20);
//    self.phoneTextField.textColor = rgbColor(0, 65, 107);
//    //    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
//    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
//    self.phoneTextField.leftView = paddingView4;
//    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.phoneTextField.layer.cornerRadius = 5.f;
//    self.phoneTextField.layer.masksToBounds = YES;
//    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.phoneTextField.returnKeyType = UIReturnKeyNext;
//    [self.scrollView addSubview:self.phoneTextField];


}
- (void)populateTextField:(CustomTextField *)textField withText:(NSString *)text {
    NSString *title = (self.isViewMode && text.length == 0) ? TRANSLATE(@"N/A") : text;
    UIColor *color = !self.isViewMode ? [UIColor blueColor] : [UIColor blackColor];
    textField.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:color];
}
- (void)populateProfessorProfileDetails {
    
    NSUserDefaults *loginDetails = [NSUserDefaults standardUserDefaults];
    NSString *email = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"email"];
    NSString *dob = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"birthDate"];
    NSString *phone = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"phoneNumber"];
//    NSString *position = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"position"];
    
//    [self populateTextField:self.positionTextField withText:position];
    self.photoUrl = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"photo"];
    
    self.profilePhoto = [NSString stringWithFormat:@"%@", self.photoUrl];
    
    [self.profileImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]
               usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self populateTextField:self.emailTextField withText:email];
    [self populateTextField:self.dobDateTextField withText:dob];
    [self populateTextField:self.phoneTextField withText:phone];
}

- (void)setIsViewMode:(BOOL)isViewMode {
    _isViewMode = isViewMode;
    [self changeEditMode:self.positionTextField];
    [self changeEditMode:self.emailTextField];
    [self changeEditMode:self.dobDateTextField];
    [self changeEditMode:self.phoneTextField];
}
- (void)changeEditMode:(CustomTextField *)textField {
    textField.backgroundColor = self.isViewMode ? [UIColor clearColor] : rgbColor(236, 243, 249);
    textField.enabled = !self.isViewMode;
    textField.borderStyle = UITextBorderStyleNone;
//    textField.layer.borderWidth = self.isViewMode ? 0.f : 1.f;
    textField.font = self.isViewMode ? FONT_SANSUMI(15.f) : FONT_SANSUMI(15.f);
    textField.textColor = self.isViewMode ? [UIColor blackColor] : [UIColor blackColor];
    textField.leftViewMode = self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
    self.dobDateTextField.rightViewMode = !self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
//    self.positionTextField.placeholder = self.isViewMode ? @"STUDENT" : @"";
    self.emailTextField.placeholder = self.isViewMode ? @"SAMPLE@EMAIL.COM" : @"";
    self.dobDateTextField.placeholder = self.isViewMode ? @"23 February 1987" : @"";
    self.phoneTextField.placeholder = self.isViewMode ? @"189 98 89 23" : @"";
    
    //    self.rightDropDownView.hidden = self.isViewMode;
}
- (void)pickerChanged:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    self.dobDateTextField.text = [formatter stringFromDate:[(UIDatePicker*)sender date]];
    NSLog(@"value: %@",[sender date]);
}
-(void)donePressed {
    //    picker.hidden = YES;
    NSLog(@"Done button tapped");
    [self.dobDateTextField resignFirstResponder];
}
- (void)addPhotoBtnClicked:(id)sender {
    if (!self.isViewMode) {
        [self.navigationController.topViewController.view endEditing:YES];
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:TRANSLATE(@"Add Photo")
                                                                 delegate:self
                                                        cancelButtonTitle:TRANSLATE(@"Cancel")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:TRANSLATE(@"Take a photo"), TRANSLATE(@"Choose a photo"), nil];
        actionSheet.tag = 1;
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//        [actionSheet showInView:self.navigationController.topViewController.view];
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
}

- (void)setProfileImage:(UIImage *)image {
    self.profileImageView.image = image ? image : [UIImage imageNamed:@"add_photo_teacher.png"];
}

- (void)uploadAndSetProfileImage:(UIImage *)image {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.left = 0.5 * (self.profileImageView.width - indicatorView.width);
    indicatorView.top = 0.5 * (self.profileImageView.height - indicatorView.height);
    indicatorView.color = [UIColor blackColor];
    indicatorView.tag = 2;
    [indicatorView startAnimating];
    [self.profileImageView addSubview:indicatorView];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [[RestClient sharedClient] uploadImageByPath:METHOD_UPLOAD_PHOTO withData:imageData callback:^(NSDictionary *responseDic, NSError *error) {
        [[self.profileImageView viewWithTag:2] removeFromSuperview];
        if (!error) {
            self.profilePhoto = [NSString stringWithFormat:@"http://prev.gio.uz/%@", [[responseDic[@"data"] objectAtIndex:0] objectForKey:@"fd"]];
            self.photoUrl = [NSURL URLWithString:_profilePhoto];
            
            
            [self.profileImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]
                       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
//            self.photo = [[Photo alloc] initWithDictionary:responseDic[@"data"] error:nil];
//            [self.profileImageView setImageWithURL:self.photo.url placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]
//                       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
    }];
}

- (void)populateWithPatientSignature:(PatientSignatureFormForShow *)patientSignatureFormForShow {
    [super populateWithPatientSignature:patientSignatureFormForShow];
    //    [self.profileImageView sd_setImageWithURL:self.patientDetails.photo.url placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]];
    //    self.photo = self.patientDetails.photo;
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            [self takeNewPhotoFromCamera];
        } else if (buttonIndex == 1) {
            [self choosePhotoFromExistingImages];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if ([self.studentProfileInfoViewDelegate respondsToSelector:@selector(dismissImagePickerController:)]) {
        [self.studentProfileInfoViewDelegate dismissImagePickerController:picker];
    }
    UIImage *image = info[UIImagePickerControllerEditedImage];
//    [self.profileImageView setImage:image];
            [self uploadAndSetProfileImage:image];

    
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        UIImage *image = info[UIImagePickerControllerEditedImage];
//        [self.profileImageView setImage:image];
//        //        [self uploadAndSetProfileImage:image];
//    }];
    
    //    UIImage *image = info[UIImagePickerControllerEditedImage];
    //	UIImage *image = [self resizeImage:[info valueForKey:UIImagePickerControllerEditedImage] width:540.f height:540.f];
    //	[self uploadImage:image];
    //	UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    
}

- (void)takeNewPhotoFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = YES;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        controller.delegate = self;
        
        if (SYSTEM_VERSION >= 8.0) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if ([self.studentProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                    [self.studentProfileInfoViewDelegate presentImagePickerController:controller];
                }
//                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }];
        } else {
            if ([self.studentProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                [self.studentProfileInfoViewDelegate presentImagePickerController:controller];
            }
//            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
    } else {
        ALERT(TRANSLATE(@"Your device is not support photo camera."));
    }
}

- (void)choosePhotoFromExistingImages {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = YES;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        controller.delegate = self;
        if (SYSTEM_VERSION >= 8.0) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if ([self.studentProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                    [self.studentProfileInfoViewDelegate presentImagePickerController:controller];
                }
//                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }];
        } else {
            if ([self.studentProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                [self.studentProfileInfoViewDelegate presentImagePickerController:controller];
            }
//            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
    }
}

- (void)populatePatientDetails {
    [super populatePatientDetails];
    //    self.patientDetails.photo = self.photo;
}

- (BOOL)validateAndPopulatePatientDetails {
    if ([super validateAndPopulatePatientDetails]) {
        return YES;
    }
    if (self.photo == nil) {
        [self.scrollView setContentOffset:CGPointMake(0, self.top) animated:YES];
        ALERT(@"Please, upload your photo.");
        return YES;
    }
    //    self.patientDetails.photo = self.photo;
    return NO;
}

#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if([self.emailTextField isEqual:textField]){
        [self.dobDateTextField becomeFirstResponder];
    } else if([self.dobDateTextField isEqual:textField]){
        [self.phoneTextField becomeFirstResponder];
    } else if ([self.phoneTextField isEqual:textField]) {
        [self.phoneTextField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if([self.emailTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if([self.dobDateTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if ([self.phoneTextField resignFirstResponder]) {
        textField.returnKeyType = UIReturnKeyDone;
    }
    
    [self.baseDelegate baseInfoView:self withActionType:1 withValue:textField];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.dobDateTextField isEqual:textField]) {
        [self.baseDelegate baseInfoView:self withActionType:-1 withValue:textField];
    } else if ([self.phoneTextField isEqual:textField]) {
        [self.baseDelegate baseInfoView:self withActionType:-2 withValue:textField];
    }
    
}
@end
