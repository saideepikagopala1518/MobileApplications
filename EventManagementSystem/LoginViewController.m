//
//  LoginViewController.m
//  EventVer2
//
//  Created by apple on 09/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterEventViewController.h"

@interface LoginViewController ()
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.username.delegate=self;
    self.password.delegate=self;
}

- (IBAction)loginButton:(id)sender {
    if([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""])
    {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Insufficient Data" message:@"Enter  UserID and Password" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        NSDictionary *dict=@{@"user_id":self.username.text,@"password":self.password.text};
        NSError *errobj;
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
                    NSLog(@"Successfully Logged In");
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self performSegueWithIdentifier:@"ToSecond" sender:nil];
                    });
                }
                else
                {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Incorrect Credentials" message:@"Enter a valid username and password" preferredStyle:UIAlertControllerStyleAlert];
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
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Network Error" message:@"Cannot connect to the internet" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [controller addAction:okAction];
                    [self presentViewController:controller animated:YES completion:nil];
                });
            }
            
            
        }];
        
        [Logindata resume];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag==111)
    {
        [self.password becomeFirstResponder];
    }
    else if(textField.tag==222)
    {
        
        [textField resignFirstResponder];
    }
    
    return  YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
