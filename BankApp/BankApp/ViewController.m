//
//  ViewController.m
//  BankApp
//
//  Created by Apple on 07/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Username,Password,webService;
- (void)viewDidLoad {
    [super viewDidLoad];
    webService = [[WebService alloc]init];
    [webService setWebDelegate:self];
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)loginButtonPressed:(id)sender
{
    if([Username.text isEqualToString:@""] || [Password.text isEqualToString:@""])
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Username or Password cannot be empty" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];

    }
    else
    {
    NSDictionary *d = @{@"customer_id":Username.text ,@"password":Password.text};
    [webService callWebServiceURL:@"http://10.251.163.5:8088/MFRPServices/bank_login"
 withPayLoad:d withType:@"Login"];
    
    }
}
-(void)getResponseFromWeb:(NSDictionary *)result by:(NSString *)type{
    
    NSLog(@"%@",result);
    
    
        if([type isEqualToString:@"Login"])
        {
        if ([[result objectForKey:@"status"] isEqualToString:@"Success"]){
            //Login success
            
            [self performSegueWithIdentifier:@"loginsuccesssegue" sender:self];
            
        }
        else{
            
            UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Login Failed!!" message:@"Username / Password Wrong" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            
            [uiAlertCtrl addAction:okAction];
            
            [self presentViewController:uiAlertCtrl animated:YES completion:nil];
            
        }
        
    }
}

@end
