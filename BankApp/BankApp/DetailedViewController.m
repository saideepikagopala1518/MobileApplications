//
//  DetailedViewController.m
//  BankApp
//
//  Created by Apple on 10/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "DetailedViewController.h"
#import "DetailedService.h"
#import "SWRevealViewController.h"

@interface DetailedViewController ()
{
    NSString *strDatet;
    NSString *strDatef;
    NSString *MyString;
}

@end

@implementation DetailedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.hidesBackButton = YES;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.meenu setTarget: self.revealViewController];
        [self.meenu setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self.fDate addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tDate addTarget:self action:@selector(datePickerChanged2:) forControlEvents:UIControlEventValueChanged];
    [[self detailedTablevView]reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReceivedDetailData:) name:@"DetailStatementDetail" object:nil];
    // Do any additional setup after loading the view.
}
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    strDatef = [dateFormatter stringFromDate:datePicker.date];
}

- (void)datePickerChanged2:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    strDatet = [dateFormatter stringFromDate:datePicker.date];
}

-(IBAction)goPressed:(id)sender
{
    [[self detailedTablevView]reloadData];
    NSString *acc=@"112233445566";
    NSString *type=@"savings";
    NSLog(@"inside gopressed");
    NSLog(@"%@",strDatef);
    NSDate *now=[NSDate date];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    MyString=[DateFormatter stringFromDate:now];
    if([strDatef isEqualToString:MyString]||[strDatet isEqualToString:@""])
    {
        UIAlertController *uiAlertCtrl = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Date fields should not be empty " preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [uiAlertCtrl addAction:okAction];
        
        [self presentViewController:uiAlertCtrl animated:YES completion:nil];

    }
    else
    {
    DetailedService *ds=[[DetailedService alloc]init];
    [ds AccNumber:acc Type:type FromDate:strDatef Todate:strDatet];
    [[self detailedTablevView]reloadData];
    }
}
-(void)ReceivedDetailData:(NSNotification *)TheNotification1
{
    self.DetailAmount=[TheNotification1.userInfo objectForKey:@"amount"];
    self.Detaildate=[TheNotification1.userInfo objectForKey:@"date"];
    self.DetailType=[TheNotification1.userInfo objectForKey:@"type"];
    
    NSLog(@"AMIOUNT %@ %@ %@",self.DetailAmount,self.Detaildate,self.DetailType);
    [[self detailedTablevView]reloadData];
}

- (IBAction)segmentedbutton:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            [[self navigationController]popViewControllerAnimated:YES ];
            break;
        case 1:
            
            [[self detailedTablevView]reloadData];
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.DetailAmount.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dcell" forIndexPath:indexPath];
    
    UILabel *DateLabel=(UILabel *)[cell viewWithTag:1];
    UILabel *AmmountLabel=(UILabel *)[cell viewWithTag:2];
    UILabel *TransactionLabel=(UILabel *)[cell viewWithTag:3];
    
    [DateLabel setText:[self.Detaildate objectAtIndex:indexPath.row]];
    [AmmountLabel setText:[self.DetailAmount objectAtIndex:indexPath.row]];
    [TransactionLabel setText:[self.DetailType objectAtIndex:indexPath.row]];
    return cell;
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
