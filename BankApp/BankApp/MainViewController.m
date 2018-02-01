//
//  MainViewController.m
//  BankApp
//
//  Created by Apple on 07/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "WebService.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize webService;
- (void)viewDidLoad {
    [super viewDidLoad];
    webService = [[WebService alloc]init];
    [webService setWebDelegate:self];
    self.navigationItem.hidesBackButton = YES;    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
     //ViewController *vc=[[ViewController alloc] init];
   NSString *accnumber=@"112233445566";
    NSDictionary *acc = @{@"account_number":accnumber};
    [webService callWebServiceURL:@"http://10.251.163.5:8088/MFRPServices/bank_account_summary"
                      withPayLoad:acc withType:@"AccountSummary"];

     // or self.navigationItem.rightBarButtonItem
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getResponseFromWeb:(NSDictionary *)result by:(NSString *)type{
    
    NSLog(@"%@",result);
    
    if([type isEqualToString:@"AccountSummary"])
    {
        NSLog(@"%@",result);
        self.accountNo.text=[[result objectForKey:@"results"] objectForKey:@"account_number"];
        self.name.text=[[result objectForKey:@"results"] objectForKey:@"customer_name"];
        self.accountType.text=[[result objectForKey:@"results"] objectForKey:@"account_type"];
        self.balance.text=[[result objectForKey:@"results"] objectForKey:@"balance"];
            
        }else{
            //Login Failed
            UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Login Failed!!" message:@"Username /Password Wrong" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            
            [uiAlertCtrl addAction:okAction];
            
            [self presentViewController:uiAlertCtrl animated:YES completion:nil];
            
        }
        
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
