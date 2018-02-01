//
//  MainViewController.h
//  JobApplicationForm
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <QuickLook/QuickLook.h>

@interface MainViewController : UIViewController<MFMailComposeViewControllerDelegate, UIActionSheetDelegate, QLPreviewControllerDataSource>
{
    CGPoint lastPoint;
    CGPoint moveBackTo;
    CGPoint currentPoint;
    CGPoint location;
    NSDate *lastClick;
    BOOL mouseSwiped;
    UIImageView *drawImage;
    
}

@property (strong, nonatomic) IBOutlet UIButton *generatePDFButton;

@property(nonatomic,strong)NSMutableArray *textFieldArray;
- (IBAction)signatureButtonPressed:(UIButton *)sender;
- (IBAction)pdfButtonPressed:(UIButton *)sender;
- (IBAction)doneButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateOfBirth;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *zipCode;
@property (strong, nonatomic) IBOutlet UITextField *telephoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *jobApplyingFor;
@property (strong, nonatomic) IBOutlet UITextField *totalExperience;
@property (strong, nonatomic) IBOutlet UITextField *whatWillYouDoIfHired;
@property (strong, nonatomic) IBOutlet UIView *signatureView;
@property (strong, nonatomic) IBOutlet UIButton *generatePdfOutlet;

@property (strong, nonatomic) IBOutlet UIButton *declarationButtonOutlet;
- (IBAction)declarationButtonPressed:(UIButton *)sender;
- (IBAction)resetButtonPressed:(UIButton *)sender;



@end
