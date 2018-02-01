//
//  SubmitViewController.h
//  BankApp
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *accNo;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBar;
@property (weak, nonatomic) IBOutlet UITextField *type;
@property (weak, nonatomic) IBOutlet UITextField *chequeLc;
-(IBAction)submitBtnPressed:(id)sender;
- (IBAction)SegmentedButton:(UISegmentedControl *)sender;
@end
