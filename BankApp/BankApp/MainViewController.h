//
//  MainViewController.h
//  BankApp
//
//  Created by Apple on 07/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEbService.h"

@interface MainViewController : UIViewController<WebServiceDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property (weak, nonatomic) IBOutlet UITextField *accountNo;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *accountType;
@property (weak, nonatomic) IBOutlet UITextField *balance;
@property(nonatomic,retain)WebService *webService;

//-(void)GetAccountSummary:(NSString *)accnumber;
@end
