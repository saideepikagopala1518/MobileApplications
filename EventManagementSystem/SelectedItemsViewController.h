//
//  SelectedItemsViewController.h
//  EventVer2
//
//  Created by apple on 09/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterEventViewController.h"

@interface SelectedItemsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *decorView;
@property (weak, nonatomic) IBOutlet UILabel *hallOutlet;
@property (weak, nonatomic) IBOutlet UILabel *totalOutlet;

@property (weak, nonatomic) IBOutlet UILabel *decorCostOutlet;
;

@property(nonatomic)double decorationCost;
@property(nonatomic)double totalCost;
@property(nonatomic)double hallTemp2;


- (IBAction)calculateAmount:(id)sender;


@property(nonatomic,strong)NSArray *decorArray;


- (IBAction)backButton:(id)sender;
- (IBAction)confirmButton:(id)sender;
- (IBAction)logoutButton:(id)sender;



@end
