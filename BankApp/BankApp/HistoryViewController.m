//
//  HistoryViewController.m
//  BankApp
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryService.h"

@interface HistoryViewController ()




@end

@implementation HistoryViewController
- (IBAction)SegmentedButton:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            [[self navigationController] popViewControllerAnimated:YES];
            break;
       
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.hidesBackButton = YES;   
    [[self view] setNeedsDisplay];
    [[self TableView] reloadData];
    
    HistoryService *hs=[[HistoryService alloc]init];
    [hs AccountNumber:@"112233445566"];

   self.accNumberField.text=self.AccNumber;
    [[self TableView] reloadData];
    }

-(void)viewWillAppear:(BOOL)animated
{
    [[self view] setNeedsDisplay];
    [[self TableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.LeafCountArray.count;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *Mycell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    UILabel *LeafCountLabel=(UILabel *)[Mycell viewWithTag:1];
    UILabel *ReqDateLabel=(UILabel *)[Mycell viewWithTag:2];
    
    [LeafCountLabel setText:[self.LeafCountArray objectAtIndex:indexPath.row]];
    [ReqDateLabel setText:[self.ReqDateArray objectAtIndex:indexPath.row]];
    
    
    
    return Mycell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
