//
//  ProfessorProfileInfoView.m
//  ATRIUM
//
//  Created by Admin on 11/3/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "ProfessorProfileInfoView.h"
#import "DateTimePicker.h"
#import "Photo.h"

@interface ProfessorProfileInfoView ()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) DateTimePicker* picker;

@property (nonatomic, strong) UIPickerView *positionPicker;
@property (nonatomic, strong) NSArray *pickerData;
@end

@implementation ProfessorProfileInfoView
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
    self.profileImageView.backgroundColor = rgbColor(22, 168, 235);
//    self.profileImageView.image = [UIImage imageNamed:@"images.jpeg"];  //[UIImage imageNamed:@"add_photo_student.png"];
    [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]];
    [self.profileImageBtn addSubview:self.profileImageView];
    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
    self.profileImageBtn.backgroundColor = [UIColor clearColor];
    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
//    [self.profileImageBtn sd_setImageWithURL:self.photo.url forState:UIControlStateHighlighted placeholderImage:nil];
    [self.profileImageBtn addTarget:self action:@selector(addPhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.profileImageBtn];
    
    top = 140;
    labelWidth = 270;
    labelHeight = 12.f;
    textFieldHeight = 30.f;
    
    self.positionPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(22, 170, 275, 100)];
    self.positionPicker.backgroundColor = [UIColor whiteColor];
    self.positionPicker.delegate = self;
    self.positionPicker.dataSource = self;
    self.positionPicker.showsSelectionIndicator = YES;
    self.positionPicker.opaque = NO;
    
    //    [self addSubview:self.positionPicker];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, self.positionPicker.width, 40)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(pickerDoneButtonClicked:)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style: UIBarButtonItemStyleBordered target: self action: @selector(cancelPressed)];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
    
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
    
    self.positionLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                    withTitle:[TRANSLATE(@"Position") uppercaseString]];
    self.positionLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.positionLabel.height;
    self.positionTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    self.positionTextField.placeholder = @"LITERATURE TEACHER";
    self.positionTextField.inputView = self.positionPicker;
    self.positionTextField.inputAccessoryView = toolbar;
    
    top += self.positionTextField.height;
    self.emailNameLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                     withTitle:[TRANSLATE(@"E-mail") uppercaseString]];
    self.emailNameLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.emailNameLabel.height;
    self.emailTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    self.emailTextField.placeholder = @"SAMPLE@EMAIL.COM";
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    
    top += self.emailTextField.height;
    self.dobLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                               withTitle:TRANSLATE(@"Date of birth")];
    self.dobLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.dobLabel.height;
    self.dobDateTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:!self.isViewMode];
    self.dobDateTextField.placeholder = @"23 February 1987";
    self.dobDateTextField.inputView = self.picker;
    
    top += self.dobDateTextField.height;
    self.phoneLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                 withTitle:TRANSLATE(@"Phone Number")];
    self.phoneLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.phoneLabel.height;
    self.phoneTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    self.phoneTextField.placeholder = @"189 98 89 23";
}
- (void)populateTextField:(CustomTextField *)textField withText:(NSString *)text {
    NSString *title = (self.isViewMode && text.length == 0) ? TRANSLATE(@"N/A") : text;
    UIColor *color = self.isViewMode ? [UIColor whiteColor] : [UIColor blackColor];
    textField.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:color];
}
- (void)populateProfessorProfileDetails {
    
    NSUserDefaults *loginDetails = [NSUserDefaults standardUserDefaults];
    NSString *email = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"email"];
    NSString *dob = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"birthDate"];
    NSString *phone = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"phoneNumber"];
    NSString *position = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"position"];
    self.photoUrl = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"photo"];
    
    self.profilePhoto = [NSString stringWithFormat:@"%@", self.photoUrl];
    
    [self.profileImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]
               usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self populateTextField:self.positionTextField withText:position];
    [self populateTextField:self.emailTextField withText:[TRANSLATE(email) uppercaseString]];
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
- (void)setInsurance:(CompanyPatientInsurance *)insurance {
//    _insurance = insurance;
//    NSString *photo = [[loginDetails objectForKey:@"loginDetails"] objectForKey:@"photo"];
//    self.photo.url = photo;
    
    [self.profileImageView setImageWithURL:self.photoUrl
                         placeholderImage:[UIImage imageNamed:@"empty_photo.png"]
              usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
//    [self setDisplayProperties];
//    [self addImageButtonsEnabled];
}

- (void)changeEditMode:(CustomTextField *)textField {
    textField.backgroundColor = self.isViewMode ? [UIColor clearColor] : rgbColor(64, 185, 237);
    textField.enabled = !self.isViewMode;
//    textField.borderStyle = UITextBorderStyleNone;
    //    textField.layer.borderWidth = self.isViewMode ? 0.f : 1.f;
    textField.font = FONT_SANSUMI(16.f);
    textField.textColor = [UIColor whiteColor];
    textField.leftViewMode = self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
    self.positionTextField.placeholder = self.isViewMode ? @"LITERATURE TEACHER" : @"";
    self.dobDateTextField.rightViewMode = !self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
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


- (NSArray *)pickerData {
    
    if (!_pickerData) {
        _pickerData = @[[TRANSLATE(@"Teacher") uppercaseString], [TRANSLATE(@"Dean") uppercaseString], [TRANSLATE(@"Research assistant") uppercaseString], [TRANSLATE(@"Course leader") uppercaseString], [TRANSLATE(@"Course assistant") uppercaseString]];
    }
    return _pickerData;
}
- (void)pickerDoneButtonClicked:(id)sender {
    [self.positionTextField resignFirstResponder];
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
//            [self.profileImageView setImage:image];
            
//            self.photo = [[Photo alloc] initWithDictionary:responseDic[@"data"]  error:nil];
           
            self.profilePhoto = [NSString stringWithFormat:@"http://prev.gio.uz/%@", [[responseDic[@"data"] objectAtIndex:0] objectForKey:@"fd"]];
            self.photoUrl = [NSURL URLWithString:_profilePhoto];
            

            [self.profileImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]
                       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
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
    if ([self.professorProfileInfoViewDelegate respondsToSelector:@selector(dismissImagePickerController:)]) {
        [self.professorProfileInfoViewDelegate dismissImagePickerController:picker];
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
                if ([self.professorProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                    [self.professorProfileInfoViewDelegate presentImagePickerController:controller];
                }
//                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }];
        } else {
            
            if ([self.professorProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                [self.professorProfileInfoViewDelegate presentImagePickerController:controller];
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
                if ([self.professorProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                    [self.professorProfileInfoViewDelegate presentImagePickerController:controller];
                }
//                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }];
        } else {
            if ([self.professorProfileInfoViewDelegate respondsToSelector:@selector(presentImagePickerController:)]) {
                [self.professorProfileInfoViewDelegate presentImagePickerController:controller];
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


#pragma mark - UIPickerView delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger count =   0;
    switch (component) {
        case 0:
            count   = [self.pickerData count];
            break;
    }
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title =   @"";
    switch (component) {
        case 0:
            title =  [self.pickerData objectAtIndex:row];
            break;
    }
    return title;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.positionTextField.text = self.pickerData[row];
}

#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.positionTextField isEqual:textField]) {
        [self.emailTextField becomeFirstResponder];
    } else if([self.emailTextField isEqual:textField]){
        [self.dobDateTextField becomeFirstResponder];
    } else if([self.dobDateTextField isEqual:textField]){
        [self.phoneTextField becomeFirstResponder];
    } else if ([self.phoneTextField isEqual:textField]) {
        [self.phoneTextField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.positionTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if([self.emailTextField isEqual:textField]){
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
    } else if ([self.positionTextField isEqual:textField]) {
        [self.baseDelegate baseInfoView:self withActionType:-2 withValue:textField];
    } else if ([self.phoneTextField isEqual:textField]) {
        [self.baseDelegate baseInfoView:self withActionType:-3 withValue:textField];
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
