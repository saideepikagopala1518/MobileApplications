//
//  LoginViewController.m
//  JobApplicationForm
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize UsernameField,PasswordField,loader;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [loader stopAnimating];
   
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginButtonPressed:(id)sender{
    
    if([self.UsernameField.text isEqualToString:@""] || [self.PasswordField.text isEqualToString:@""])
    {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Failure" message:@"Enter  username and password" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else{
        
        NSDictionary *dict=@{@"user_id":self.UsernameField.text,@"password":self.PasswordField.text};
        NSError *errobj;
        [loader startAnimating];
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&errobj];
        NSURL *url=[NSURL URLWithString:@"http://10.251.163.5:8088/MFRPServices/login"];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        
        
        NSURLSessionDataTask *Logindata=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary  *Data =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            
            NSLog(@"%@",Data);
            
            if(!error)
            {
                if([[Data objectForKey:@"status"]isEqualToString:@"Success"])
                {
                    [loader stopAnimating];
                    NSLog(@"Successfully Login");
                  
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self performSegueWithIdentifier:@"loginsuccesssegue" sender:self];
                    });
                }
                else
                {
                    [loader stopAnimating];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Incorrect credentials" message:@"Enter a valid username and password" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            //
                        }];
                        [controller addAction:okAction];
                        [self presentViewController:controller animated:YES completion:nil];
                        
                    });
                }
            }
            
            else
            {
                [loader stopAnimating];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    NSLog(@"Cannot connect to the internet");
                    
                    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Network Error" message:@"Cannot connect to the internet" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //
                    }];
                    [controller addAction:okAction];
                    [self presentViewController:controller animated:YES completion:nil];
                });
            }
            
            
        }];
        
        [Logindata resume];
    }
    }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}*/


@end
