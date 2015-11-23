//
//  PatientSearchPopupView.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 6/25/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientSearchPopupView : UIView

@property (nonatomic, copy) void (^patientSearchCompleted)(id item, BOOL completed);
- (void)showInWindow;

@end
