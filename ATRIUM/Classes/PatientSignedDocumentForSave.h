//
//  PatientSignedDocumentForSave.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/22/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseNeedSignForm.h"

@interface PatientSignedDocumentForSave : BaseNeedSignForm


/*private SelectItem dentist;
 private SelectItem nurse;
 private SelectItem hygienist;
 private SelectItem guardian;
 private boolean hasDentistSignatureField=false;
 private boolean hasNurseSignatureField=false;
 private boolean hasHygienistSignatureField=false;
 private boolean hasGuardianSignatureField=false;
 */

@property (nonatomic, strong) SelectItem *dentist;
@property (nonatomic, strong) SelectItem *nurse;
@property (nonatomic, strong) SelectItem *hygienist;
@property (nonatomic, strong) SelectItem *guardian;
@property (nonatomic, assign) BOOL hasDentistSignatureField;
@property (nonatomic, assign) BOOL hasNurseSignatureField;
@property (nonatomic, assign) BOOL hasHygienistSignatureField; 
@property (nonatomic, assign) BOOL hasGuardianSignatureField;

@end
