//
//  AnnouncementDetailsController.m
//  ATRIUM
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "AnnouncementDetailsController.h"

@interface AnnouncementDetailsController ()<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, retain) UITextView *detailsTextView;

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *chatLabel;

@property (nonatomic, retain) UIButton *chatButton;
@property (nonatomic, strong) UIButton *approveButton;

@property (nonatomic, retain) UILabel *detailsLabel;
@property (nonatomic, retain) UITextField *titleTextFiled;

@end

@implementation AnnouncementDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureControls];
    [self configureNavigationBar];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.backgroundColor = rgbColor(22, 168, 235);
//    self.navigationController.navigationBar.barTintColor = rgbColor(22, 168, 235);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureNavigationBar {
    //    [super configureNavigationBar2];
        
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    self.topView.backgroundColor = rgbColor(255, 255, 255);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 25, 200, 30)];
    titleButton.text = [TRANSLATE(self.isSearch ? self.announceCreateBy : @"My Announcements") uppercaseString];
    titleButton.titleColor = rgbColor(22, 168, 235);
    titleButton.titleLabel.font = FONT_SANSUMI_BOLD(14);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    self.approveButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 25, 30, 30)];
    UIImageView *approveImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.approveButton.width, self.approveButton.height)];
    [approveImageView setImage:self.isViewMode ? [UIImage imageNamed:@"navig_bar_edit.png"] : [UIImage imageNamed:@"navig_bar_save_changes.png"]];
    approveImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.approveButton addSubview:approveImageView];
    if (_isViewMode) {
        [self.approveButton addTarget:self action:@selector(isEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.approveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.isSearch ? nil : [self.topView addSubview:self.approveButton];
    
    [self.view addSubview:self.topView];
}
- (void)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)isEditButtonClicked:(id)sender {
    if (_isViewMode) {
        self.isViewMode = NO;
//        self.studentProfileInfoView.isViewMode = NO;
        [self configureNavigationBar];
        [self configureControls];
    } else {
        self.isViewMode = YES;
        [self configureNavigationBar];
        [self.approveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self configureControls];
    }
}
- (void)configureControls {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
//        self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 50;
    //    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(255, 255, 255);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, - 20, self.view.bounds.size.width, 160)];
//    self.profileImageView.layer.borderWidth = 1;
    //    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.backgroundColor = [UIColor blueColor];
    [self.profileImageView sd_setImageWithURL:self.photoUrl placeholderImage:[UIImage imageNamed:@"addimage.png"]];
    [self.scrollView addSubview:self.profileImageView];
    
    self.chatButton = [[UIButton alloc] initWithFrame:CGRectMake(160, self.profileImageView.height - 5, 50, 30)];
    UIImageView *chatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.chatButton.width, self.chatButton.height)];
    [chatImageView setImage:[UIImage imageNamed:@"chat_with_the_author.png"]];
    chatImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.chatButton addSubview:chatImageView];
    [self.chatButton addTarget:self action:@selector(chatWithAuthorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.isSearch ? [self.scrollView addSubview:self.chatButton] : nil;
    
    self.chatLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, self.profileImageView.height - 10, 80, 35)];
//    self.chatLabel.layer.borderWidth = 1;
    self.chatLabel.layer.cornerRadius = 0.5;
    self.chatLabel.layer.masksToBounds = YES;
    self.chatLabel.numberOfLines = 0.f;
    self.chatLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.chatLabel.textAlignment = NSTextAlignmentCenter;
    self.chatLabel.backgroundColor = [UIColor clearColor];
    NSString *followersString = [TRANSLATE(@"Chat With") uppercaseString];
    NSMutableAttributedString *followersNum = [[NSMutableAttributedString alloc]
                                               initWithAttributedString:[NSAttributedString attributedStringWithTitle:followersString withTextColor:rgbColor(37, 66, 97) withBoldFontSize:12]];
    NSString *followersTring2 = [TRANSLATE(@"\nThe Author") uppercaseString];
    NSMutableAttributedString *followersText = [[NSMutableAttributedString alloc]
                                                initWithAttributedString:[NSAttributedString attributedStringWithTitle:followersTring2 withTextColor:rgbColor(37, 66, 97) withFontSize:12]];
    [followersNum appendAttributedString:followersText];
    self.chatLabel.attributedText = followersNum;
    self.isSearch ? [self.scrollView addSubview:self.chatLabel] : nil;
    
    self.chatLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, self.profileImageView.height - 10, 80, 35)];
    //    self.chatLabel.layer.borderWidth = 1;
    self.chatLabel.layer.cornerRadius = 0.5;
    self.chatLabel.layer.masksToBounds = YES;
    self.chatLabel.numberOfLines = 0.f;
    self.chatLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.chatLabel.textAlignment = NSTextAlignmentCenter;
    self.chatLabel.backgroundColor = [UIColor clearColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.profileImageView.height + 30, 300, 15)];
    //    self.chatLabel.layer.borderWidth = 1;
    self.titleLabel.layer.cornerRadius = 0.5;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.text = [TRANSLATE(@"Announcement Name") uppercaseString];
    self.titleLabel.textColor = rgbColor(73, 108, 148);
    self.titleLabel.font = FONT_SANSUMI_BOLD(10.f);
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.titleLabel];
    
    self.titleTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(15, self.profileImageView.height + 45, 290, 30)];
//            self.titleTextFiled.layer.borderWidth = 2;
    self.titleTextFiled.backgroundColor = rgbColor(237, 244, 250);
    self.titleTextFiled.text = self.announceTitle;
    self.titleTextFiled.delegate = self;
    self.titleTextFiled.layer.cornerRadius = 5.f;
    self.titleTextFiled.layer.masksToBounds = YES;
//    self.titleTextFiled.editable = !self.isViewMode;
    self.titleTextFiled.textColor = rgbColor(37, 66, 97);
    self.titleTextFiled.font = FONT_SANSUMI_BOLD(15);
    [self.scrollView addSubview:self.titleTextFiled];
    
    self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.profileImageView.height + 80, 300, 15)];
    //    self.chatLabel.layer.borderWidth = 1;
    self.detailsLabel.layer.cornerRadius = 0.5;
    self.detailsLabel.layer.masksToBounds = YES;
    self.detailsLabel.text = [TRANSLATE(@"Announcement Description") uppercaseString];
    self.detailsLabel.textColor = rgbColor(73, 108, 148);
    self.detailsLabel.font = FONT_SANSUMI_BOLD(10.f);
    self.detailsLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.detailsLabel];
    
    self.detailsTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, self.profileImageView.height + 95, 290, 140)];
//        self.detailsTextView.layer.borderWidth = 2;
    self.detailsTextView.backgroundColor = rgbColor(237, 244, 250);;
    self.detailsTextView.text = self.myAnnounceText;
    self.detailsTextView.delegate = self;
    self.detailsTextView.editable = !self.isViewMode;
    self.detailsTextView.textColor = rgbColor(37, 66, 97);
    self.detailsTextView.scrollEnabled = YES;
    self.detailsTextView.layer.cornerRadius = 5.f;
    self.detailsTextView.layer.masksToBounds = YES;
    self.detailsTextView.font = FONT_SANSUMI_BOLD(15);
    [self.scrollView addSubview:self.detailsTextView];
    
    self.scrollView.contentSize = CGSizeMake(0, 650);
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)chatWithAuthorButtonClicked:(id)sender {
    
}
- (IBAction)saveButtonClicked:(id)sender {
    DLog(@"Save btn clicked");
    //todo add signature validating before submit!!
    NSUserDefaults *userdefaults2 = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userdefaults2 objectForKey:@"userID"];
    
    NSDictionary *param = @{@"Ad[title]" : self.announceTitle,
                            @"Ad[text]" : self.detailsTextView.text,
                            @"Ad[photo]" : self.photoUrl,
                            @"Ad[id]" : self.announceID,
                            @"Ad[user]" : userId};
    
    [[RestClient sharedFormClient] callMethodByPath:METHOD_UPDATE_ANNOUNCEMENT withHTTPMethodType:HTTP_POST withParameters:param
                                           callback:^(NSDictionary *responseDic, NSError *error) {
                                               [self.view showLoading:NO];
                                               if (!error) {
                                                   DLog(@"success 1 fields");
                                                   NSArray *array = [responseDic valueForKey:@"data"];
                                                   if (array.count != 0) {
                                                       self.announceTitle = [[[responseDic valueForKey:@"data"] valueForKey:@"title"] objectAtIndex:0];
                                                       self.myAnnounceText = [[[responseDic valueForKey:@"data"] valueForKey:@"text"] objectAtIndex:0];
                                                       self.photoUrl = [[[responseDic valueForKey:@"data"] valueForKey:@"photo"] objectAtIndex:0];
                                                       self.isViewMode = YES;
                                                       [self configureNavigationBar];
                                                       [self configureControls];
                                                       if ([self.delegate respondsToSelector:@selector(callAppMethodOfAnnounceByDetails)]) {
                                                           [self.delegate callAppMethodOfAnnounceByDetails];
                                                       }
                                                   } else {
                                                       
                                                   }
                                                   
                                               } else {
                                                   [[RestClient sharedClient] showErrorMessage:responseDic];
                                                   //                                                   ALERT(@"Error with saving profile.");
                                               }
                                           }];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.titleTextFiled) {
        [self.scrollView setContentOffset:CGPointMake(0, self.titleTextFiled.center.y-130) animated:YES];
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.titleTextFiled isEqual:textField]) {
        [self.titleTextFiled resignFirstResponder];
    }
    [self.scrollView setContentOffset:CGPointMake(0, self.detailsTextView.center.y - 330) animated:YES];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.detailsTextView isEqual:textView]) {
        [self.scrollView setContentOffset:CGPointMake(0, self.detailsTextView.center.y-160) animated:YES];
    }
    if ([self.detailsTextView isEqual:textView]) {
        textView.returnKeyType = UIReturnKeyDone;
    }
    return YES;
}
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, self.detailsTextView.center.y-300) animated:YES];
        return NO;
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, self.detailsTextView.center.y-160) animated:YES];
        return YES;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
