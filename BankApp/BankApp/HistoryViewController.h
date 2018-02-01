//
//  HistoryViewController.h
//  BankApp
//
//  Created by Apple on 08/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButton;

@property(strong,nonatomic) NSMutableArray *LeafCountArray;
@property(strong,nonatomic) NSMutableArray *ReqDateArray;
@property(strong,nonatomic) NSString *AccNumber;
@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property(nonatomic,retain)IBOutlet UITextField *accNumberField;
- (IBAction)SegmentedButton:(UISegmentedControl *)sender;
@end
