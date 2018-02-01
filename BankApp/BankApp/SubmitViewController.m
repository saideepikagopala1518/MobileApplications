//
//  SubmitViewController.m
//  BankApp
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//
#import "SubmitViewController.h"
#import "SubmitService.h"
#import "HistoryViewController.h"
#import "HistoryService.h"
#import "SWRevealViewController.h"

@interface SubmitViewController ()
{
    
    NSString *MyString;
    NSInteger flag;
    
    NSMutableArray *LeafCnt;
    NSMutableArray *Reqdate;
    
    NSString *AccNumber;
    
    NSString *Message;
    
}


@end

@implementation SubmitViewController
- (IBAction)SegmentedButton:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            [self viewDidLoad];
            break;
            
        case 1:
            
            
            
            [self didChangeValueForKey:@"leafcnt"];
            
            
            [self performSegueWithIdentifier:@"HistorySegue" sender:self];
            sender.selectedSegmentIndex=0;
            
            break;
    }
    
}



- (IBAction)submitBtnPressed:(id)sender
{
    
    if([self.accNo.text isEqualToString:@""])
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Account Number cannot be empty " preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];
    }
    else if([self.type.text isEqualToString:@""])
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Type cannot be empty" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];
    }
    else if([self.chequeLc.text isEqualToString:@""] && (self.chequeLc.text.length <4))
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Cheque Leaf field cannot be empty" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];
    }
    else{
        if([self.accNo.text isEqualToString:@"112233445566"])
        {
    HistoryService *MyCallH=[[HistoryService alloc] init];
    [MyCallH AccountNumber:self.accNo.text];
    
    SubmitService *MyCall=[[SubmitService alloc] init];
    [MyCall AccountNumber:self.accNo.text LeafCount:self.chequeLc.text Date:self.date.text];
    }
    
    else
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Invalid Account Number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];

    }
}
}

-(void)ShowMessage:(NSNotification *)TheNotificationMessage
{
    Message=[TheNotificationMessage.userInfo objectForKey:@"msg"];
    
    UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:Message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Return" style:UIAlertActionStyleCancel handler:nil];
    
    [uiAlertCtrl addAction:okAction];
    
    [self presentViewController:uiAlertCtrl animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LeafCnt=[[NSMutableArray alloc] init];
    Reqdate=[[NSMutableArray alloc] init];
    
    
    
    self.navigationItem.hidesBackButton = YES;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuBar setTarget: self.revealViewController];
        [self.menuBar setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    flag=0;
    //self.submitBtn.enabled=NO;
    NSDate *now=[NSDate date];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    MyString=[DateFormatter stringFromDate:now];
    
    self.date.text=MyString;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowMessage:) name:@"msg" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceivedData:) name:@"Historydetails" object:nil];
    
}

-(void)ReceivedData:(NSNotification *)TheNotification
{
    LeafCnt=[TheNotification.userInfo objectForKey:@"leafcnt"];
    Reqdate=[TheNotification.userInfo objectForKey:@"reqdate"];
    AccNumber=[TheNotification.userInfo objectForKey:@"acnumber"];
    
    NSLog(@"Leaf Count %@",LeafCnt);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HistoryViewController *MyVc=(HistoryViewController *)segue.destinationViewController;
    MyVc.LeafCountArray=LeafCnt;
    MyVc.ReqDateArray=Reqdate;
    MyVc.AccNumber=AccNumber;
    [MyVc.TableView reloadData] ;
    HistoryService *MyCallH=[[HistoryService alloc] init];
    [MyCallH AccountNumber:@"112233445566"];
    
}

@end
