//
//  DetailedViewController.h
//  BankApp
//
//  Created by Apple on 10/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *meenu;
@property (weak, nonatomic) IBOutlet UIDatePicker *fDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *tDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentButton;
@property (weak, nonatomic) IBOutlet UITableView *detailedTablevView;
@property(strong,nonatomic)NSMutableArray *DetailAmount;
@property(strong,nonatomic)NSMutableArray *Detaildate;
@property(strong,nonatomic)NSMutableArray *DetailType;
- (IBAction)segmentedbutton:(UISegmentedControl *)sender;
@end