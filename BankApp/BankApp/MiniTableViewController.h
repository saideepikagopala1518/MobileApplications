//
//  MiniTableViewController.h
//  BankApp
//
//  Created by Apple on 09/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiniTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) IBOutlet UISegmentedControl *SegmentedButton;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *menu;
@end
