//
//  GroupChatInfoView.m
//  ATRIUM
//
//  Created by Admin on 11/5/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "GroupChatInfoView.h"
#import "Photo.h"
#import "GroupChatCell.h"
#import "GroupChatSearchCell.h"

@interface GroupChatInfoView()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL isSearchTextFieldActive;
}
@property (nonatomic, retain) NSMutableArray *usersNames;
@property (nonatomic, retain) NSMutableArray *position;

@property (nonatomic, retain) NSMutableArray *userPhoto;
@property (nonatomic, retain) NSArray *filteredNames;

@property (nonatomic, retain) UITableView *autocompleteTableView;
@property (nonatomic, strong) UITableView *groupTableView;

@property (nonatomic, retain) NSMutableArray *members;
@property (nonatomic, retain) NSArray *membersID;
@property (nonatomic, retain) NSString *userId;
@end

@implementation GroupChatInfoView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.members = [[NSMutableArray alloc]init];
        isSearchTextFieldActive = NO;
        [self callApiGroupMethods];
       
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //    [self setNeedsUpdateConstraints];
}
- (void)callApiGroupMethods {
//    [self showLoading:YES];

    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_FIND_USERS withHTTPMethodType:HTTP_POST withParameters:nil callback:^(NSDictionary *responseDic, NSError *error) {
        [self showLoading:NO];
        if (!error && [responseDic[@"status"] integerValue] == 1 && responseDic[@"data"]) {
            DLog(@"success 1 fields");
            //                                                   self.titleArray = [responseDic valueForKey:@"title"];
            self.usersNames = [[responseDic valueForKey:@"data"] valueForKey:@"fullName"];
            self.position = [[responseDic valueForKey:@"data"] valueForKey:@"position"];
            self.userPhoto = [[responseDic valueForKey:@"data"] valueForKey:@"photo"];
            self.membersID = [[responseDic valueForKey:@"data"] valueForKey:@"id"];
            
            [self.autocompleteTableView reloadData];
        } else {
            ALERT(@"Error with saving profile.");
        }
    }];
}

- (void)createAndLayoutSubviews {
    left = 10.f;
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
    
    self.chatTitleLabel = [self labelWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)
                                     withTitle:[TRANSLATE(@"Group chat title") uppercaseString]];
    self.chatTitleLabel.textColor = rgbColor(37, 66, 97);
    
    top += self.chatTitleLabel.height;
    self.chatTitleTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    //    self.fullNameTextField.placeholder = @"LITERATURE TEACHER";
    self.chatTitleTextField.backgroundColor = rgbColor(237, 244, 250);
    self.chatTitleTextField.textColor = rgbColor(121, 143, 172);
    
    top += self.chatTitleTextField.height;
    self.addMemberLabel = [self labelWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)
                                            withTitle:[TRANSLATE(@"Add members") uppercaseString]];
    self.addMemberLabel.textColor = rgbColor(37, 66, 97);
    
//    self.members = [[NSMutableArray alloc]initWithObjects:@"James Bont", @"Abrahm Lincoln", nil];
    
    top += self.addMemberLabel.height;
    self.groupTableView = [[UITableView alloc] initWithFrame:CGRectMake(left + 10, top, labelWidth, 80) style:UITableViewStylePlain];
//        self.groupTableView.layer.borderWidth = 2;
    self.groupTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.groupTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.groupTableView.rowHeight = 40.f;
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.groupTableView.delegate = self;
    self.groupTableView.dataSource = self;
    self.groupTableView.backgroundColor = rgbColor(255, 255, 255);
    [self addSubview:self.groupTableView];
    
//    self.usersNames = [[NSMutableArray alloc]initWithObjects:@"James Bont", @"Abrahm Lincoln", nil];
//    self.position = [[NSMutableArray alloc]initWithObjects:@"Teacher", @"Student", nil];
    
    
    top += self.groupTableView.height + 10;
    self.nameTextField = [self textFieldWithFrame:CGRectMake(left, top, labelWidth, textFieldHeight) withArrow:NO];
    self.nameTextField.placeholder = [TRANSLATE(@"Enter name") uppercaseString];
    self.nameTextField.backgroundColor = rgbColor(237, 244, 250);
    self.nameTextField.textColor = rgbColor(121, 143, 172);
    
    top += self.groupTableView.height + 10;
    _autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(left, top - 60, labelWidth, 250) style:UITableViewStylePlain];
//    autocompleteTableView.layer.borderWidth = 1;
    _autocompleteTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _autocompleteTableView.delegate = self;
    _autocompleteTableView.dataSource = self;
    _autocompleteTableView.scrollEnabled = YES;
    _autocompleteTableView.hidden = YES;
    [self addSubview:_autocompleteTableView];
}

- (IBAction)goPressed {
    
    // Clean up UI
    [self.nameTextField resignFirstResponder];
    _autocompleteTableView.hidden = YES;
    
    // Add the URL to the list of entered URLS as long as it isn't already there
    if (![self.usersNames containsObject:self.nameTextField.text]) {
        [self.usersNames addObject:self.nameTextField.text];
    }
}
- (void)callApiAddGroupChatMemberMethods {
    [self showLoading:YES];
//    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
//    self.userId = [userdefaults2 objectForKey:@"userID"];
    
    NSDictionary *param = @{@"member" :  _userId,
                            @"id" :  self.groupID};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_ADD_GROUP_CHAT_MEMBER withHTTPMethodType:HTTP_POST withParameters:param callback:^(NSDictionary *responseDic, NSError *error) {
        [self showLoading:NO];
        if (!error) {
            DLog(@"success 1 fields");
            //                                                   self.titleArray = [responseDic valueForKey:@"title"];
            [self.groupTableView reloadData];
            [self.autocompleteTableView reloadData];
        } else {
            ALERT(@"Error with saving profile.");
        }
    }];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.groupTableView) {
        return 35;
    } else {
    return 50;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.groupTableView) {
        return self.members.count;
    } else if (tableView == _autocompleteTableView && _autocompleteTableView.hidden == NO) {
        if (isSearchTextFieldActive) {
            return _filteredNames.count;
        } else {
            return self.usersNames.count;
        }
    } else {
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.groupTableView) {
        GroupChatCell *cell = [GroupChatCell cellForTableView:tableView withItem:nil];
//        cell.baseDelegate = self;
        cell.indexPath = indexPath;
        cell.memberNameLabel.text = self.members[indexPath.row];
        return cell;
    } else if (tableView == _autocompleteTableView && _autocompleteTableView.hidden == NO) {
        GroupChatSearchCell *cell = [GroupChatSearchCell cellForTableView:tableView withItem:nil];
//        cell.baseDelegate = self;
        cell.indexPath = indexPath;
        
        if ([self.position[indexPath.row] isEqual:[NSNull null]]) {
            if (isSearchTextFieldActive) {
                cell.userNameLabel.text = self.usersNames[indexPath.row];
                cell.positionLabel.text = @" ";
                self.photoUrl = self.filteredNames[indexPath.row];
                [cell.avatarImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                          usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            } else {
                cell.userNameLabel.text = self.usersNames[indexPath.row];
                cell.positionLabel.text = @" ";
                self.photoUrl = self.userPhoto[indexPath.row];
                [cell.avatarImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                          usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            }
            
        } else {
            if (isSearchTextFieldActive) {
                cell.userNameLabel.text = self.filteredNames[indexPath.row];
                cell.positionLabel.text = self.position[indexPath.row];
                self.photoUrl = self.userPhoto[indexPath.row];
                [cell.avatarImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                          usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            } else {
                cell.userNameLabel.text = self.usersNames[indexPath.row];
                cell.positionLabel.text = self.position[indexPath.row];
                self.photoUrl = self.userPhoto[indexPath.row];
                [cell.avatarImageView setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"add_photo_student.png"]
                          usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            }
        }
        
        
        return cell;
    } else {
        return nil;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.groupTableView) {
        
    } else if (tableView == _autocompleteTableView) {
        self.userId = [NSString stringWithFormat:@"%@", self.membersID[indexPath.row]];
        [self callApiAddGroupChatMemberMethods];
        [self.members addObject:self.usersNames[indexPath.row]];
        
        [self.groupTableView reloadData];
//        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//        self.nameTextField.text = selectedCell.textLabel.text;
    
//        [self goPressed];
    }
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
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    
//    [autocompleteUrls removeAllObjects];
//    for(NSString *curString in self.usersNames) {
//        NSRange substringRange = [curString rangeOfString:substring];
//        if (substringRange.location == 0) {
//            [autocompleteUrls addObject:curString];
//        }
//    }
//    [_autocompleteTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.nameTextField isEqual:textField]) {
        _autocompleteTableView.hidden = NO;
        isSearchTextFieldActive = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self beginswith[cd] %@", textField.text];
        self.filteredNames = [self.usersNames filteredArrayUsingPredicate:predicate];
        
//        NSString *substring = [NSString stringWithString:textField.text];
//        substring = [substring stringByReplacingCharactersInRange:range withString:string];
//        [self searchAutocompleteEntriesWithSubstring:substring];
    }
    if ([string isEqualToString:@""]) {
        _autocompleteTableView.hidden = YES;
    }
    [_autocompleteTableView reloadData];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.chatTitleTextField isEqual:textField]) {
        textField.returnKeyType = UIReturnKeyDone;
    } else if ([self.nameTextField isEqual:textField]) {
        textField.returnKeyType = UIReturnKeyDone;
    }
    
    [self.baseDelegate baseInfoView:self withActionType:1 withValue:textField];
    return YES;
}
#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.chatTitleTextField isEqual:textField]) {
        [self.chatTitleTextField resignFirstResponder];
    } else if ([self.nameTextField isEqual:textField]) {
        [self.nameTextField resignFirstResponder];
        [self.baseDelegate baseInfoView:self withActionType:-2 withValue:textField];
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.chatTitleTextField isEqual:textField]) {
        [self.baseDelegate baseInfoView:self withActionType:-1 withValue:textField];
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
