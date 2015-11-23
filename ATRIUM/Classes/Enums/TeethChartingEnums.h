//
//  ToothChartingEnums.h
//  Dental-iPad
//
//  Created by Sanch0 on 2/5/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#ifndef Dental_iPad_ToothChartingEnums____FILEEXTENSION___
#define Dental_iPad_ToothChartingEnums____FILEEXTENSION___


typedef enum {
    kMonitorActiveStatus = 1,
    kMonitorStoppedStatus = 2,
} TransactionMonitorStatusType;

typedef enum {
    kPlannedDentalTransactionStatus = 1,
    kCancelledDentalTransactionStatus = 2,
    kCompletedDentalTransactionStatus = 3
} DentalTransactionStatusType;

typedef enum {
    DiagnosisTransactionType = 1,
    TreatmentTransactionType,
    ExistingTransactionType,
    ProductsTransactionType,
    DiagnosisCompletedTransactionType,
    TreatmentCompletedTransactionType
} TransactionType;


typedef enum {
    kTreatmentAreaTypeNone,
    kSurfaceTreatmentAreaType = 1,
    kToothTreatmentAreaType,
    kRootTreatmentAreaType,
    kMouthTreatmentAreaType,
    kQuadrantTreatmentAreaType,
    kSextantTreatmentAreaType
} TreatmentAreaType;

typedef NS_ENUM(NSInteger, GenerationType) {
    ChildGenerationType = 1,
    AdultGenerationType,
    SupernumeraryType
};

typedef enum {
    FacialSurfaceType = 1,
    MesialSurfaceType,
    LingualSurfaceType,
    DistalSurfaceType,
    OclusalSurfaceType,
    IncisalSurfaceType,
    BuccalSurfaceType,
    FacialFiveSurfaceType,
    LingualFiveSurfaceType,
    BuccalFiveSurfaceType,
    

} SurfaceType;

typedef enum {
    kUpperMouthType = 1,
    kLowerMouthType
} MouthType;


typedef enum {
    kUpperRightQuadrantType = 1,
    kUpperLeftQuadrantType,
    kLowerRightQuadrantType,
    kLowerLeftQuadrantType
} QuadrantType;

typedef enum {
    kSextant1 = 1,
    kSextant2,
    kSextant3,
    kSextant4,
    kSextant5,
    kSextant6
} SextantType;

typedef enum {
    kBicuspidToothType = 1,
    kCuspidToothType,
    kLateralToothType,
    kCentralToothType,
    kMolarToothType
} ToothType;


typedef enum {
    kPatientProfileDashboardBtn = 1,
    kPatientMonitorDashboardBtn,
    kPatientAlertDashboardBtn,
    kPatientAppontmentCalendarDashboardBtn,
    kPatientClicnicalNotesDashboardBtn,
    kPatientTimeDashboardBtn,
} kTeethChartingControllerBtnType;

typedef enum {
    kMonitorToothView = 1,
    kEditMonitorToothView,
    kTreatmentTransactionDetailsView,
    kExistingTreatmentTransactionDetailsView,
    kProductTreatmentTransactionDetailsView,
    kDiagnosisTransactionDetailsView,
    kClinicalNotesView,
    kClinicalNoteCategorysView,
    kClinicalNoteTemplatesView,
    kAddDentistNewNoteView,
    kCreateClinicalNoteView,
    kDiagnosisAddView,
    kDetailClinicNoteView,
    kPrescriptionListView,
    kPrescriptionTemplateCategoryView,
    kTreatmentAddView,
    kLabOrderRightView,
    kPostOpInstructionView,
    kConsentFormListRightView,
    kLabOrderTempalatesView,
    kFollowUpView,
    kBreakToVisitViewType,
    kPopupTreatmentnIstructionInfo,
    kTreatmentsPlanListView,
    kPatientPerioExamHistoryView,
    kProductAddView,
    kProductDetailView,
    kProcedureListView,
} kTeethChartingRightViewType;

//ACTIONS TYPE
typedef enum {
    CloseAllRightViewsAction = -1,
    NoneAction,
    DentalTransactionDidSaved,
    DentalTransactionDidCreated,
    DentalProductTransactionDidCreated,
    DentalProductTransactionDidDeleted,
    DentalProductTransactionDidUpdated,
    TreatmentAddViewShouldShowInsuranceRequestsView,
    DentalTransactionDidRemoved,
    TreatmentAddViewDidSavedTransaction,
    ClinicalNoteTemplatesViewWillCreateNote,
    ClinicalNoteCategorysViewWillCreateNote,
    ClinicalNoteCategorysViewWillSelectTempate,
    ClinicalNotesViewShouldOPenNoteDetail,
    ClinicalNotesViewShouldOPenCategoryView,
    DetailClinicNoteViewShouldOpenAddDentistNewNoteView,
    DetailClinicNoteViewShouldOpenCreateClinicNoteView,
    CreateClinicNoteViewShouldOpenClinicalNotesView,
    AddDentistNewNoteViewShouldOpenClinicalNotesView,
    PrescriptionAddControllerShouldOpen,
    PrescriptionAddControllerShouldOpenWithTemplate,
    PrescriptionAddControllerDidBackClicked,
    PrescriptionAddControllerDidSaveClicked,
    PrescriptionListViewShouldOpenPrescriptionPdfUrlAction,
    CompleteVisitViewDidCompleteTransactionsAction,
    LabOrderRightViewShouldOpenLabOrderPdfUrlAction,
    LabOrderTemplatesViewShouldOpenCreateNewLabOrder,
    PostOpInstructionShouldOpenLabOrderPdfUrlAction,
    PopupTreatmentnIstructionInfoShouldOpenNeedSignConsentForm,
    ConsentFormListRightViewShouldOpenNeedSignConsentForm,
    PopupTreatmentnIstructionInfoShouldOpenLabOrderController,
    PreapprovalTreatmentDidSendAction,
    TreatmentsPlanListViewShouldOpenPDFUrlAction,
    PeriodontalToothDetailsViewNextPrevAction,
    PeriodontalToothDetailsViewChangeToothitem,
    PatientPerioExamHistoryViewShouldOpenPatientPerioExamChartingView,
    BottomTransactionsViewShouldOpenAddProductView,
    FavoriteViewDidSelectItem,
    FavoriteViewDidLongPressItem,
    ProcedureListViewTreatmentsCreated,
} ChartingActionType;


#define kToothFrontSide         @"Front_Side"
#define kToothBackSide          @"Back_Side"

//clincical notes template question type codes
#define  LIST_OF_ANSWERS                        @"LIST_OF_ANSWERS"// single choise
#define  FREE_FORM_ENTRY                        @"FREE_FORM_ENTRY"
#define  DATE_SELECTOR                          @"DATE_SELECTOR"
#define  TEETH_SELECTION                        @"TEETH_SELECTION"
#define  SURFACE_SELECTION                      @"SURFACE_SELECTION"
#define  LIST_OF_ANSWERS_MULTIPLE_CHOICE        @"LIST_OF_ANSWERS_MULTIPLE_CHOICE"



#endif
