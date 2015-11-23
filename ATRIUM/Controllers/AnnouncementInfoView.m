//
//  AnnouncementInfoView.m
//  ATRIUM
//
//  Created by Admin on 11/10/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AnnouncementInfoView.h"
#import "Photo.h"

@interface AnnouncementInfoView()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate>
@end

@implementation AnnouncementInfoView
- (void)createAndLayoutSubviews {
    left = 20.f;
    top = 0.f;
    
    if (!self.photoUrl) {
        self.profilePhoto = [NSString stringWithFormat:@"%@", self.photoUrl];
    } else {
        self.profilePhoto = @"";
    }
    
    self.profileImageBtn = [[CustomBtn alloc] initWithFrame:CGRectMake(left + 60, top, 140, 140)];
    //        self.profileImageBtn.layer.borderWidth = 2;
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.profileImageBtn.width, self.profileImageBtn.height)];
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.left = 0.5 * (self.profileImageBtn.width - self.profileImageView.width);
    self.profileImageView.top = 0.5 * (self.profileImageBtn.height - self.profileImageView.height);
    self.profileImageView.layer.cornerRadius = 0.5 * self.profileImageView.width;
    self.profileImageView.layer.masksToBounds = YES;
    //    self.profileImageView.layer.borderWidth = 1.0f;
    //    self.profileImageView.layer.borderColor = [UIColor blueColor].CGColor;
    self.profileImageView.backgroundColor = [UIColor whiteColor];
//    self.profileImageView.image = [UIImage imageNamed:@"add_photo_student.png"];
        [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]];
    [self.profileImageBtn addSubview:self.profileImageView];
    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
    self.profileImageBtn.backgroundColor = [UIColor clearColor];
    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
    [self.profileImageBtn addTarget:self action:@selector(addPhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.profileImageBtn];
    
    top = 150;
    labelWidth = 270;
    labelHeight = 20.f;
    textFieldHeight = 30.f;
    CGFloat textViewHeight = 160;
    
    self.titleLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                     withTitle:[TRANSLATE(@"Group Name") uppercaseString]];
    self.titleLabel.textColor = rgbColor(73, 108, 148);
    
    top += self.titleLabel.height;
    self.titleTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    //    self.fullNameTextField.placeholder = @"LITERATURE TEACHER";
    self.titleTextField.backgroundColor = rgbColor(237, 244, 250);
    
    top += self.titleTextField.height;
    self.descriptionLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                            withTitle:[TRANSLATE(@"Group Description") uppercaseString]];
    self.descriptionLabel.textColor = rgbColor(73, 108, 148);
    
    top += self.descriptionLabel.height;
    self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(left, top, labelWidth, textViewHeight)];
    self.descriptionTextView.backgroundColor = rgbColor(237, 244, 250);
    self.descriptionTextView.editable = YES;
    self.descriptionTextView.delegate = self;
    self.descriptionTextView.textColor = rgbColor(37, 66, 97);
    self.descriptionTextView.scrollEnabled = YES;
    self.descriptionTextView.font = FONT_SANSUMI(20);
    self.descriptionTextView.layer.cornerRadius = 5.f;
    self.descriptionTextView.layer.masksToBounds = YES;
    //    self.groupNameTextField.returnKeyType = UIReturnKeyDone;
    [self addSubview:self.descriptionTextView];
    
}

- (void)addPhotoBtnClicked:(id)sender {
    
    [self.navigationController.topViewController.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:TRANSLATE(@"Add Photo")
                                                             delegate:self
                                                    cancelButtonTitle:TRANSLATE(@"Cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:TRANSLATE(@"Take a photo"), TRANSLATE(@"Choose a photo"), nil];
    actionSheet.tag = 1;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.navigationController.topViewController.view];
    
    
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
            
            
            [self.profileImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
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
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
//        [self.profileImageView setImage:image];
        [self uploadAndSetProfileImage:image];
    }];
    
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
                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }];
        } else {
            [self.navigationController presentViewController:controller animated:YES completion:nil];
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
                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }];
        } else {
            [self.navigationController presentViewController:controller animated:YES completion:nil];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.titleTextField isEqual:textField]) {
        textField.returnKeyType = UIReturnKeyDone;
    }
    
    [self.baseDelegate baseInfoView:self withActionType:1 withValue:textField];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self.baseDelegate baseInfoView:self withActionType:-3 withValue:textField];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.titleTextField isEqual:textField]) {
        [self.titleTextField resignFirstResponder];
    }
    
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.descriptionTextView isEqual:textView]) {
        [self.baseDelegate baseInfoView:self withActionType:-1 withValue:textView];
    }
    if ([self.descriptionTextView isEqual:textView]) {
        textView.returnKeyType = UIReturnKeyDone;
    }
    return YES;
}
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        [self.baseDelegate baseInfoView:self withActionType:-2 withValue:textView];
        return NO;
    }else{
        [self.baseDelegate baseInfoView:self withActionType:-2 withValue:textView];
        return YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
