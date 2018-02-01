//
//  ViewController.h
//  BankApp
//
//  Created by Apple on 07/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
@interface ViewController : UIViewController<WebServiceDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property(nonatomic,retain)WebService *webService;
-(IBAction)loginButtonPressed:(id)sender;

@end

