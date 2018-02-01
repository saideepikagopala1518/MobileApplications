//
//  TransferMoneyViewController.h
//  BankApp
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"

@interface TransferMoneyViewController : UIViewController<UITextFieldDelegate,WebServiceDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *benAccount;
@property (weak, nonatomic) IBOutlet UITextField *transPassword;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *accNumber;
@property (weak, nonatomic) IBOutlet UITextField *amount;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;
@property(nonatomic,retain)IBOutlet UIButton *submitButton;
@property(nonatomic,retain)NSMutableArray *payeeAccounts;
@property(nonatomic,retain)WebService *webService;
@property(nonatomic,retain)UIPickerView *myPickerView;


-(IBAction)submitButtonPressed:(id)sender;
@end
