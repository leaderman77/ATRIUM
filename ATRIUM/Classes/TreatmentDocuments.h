//
//  TreatmentDocuments.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 4/21/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@protocol BaseNeedSignForm;

@interface TreatmentDocuments : BaseObject
/*private SelectItem treatmentCode;
 private List<BaseNeedSignFormTO> documents = new ArrayList<>();*/
@property (nonatomic, strong) SelectItem *treatmentCode;
@property (nonatomic, strong) NSMutableArray<BaseNeedSignForm>* documents;

@end
