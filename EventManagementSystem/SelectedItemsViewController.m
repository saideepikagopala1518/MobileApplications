//
//  SelectedItemsViewController.m
//  EventVer2
//
//  Created by apple on 09/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "SelectedItemsViewController.h"

@interface SelectedItemsViewController ()
- (IBAction)submitTapped:(id)sender;

@end

@implementation SelectedItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.decorArray=[@[@"Furniture",@"Caterers",@"Photography",@"Cutlery",@"Confectionary"]mutableCopy];
    self.decorView.dataSource=self;
    self.decorView.delegate=self;
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.decorArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.decorView dequeueReusableCellWithIdentifier:@"decor" forIndexPath:indexPath];
    cell.textLabel.text=[self.decorArray objectAtIndex:indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0)
    {
        self.decorationCost=self.decorationCost+10000;
    }
    if(indexPath.row==1)
    {
        self.decorationCost=self.decorationCost+2000;
    }
    if(indexPath.row==2)
    {
        self.decorationCost=self.decorationCost+3000;
    }
    if(indexPath.row==3)
    {
        self.decorationCost=self.decorationCost+4000;
    }
    if(indexPath.row==4)
    {
        self.decorationCost=self.decorationCost+5000;
    }
}



- (IBAction)backButton:(id)sender {
    [self performSegueWithIdentifier:@"back" sender:nil];
    
}

- (IBAction)confirmButton:(id)sender {
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@" Event Confirmation" message:@"Click OK To Confirm" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [controller addAction:confirmAction];
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
    
}


- (IBAction)logoutButton:(id)sender {
    [self performSegueWithIdentifier:@"logout" sender:nil];
}


- (IBAction)calculateAmount:(id)sender {
    
    self.totalCost=self.decorationCost+self.hallTemp2;
  self.hallOutlet.text=[NSString stringWithFormat:@"%f",self.hallTemp2];
   self.decorCostOutlet.text=[NSString stringWithFormat:@"%f",self.decorationCost];
    self.totalOutlet.text=[NSString stringWithFormat:@"%f",self.totalCost];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitTapped:(id)sender {
    [self performSegueWithIdentifier:@"ToFifth" sender:nil];
}
@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

*/
