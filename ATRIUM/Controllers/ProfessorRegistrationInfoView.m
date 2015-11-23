//
//  ProfessorRegistrationInfoView.m
//  ATRIUM
//
//  Created by Admin on 11/3/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "ProfessorRegistrationInfoView.h"
#import "DateTimePicker.h"
#import "Photo.h"

@interface ProfessorRegistrationInfoView()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) DateTimePicker* picker;

@property (nonatomic, strong) UIPickerView *positionPicker;
@property (nonatomic, strong) NSArray *pickerData;
@end

@implementation ProfessorRegistrationInfoView

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
    self.profileImageView.backgroundColor = rgbColor(22, 168, 235);
    self.profileImageView.image = [UIImage imageNamed:@"add_photo_teacher.png"];
    [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]];
    [self.profileImageBtn addSubview:self.profileImageView];
    //    self.profileImageBtn.backgroundColor = UIColorFromRGBWithAlpha(0x197373, 0.2);
    self.profileImageBtn.backgroundColor = rgbColor(22, 168, 235);
    self.profileImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.profileImageBtn.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //    [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateNormal placeholderImage:nil];
    //     [self.profileImageBtn sd_setImageWithURL:self.patientForList.photoUrl forState:UIControlStateHighlighted placeholderImage:nil];
    [self.profileImageBtn addTarget:self action:@selector(addPhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.profileImageBtn];
    
    top = 140;
    CGFloat leftTextField = 10;
    labelWidth = 280;
    labelHeight = 15.f;
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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(pickerDoneButtonClicked:)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style: UIBarButtonItemStyleBordered target: self action: @selector(cancelPressed)];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
    
//    [self.positionPicker addSubview: toolbar];
    
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
    
    self.fullNameLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                    withTitle:[TRANSLATE(@"Full Name") uppercaseString]];
    self.fullNameLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.fullNameLabel.height;
    self.fullNameTextField = [self textFieldWithFrame:CGRectMake(leftTextField, top, labelWidth, textFieldHeight) withArrow:NO];
//    self.fullNameTextField.placeholder = @"LITERATURE TEACHER";
    
    top += self.fullNameTextField.height;
    self.positionLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                    withTitle:[TRANSLATE(@"Position") uppercaseString]];
    self.positionLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.positionLabel.height;
    self.positionTextField = [self textFieldWithFrame:CGRectMake(leftTextField, top, labelWidth, textFieldHeight) withArrow:NO];
//    self.positionTextField.placeholder = @"LITERATURE TEACHER";
    self.positionTextField.inputView = self.positionPicker;
    self.positionTextField.inputAccessoryView = toolbar;
    
    top += self.positionTextField.height;
    self.emailNameLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                     withTitle:[TRANSLATE(@"E-mail") uppercaseString]];
    self.emailNameLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.emailNameLabel.height;
    self.emailTextField = [self textFieldWithFrame:CGRectMake(leftTextField, top, labelWidth, textFieldHeight) withArrow:NO];
//    self.emailTextField.placeholder = @"SAMPLE@EMAIL.COM";
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    
    top += self.emailTextField.height;
    self.dobLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                               withTitle:[TRANSLATE(@"Date of birth") uppercaseString]];
    self.dobLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.dobLabel.height;
    self.dobDateTextField = [self textFieldWithFrame:CGRectMake(leftTextField, top, labelWidth, textFieldHeight) withArrow:YES];
//    self.dobDateTextField.placeholder = @"23 February 1987";
    self.dobDateTextField.inputView = _picker;
    
    top += self.dobDateTextField.height;
    self.phoneLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth, labelHeight)
                                 withTitle:[TRANSLATE(@"Phone Number") uppercaseString]];
    self.phoneLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.phoneLabel.height;
    self.phoneTextField = [self textFieldWithFrame:CGRectMake(leftTextField, top, labelWidth, textFieldHeight) withArrow:NO];
//    self.phoneTextField.placeholder = @"189 98 89 23";
    
    top += self.phoneTextField.height;
    self.passwordLabel = [self labelWithFrame:CGRectMake(left, top, labelWidth / 2, labelHeight)
                                 withTitle:[TRANSLATE(@"Password") uppercaseString]];
    self.passwordLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.passwordLabel.height;
    self.passwordTextField = [self textFieldWithFrame:CGRectMake(leftTextField, top, labelWidth / 2 - 10, textFieldHeight) withArrow:NO];
    self.passwordTextField.secureTextEntry = YES;
    
    top = top - 15;
    self.confmPasswordLabel = [self labelWithFrame:CGRectMake(left + self.passwordLabel.width, top, labelWidth / 2, labelHeight)
                                    withTitle:[TRANSLATE(@"Confirm Password") uppercaseString]];
    self.confmPasswordLabel.textColor = rgbColor(69, 98, 138);
    
    top += self.confmPasswordLabel.height;
    self.confmPasswordTextField = [self textFieldWithFrame:CGRectMake(leftTextField + self.passwordTextField.width + 20, top, labelWidth/2 - 10, textFieldHeight) withArrow:NO];
    self.confmPasswordTextField.secureTextEntry = YES;
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

//-(void)cancelPressed {
//    NSLog(@"Cancel pressed");
//    self.dobDateTextField.returnKeyType = UIReturnKeyNext;
//}

- (NSArray *)pickerData {
    
    if (!_pickerData) {
        _pickerData = @[@"Teacher", @"Dean", @"Research assistant", @"Course leader", @"Course assistant"];
    }
    return _pickerData;
}
- (void)pickerDoneButtonClicked:(id)sender {
    [self.positionTextField resignFirstResponder];
}
- (CustomTextField *)textFieldWithFrame:(CGRect)frame withArrow:(BOOL)flag {
    CustomTextField *textField = [[CustomTextField alloc] initWithFrame:frame];
    textField.backgroundColor = rgbColor(63, 183, 232);
    textField.enabled = YES;
    textField.delegate = self;
        textField.borderStyle = UITextBorderStyleNone;
//    textField.layer.cornerRadius = 5.f;
//    textField.layer.masksToBounds = YES;
    //    textField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    textField.layer.borderWidth = 0.f;
    textField.font = FONT_SANSUMI_BOLD(14.f);
    textField.textColor = rgbColor(255, 255, 255);
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    textField.placeholder = @"";
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    if (flag) {
        UIImageView *rightDropDownView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown.png"]];
        rightDropDownView.contentMode = UIViewContentModeCenter;
        rightDropDownView.width = 30;
        rightDropDownView.left = textField.width - rightDropDownView.width - 20;
        rightDropDownView.top = 0.5 * (textField.height - rightDropDownView.height);
        //        [textField addSubview:rightDropDownView];
        textField.rightView = rightDropDownView;//[[UIView alloc] initWithFrame:CGRectMake(0, 0, rightDropDownView.width + 10, 0)];
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    [self addSubview:textField];
    return textField;
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
#pragma textfiled detils

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.fullNameTextField isEqual:textField]) {
        textField.returnKeyType = UIReturnKeyNext;
    } else if ([self.positionTextField isEqual:textField]) {
        textField.returnKeyType = UIReturnKeyNext;
    } else if ([self.emailTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if([self.dobDateTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if ([self.phoneTextField isEqual:textField]) {
        textField.returnKeyType = UIReturnKeyNext;
    } else if([self.passwordTextField isEqual:textField]){
        textField.returnKeyType = UIReturnKeyNext;
    } else if ([self.confmPasswordTextField isEqual:textField]) {
        textField.returnKeyType = UIReturnKeyDone;
    }
    
    [self.baseDelegate baseInfoView:self withActionType:1 withValue:textField];
    return YES;
}
#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.fullNameTextField isEqual:textField]) {
        [self.positionTextField becomeFirstResponder];
    } else if ([self.positionTextField isEqual:textField]) {
        [self.emailTextField becomeFirstResponder];
    } else if ([self.emailTextField isEqual:textField]){
        [self.dobDateTextField becomeFirstResponder];
    } else if([self.dobDateTextField isEqual:textField]){
        [self.phoneTextField becomeFirstResponder];
    } else if ([self.phoneTextField isEqual:textField]) {
        [self.passwordTextField becomeFirstResponder];
    } else if([self.passwordTextField isEqual:textField]){
        [self.confmPasswordTextField becomeFirstResponder];
    } else if ([self.confmPasswordTextField isEqual:textField]) {
        [self.confmPasswordTextField resignFirstResponder];
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.dobDateTextField isEqual:textField]) {
        [self.baseDelegate baseInfoView:self withActionType:-1 withValue:textField];
    } else if ([self.positionTextField isEqual:textField]) {
        [self.baseDelegate baseInfoView:self withActionType:-2 withValue:textField];
    } else if ([self.confmPasswordTextField isEqual:textField]) {
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
