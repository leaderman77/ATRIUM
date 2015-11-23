// MessageComposerView.m
//
// Copyright (c) 2015 oseparovic. ( http://thegameengine.org )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MessageComposerView.h"

@interface MessageComposerView() <UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)sendClicked:(id)sender;
@property(nonatomic, strong) UIView *accessoryView;
@property(nonatomic, strong) UIView *accessoryViewSubView;
@property(nonatomic) CGFloat composerTVMaxHeight;
@end

@implementation MessageComposerView

const NSInteger defaultHeight = 44;
const NSInteger defaultMaxHeight = 100;

- (id)init {
    return [self initWithKeyboardOffset:0 andMaxHeight:defaultMaxHeight];
}

- (id)initWithKeyboardOffset:(NSInteger)offset andMaxHeight:(CGFloat)maxTVHeight {
    CGFloat frameWidth  = [self currentScreenSize].width;
    CGFloat yPos = [self currentScreenSize].height-defaultHeight;
    return [self initWithFrame:CGRectMake(0, yPos, frameWidth, defaultHeight) andKeyboardOffset:offset andMaxHeight:maxTVHeight];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame andKeyboardOffset:0];
}

- (id)initWithFrame:(CGRect)frame andKeyboardOffset:(NSInteger)offset {
    return [self initWithFrame:frame andKeyboardOffset:offset andMaxHeight:defaultMaxHeight];
}

- (id)initWithFrame:(CGRect)frame andKeyboardOffset:(NSInteger)offset andMaxHeight:(CGFloat)maxTVHeight {
    self = [super initWithFrame:frame];
    if (self) {
        // Insets for the entire MessageComposerView. Top inset is used as a minimum value of top padding.
        _composerBackgroundInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        // Insets only for the message UITextView. Default to 0
        _composerTVInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        // Default animation time for 5 <= iOS <= 7. Should be overwritten by first keyboard notification.
        _keyboardAnimationDuration = 0.25;
        _keyboardAnimationCurve = 7;
        _keyboardOffset = offset;
        _composerBackgroundInsets.top = MAX(_composerBackgroundInsets.top, frame.size.height - _composerBackgroundInsets.bottom - 34);
        _composerTVMaxHeight = maxTVHeight;
        
        // Default character cap if one hasn't been set
        if (_characterCap <= 0) {
            _characterCap = 400;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 10)];
//        view.layer.borderWidth = 1;
        view.backgroundColor = [UIColor whiteColor];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 2, 30, 5)];
        [imageView setImage:[UIImage imageNamed:@"Dots2.png"]];
//            imageView.layer.borderWidth = 1;
        imageView.contentMode = UIViewContentModeScaleAspectFill;;
        [view addSubview:imageView];
        [self addSubview:view];
        
        // alloc necessary elements
        self.sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.sendButton addTarget:self action:@selector(sendClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.accessoryView = [[UIView alloc] init];
        
        // fix ridiculous jumpy scrolling bug inherant in native UITextView since 7.0
        // http://stackoverflow.com/a/19339716/740474
        NSString *reqSysVer = @"7.0";
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        BOOL osVersionSupported = ([currSysVer compare:reqSysVer  options:NSNumericSearch] != NSOrderedAscending);
        if (osVersionSupported)  {
            NSTextStorage* textStorage = [[NSTextStorage alloc] init];
            NSLayoutManager* layoutManager = [NSLayoutManager new];
            [textStorage addLayoutManager:layoutManager];
            NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.bounds.size];
            [layoutManager addTextContainer:textContainer];
            self.messageTextView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:textContainer];
        } else {
            self.messageTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        }
        
        self.messageTextView.delegate = self;
        
        // configure elements
        self.messagePlaceholder = TRANSLATE(@"Start typing...");
        [self setup];
        
        // insert elements above MessageComposerView
        [self addSubview:self.sendButton];
        [self addSubview:self.accessoryView];
        [self addSubview:self.messageTextView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Configuration
- (void)setup {
    self.backgroundColor = rgbColor(228, 239, 243); //[UIColor lightGrayColor];
    self.autoresizesSubviews = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = NO;
    
    self.takePhotoButton = [[UIButton alloc] init];
    self.takePhotoButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.takePhotoButton setImage:[UIImage imageNamed:@"attach_photo.png"] forState:UIControlStateNormal];
    [self.takePhotoButton addTarget:self action:@selector(addPhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.takePhotoButton];
    
    [self.takePhotoButton setSelected:YES];
    
    [self.sendButton setAutoresizingMask:(UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin)];
//    [self.sendButton.layer setCornerRadius:5];
//    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [self.sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [self.sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [self.sendButton setBackgroundColor:[UIColor clearColor]];
    [self.sendButton setImage:[UIImage imageNamed:@"send.png"] forState:UIControlStateNormal];
//    [self.sendButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    
    [self.accessoryView setAutoresizingMask:(UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin)];
    
    [self.messageTextView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin)];
    [self.messageTextView setShowsHorizontalScrollIndicator:NO];
    [self.messageTextView.layer setCornerRadius:2];
    [self.messageTextView setFont:[UIFont systemFontOfSize:14]];
    [self.messageTextView setTextColor:[UIColor lightGrayColor]];
    [self.messageTextView setBackgroundColor:rgbColor(228, 239, 243)];
    [self.messageTextView setDelegate:self];
    self.isKeyBoardShow = YES;
    [self setupFrames];
    if (self.isKeyBoardShow) {
        NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [defaultCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
   
}

- (void)setupFrames {
    self.takePhotoButton.frame = CGRectMake(self.width - 90, self.messageTextView.height - 15, 30, 30);
    
    CGRect sendButtonFrame = self.bounds;
    sendButtonFrame.size.width = 60;
    sendButtonFrame.size.height = defaultHeight - _composerBackgroundInsets.top - _composerBackgroundInsets.bottom;
    sendButtonFrame.origin.x = self.frame.size.width - _composerBackgroundInsets.right - sendButtonFrame.size.width;
    sendButtonFrame.origin.y = self.bounds.size.height - _composerBackgroundInsets.bottom - sendButtonFrame.size.height;
    [self.sendButton setFrame:CGRectMake(self.width - 40, self.messageTextView.height, 30, 30)];
    
    CGRect accessoryFrame = self.bounds;
    accessoryFrame.size.width = self.accessoryViewSubView.frame.size.width;
    accessoryFrame.size.height = defaultHeight - _composerBackgroundInsets.top - _composerBackgroundInsets.bottom;
    accessoryFrame.origin.x = _composerBackgroundInsets.left;
    accessoryFrame.origin.y = self.bounds.size.height - _composerBackgroundInsets.bottom - accessoryFrame.size.height;
    [self.accessoryView setFrame:accessoryFrame];
    [self.accessoryViewSubView setCenter:CGPointMake(self.accessoryView.frame.size.width/2, self.accessoryView.frame.size.height/2)];
    
    CGRect messageTextViewFrame = self.bounds;
    messageTextViewFrame.origin.x = _composerTVInsets.left + _composerBackgroundInsets.left;
    if (accessoryFrame.size.width > 0) {
        messageTextViewFrame.origin.x += accessoryFrame.size.width;
    }
    messageTextViewFrame.origin.y = _composerTVInsets.top;
    messageTextViewFrame.size.width = sendButtonFrame.origin.x - _composerTVInsets.right - accessoryFrame.size.width - _composerTVInsets.left - _composerBackgroundInsets.left - 15;
    messageTextViewFrame.size.height = messageTextViewFrame.size.height - _composerBackgroundInsets.top - _composerBackgroundInsets.bottom;
    [self.messageTextView setFrame:messageTextViewFrame];
}

- (void)layoutSubviews {
    // Due to inconsistent handling of rotation when receiving UIDeviceOrientationDidChange notifications
    // ( see http://stackoverflow.com/q/19974246/740474 ) rotation handling and view resizing is done here.
    CGFloat oldHeight = self.messageTextView.frame.size.height;
    CGFloat newHeight = [self sizeWithText:self.messageTextView.text];
    
    if (newHeight >= _composerTVMaxHeight) {
        [self scrollTextViewToBottom];
    }
    if (oldHeight == newHeight) {
        // In cases where the height remains the same after the text change/rotation only change the y origin
        CGRect frame = self.frame;
        frame.origin.y = ([self currentScreenSize].height - [self currentKeyboardHeight]) - frame.size.height - _keyboardOffset;
        self.frame = frame;
        
        // Even though the height didn't change the origin did so notify delegates
        // TODO: remove deprecated method
        if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:)]) {
            [self.delegate messageComposerFrameDidChange:frame withAnimationDuration:_keyboardAnimationDuration];
        }
        if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:andCurve:)]) {
            [self.delegate messageComposerFrameDidChange:frame withAnimationDuration:_keyboardAnimationDuration andCurve:_keyboardAnimationCurve];
        }
    } else {
        // The view is already animating as part of the rotation so we just have to make sure it
        // snaps to the right place and resizes the textView to wrap the text with the new width. Changing
        // to add an additional animation will overload the animation and make it look like someone is
        // shuffling a deck of cards.
        // Recalculate MessageComposerView container frame
        CGRect newContainerFrame = self.frame;
        newContainerFrame.size.height = newHeight + _composerBackgroundInsets.top + _composerBackgroundInsets.bottom + _composerTVInsets.top + _composerTVInsets.bottom;
        newContainerFrame.origin.y = ([self currentScreenSize].height - [self currentKeyboardHeight]) - newContainerFrame.size.height - _keyboardOffset;
        
        // Recalculate send button frame
        CGRect newSendButtonFrame = self.sendButton.frame;
        newSendButtonFrame.origin.y = newContainerFrame.size.height - (_composerBackgroundInsets.bottom + newSendButtonFrame.size.height);
        
        // Recalculate accessory frame
        CGRect newAccessoryFrame = self.accessoryView.frame;
        newAccessoryFrame.origin.y = newContainerFrame.size.height - (_composerBackgroundInsets.bottom + newAccessoryFrame.size.height);
        
        // Recalculate UITextView frame
        CGRect newTextViewFrame = self.messageTextView.frame;
        newTextViewFrame.size.height = newHeight;
        newTextViewFrame.origin.y = _composerBackgroundInsets.top + _composerTVInsets.top;
        
        self.frame = newContainerFrame;
        self.sendButton.frame = newSendButtonFrame;
        self.accessoryView.frame = newAccessoryFrame;
        self.messageTextView.frame = newTextViewFrame;
        [self scrollTextViewToBottom];
        
        // TODO: remove deprecated method
        if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:)]) {
            [self.delegate messageComposerFrameDidChange:newContainerFrame withAnimationDuration:0];
        }
        if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:andCurve:)]) {
            [self.delegate messageComposerFrameDidChange:newContainerFrame withAnimationDuration:0 andCurve:0];
        }
    }
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self layoutSubviews];
    if ([textView.text isEqualToString:self.messagePlaceholder] || [textView.text length] == 0 || [self isStringOnlyWhiteSpace:textView.text]) {
        [self.sendButton setEnabled:NO];
    } else {
        [self.sendButton setEnabled:YES];
        self.messageTextView.textColor = [UIColor blackColor];
    }
    
    if ([self.delegate respondsToSelector:@selector(messageComposerUserTyping)])
        [self.delegate messageComposerUserTyping];
}

- (void)textViewDidBeginEditing:(UITextView*)textView {
    if ([textView.text isEqualToString:self.messagePlaceholder]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        [self.sendButton setEnabled:NO];
    }
    
    CGRect frame = self.frame;
    frame.origin.y = ([self currentScreenSize].height - [self currentKeyboardHeight]) - frame.size.height - _keyboardOffset;
    
    [UIView animateWithDuration:_keyboardAnimationDuration
                          delay:0.0
                        options:(_keyboardAnimationCurve << 16)
                     animations:^{self.frame = frame;}
                     completion:nil];
    
    // TODO: remove deprecated method
    //    if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:)]) {
    //        [self.delegate messageComposerFrameDidChange:frame withAnimationDuration:_keyboardAnimationDuration];
    //    }
    //    if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:andCurve:)]) {
    //        [self.delegate messageComposerFrameDidChange:frame withAnimationDuration:_keyboardAnimationDuration andCurve:_keyboardAnimationCurve];
    //    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return textView.text.length + (text.length - range.length) <= self.characterCap;
}

- (void)textViewDidEndEditing:(UITextView*)textView {
    if ([textView.text isEqualToString:@""] || [textView.text length] == 0 || [self isStringOnlyWhiteSpace:textView.text]) {
        textView.text = self.messagePlaceholder;
        textView.textColor = [UIColor lightGrayColor];
        [self.sendButton setEnabled:NO];
    }
    
    CGRect frame = self.frame;
    frame.origin.y = [self currentScreenSize].height - self.frame.size.height - _keyboardOffset;
    
    [UIView animateWithDuration:_keyboardAnimationDuration
                          delay:0.0
                        options:(_keyboardAnimationCurve << 16)
                     animations:^{self.frame = frame;}
                     completion:nil];
    
    // TODO: remove deprecated method
    //    if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:)]) {
    //        [self.delegate messageComposerFrameDidChange:frame withAnimationDuration:_keyboardAnimationDuration];
    //    }
    //    if ([self.delegate respondsToSelector:@selector(messageComposerFrameDidChange:withAnimationDuration:andCurve:)]) {
    //        [self.delegate messageComposerFrameDidChange:frame withAnimationDuration:_keyboardAnimationDuration andCurve:_keyboardAnimationCurve];
    //    }
}


#pragma mark - Keyboard Notifications
- (void)keyboardWillShow:(NSNotification*)notification {
    // Because keyboard animation time and cure vary by iOS version, and we don't want to build the library
    // on top of spammy keyboard notifications we use UIKeyboardWillShowNotification ONLY to dynamically set our
    // animation duration. As a UIKeyboardWillShowNotification is fired BEFORE textViewDidBeginEditing
    // is triggered we can use the following values for all of animations including the first.
    _keyboardAnimationDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    _keyboardAnimationCurve = [[notification userInfo][UIKeyboardAnimationCurveUserInfoKey] intValue];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect rect = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect converted = [self convertRect:rect fromView:nil];
    self.keyboardHeight = converted.size.height;
    [self setNeedsLayout];
}


#pragma mark - IBAction
- (IBAction)sendClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(messageComposerSendMessageClickedWithMessage:)]) {
        [self.delegate messageComposerSendMessageClickedWithMessage:self.messageTextView.text];
    }
    
    [self.messageTextView setText:@""];
    // Manually trigger the textViewDidChange method as setting the text when the messageTextView is not first responder the
    // UITextViewTextDidChangeNotification notification does not get fired.
    [self textViewDidChange:self.messageTextView];
    
    [self.messageTextView resignFirstResponder];
}


#pragma mark - Utils
- (void)setMessagePlaceholder:(NSString *)messagePlaceholder {
    _messagePlaceholder = messagePlaceholder;
    [self.messageTextView setText:_messagePlaceholder];
    // Manually trigger the textViewDidChange method as setting the text when the messageTextView is not first responder the
    // UITextViewTextDidChangeNotification notification does not get fired.
    [self textViewDidChange:self.messageTextView];
}
- (void)configureWithAccessory:(UIView *)accessoryView {
    // add the accessory view (camera icons etc) to the left of the message text view and rejig the frames to accomodate.
    self.accessoryViewSubView = accessoryView;
    [self.accessoryViewSubView removeFromSuperview];
    [self.accessoryView addSubview:self.accessoryViewSubView];
    [self setupFrames];
}

- (void)scrollTextViewToBottom {
    // scrollRangeToVisible:NSMakeRange is a pretty buggy function. Manually setting the content offset seems to work better
    CGPoint offset = CGPointMake(0, self.messageTextView.contentSize.height - self.messageTextView.frame.size.height);
    [self.messageTextView setContentOffset:offset animated:NO];
}

- (CGFloat)currentKeyboardHeight {
    if ([self.messageTextView isFirstResponder]) {
        return self.keyboardHeight;
    } else {
        return 0;
    }
}

- (CGFloat)sizeWithText:(NSString*)text {
    CGFloat fixedWidth = self.messageTextView.frame.size.width;
    CGSize newSize = [self.messageTextView sizeThatFits:CGSizeMake(fixedWidth, CGFLOAT_MAX)];
    return MIN(_composerTVMaxHeight, newSize.height);
}

- (void)startEditing {
    if ([self.messageTextView isFirstResponder] == NO)
        [self.messageTextView becomeFirstResponder];
    
}

- (void)finishEditing {
    if ([self.messageTextView isFirstResponder])
        [self.messageTextView resignFirstResponder];
}

- (BOOL)isStringOnlyWhiteSpace:(NSString*)text {
    if ([self isStringEmpty:[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isStringEmpty:(NSString*)inputString {
    //http://stackoverflow.com/a/3675518/740474
    //isEmpty will return true if the string equates to @"" or nil. Has to be static as
    //calling a method on a nil NSString will not execute the method.
    return (inputString == nil)
    || [inputString isKindOfClass:[NSNull class]]
    || ([inputString respondsToSelector:@selector(length)]
        && [(NSData *)inputString length] == 0)
    || ([inputString respondsToSelector:@selector(count)]
        && [(NSArray *)inputString count] == 0);
}


#pragma mark - Screen Size Computation
- (CGSize)currentScreenSize {
    // return the screen size with respect to the orientation
//    return ((UIView*)self.nextResponder).frame.size;
    
    // there are a few problems with this implementation. Namely nav bar height
    // especially was unreliable. For example when UIAlertView height was present
    // we couldn't properly determine the nav bar height. The above method appears to be
    // working more consistently. If it doesn't work for you try this method below instead.
     return [self currentScreenSizeInInterfaceOrientation:[self currentInterfaceOrientation]];
}

- (CGSize)currentScreenSizeInInterfaceOrientation:(UIInterfaceOrientation)orientation {
    // http://stackoverflow.com/a/7905540/740474
    
    // get the size of the application frame (screensize - status bar height)
    CGSize size = [UIScreen mainScreen].applicationFrame.size;
    
    // if the orientation at this point is landscape but it hasn't fully rotated yet use landscape size instead.
    // handling differs between iOS 7 && 8 so need to check if size is properly configured or not. On
    // iOS 7 height will still be greater than width in landscape without this call but on iOS 8
    // it won't
    if (UIInterfaceOrientationIsLandscape(orientation) && size.height > size.width) {
        size = CGSizeMake(size.height, size.width);
    }
    
    // subtract the height of the navigation bar from the screen height
    size.height -= [self currentNavigationBarHeight];
    
    return size;
}

- (UIInterfaceOrientation)currentInterfaceOrientation {
    // Returns the orientation of the Interface NOT the Device. The two do not happen in exact unison so
    // this point is important.
    return [UIApplication sharedApplication].statusBarOrientation;
}

- (CGFloat)currentNavigationBarHeight {
    // TODO this will fail to get the correct height when a UIAlertView is present
    id nav = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navc = (UINavigationController *) nav;
        if(navc.navigationBarHidden) {
            return 0;
        } else {
            return navc.navigationBar.frame.size.height;
        }
    }
    return 0;
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
//    self.profileImageView.image = image ? image : [UIImage imageNamed:@"add_photo_teacher.png"];
}

//- (void)uploadAndSetProfileImage:(UIImage *)image {
//    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicatorView.left = 0.5 * (self.profileImageView.width - indicatorView.width);
//    indicatorView.top = 0.5 * (self.profileImageView.height - indicatorView.height);
//    indicatorView.color = [UIColor blackColor];
//    indicatorView.tag = 2;
//    [indicatorView startAnimating];
//    [self.profileImageView addSubview:indicatorView];
//    NSData *imageData = UIImageJPEGRepresentation(image, 1);
//    [[RestClient sharedClient] uploadImageByPath:METHOD_POST_UPLOAD_PATIENT_PHOTO withData:imageData callback:^(NSDictionary *responseDic, NSError *error) {
//        [[self.profileImageView viewWithTag:2] removeFromSuperview];
//        if (!error) {
//            self.photo = [[Photo alloc] initWithDictionary:responseDic[@"data"] error:nil];
//            [self.profileImageView setImageWithURL:self.photo.url placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]
//                       usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        }
//    }];
//}

//- (void)populateWithPatientSignature:(PatientSignatureFormForShow *)patientSignatureFormForShow {
//    [super populateWithPatientSignature:patientSignatureFormForShow];
//    //    [self.profileImageView sd_setImageWithURL:self.patientDetails.photo.url placeholderImage:[UIImage imageNamed:@"add_photo_teacher.png"]];
//    //    self.photo = self.patientDetails.photo;
//}


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
        if ([self.delegate respondsToSelector:@selector(messageComposerSendPhotoClickedWithPhoto:)]) {
            [self.delegate messageComposerSendPhotoClickedWithPhoto:image];
        }
//        [self.takePhotoButton setImage:image];
        //        [self uploadAndSetProfileImage:image];
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
//    [super populatePatientDetails];
    //    self.patientDetails.photo = self.photo;
}

//- (BOOL)validateAndPopulatePatientDetails {
//    if ([super validateAndPopulatePatientDetails]) {
//        return YES;
//    }
//    if (self.photo == nil) {
//        [self.scrollView setContentOffset:CGPointMake(0, self.top) animated:YES];
//        ALERT(@"Please, upload your photo.");
//        return YES;
//    }
//    //    self.patientDetails.photo = self.photo;
//    return NO;
//}

@end