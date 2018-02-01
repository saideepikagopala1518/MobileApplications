//
//  MiniTableViewController.m
//  BankApp
//
//  Created by Apple on 09/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "MiniTableViewController.h"
#import "DetailedViewController.h"
#import "SWRevealViewController.h"
#import "MiniService.h"
@interface MiniTableViewController ()
{
    
    NSMutableArray *Date;
    NSMutableArray *Amount;
    NSMutableArray *Type;
    
    
    NSMutableArray *Date1;
    NSMutableArray *Amount1;
    NSMutableArray *Type1;
}
@end

@implementation MiniTableViewController
@synthesize SegmentedButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menu setTarget: self.revealViewController];
        [self.menu setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
    [[self tableView] reloadData];
    MiniService *ms=[[MiniService alloc]init];
    NSString *acc=@"112233445566";
    NSString *type=@"savings" ;
    [ms AccountNumber:acc Type:type];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceivedData:) name:@"MiniStatementDetail" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceivedDetailData:) name:@"DetailStatementDetail" object:nil];
    
[[self tableView] reloadData];
    
    
    
}



- (IBAction)segmentedbutton:(UISegmentedControl *)sender {
    switch (self.SegmentedButton.selectedSegmentIndex) {
        case 0:
        {
            NSLog(@"ministatement");
            [[self tableView] reloadData];
            
            break;
        }
        case 1:
        {
            [self performSegueWithIdentifier:@"detailedSegue" sender:self];
            sender.selectedSegmentIndex=0;
            
            break;
        }
    }
}



-(void)ReceivedData:(NSNotification *)TheNotification
{
    Amount=[TheNotification.userInfo objectForKey:@"amount"];
    Date=[TheNotification.userInfo objectForKey:@"date"];
    Type=[TheNotification.userInfo objectForKey:@"type"];
    
    NSLog(@"AMOUNT IS : %@",Amount);
    [[self tableView] reloadData];
    
}
-(void)ReceivedDetailData:(NSNotification *)TheNotification1
{
    Amount1=[TheNotification1.userInfo objectForKey:@"amount"];
    Date1=[TheNotification1.userInfo objectForKey:@"date"];
    Type1=[TheNotification1.userInfo objectForKey:@"type"];
    
    NSLog(@"AMIOUNT %@",Amount1);
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailedViewController *MyVC=(DetailedViewController *)segue.destinationViewController;
    MyVC.DetailAmount=Amount1;
    MyVC.Detaildate=Date1;
    MyVC.DetailType=Type1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return Amount.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Mycell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UILabel *DateLabel=(UILabel *)[Mycell viewWithTag:1];
    UILabel *AmmountLabel=(UILabel *)[Mycell viewWithTag:2];
    UILabel *TransactionLabel=(UILabel *)[Mycell viewWithTag:3];
    
    [DateLabel setText:[Date objectAtIndex:indexPath.row]];
    [AmmountLabel setText:[Amount objectAtIndex:indexPath.row]];
    [TransactionLabel setText:[Type objectAtIndex:indexPath.row]];
    return Mycell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"DATE         |       TYPE       |    AMOUNT";
    
    
    
}


@end
