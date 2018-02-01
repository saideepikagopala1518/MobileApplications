//
//  LoginViewController.h
//  JobApplicationForm
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *UsernameField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordField;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;

-(IBAction)loginButtonPressed:(id)sender;
@end
