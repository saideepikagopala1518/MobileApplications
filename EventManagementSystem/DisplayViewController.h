//
//  DisplayViewController.h
//  EventVer2
//
//  Created by apple on 11/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayViewController : UIViewController

@property(nonatomic,retain) NSString *date1;
@property(nonatomic,retain) NSString *event1;

@property(nonatomic,retain) NSString *hall1;

@property(nonatomic,retain) NSString *loc1;
@property (strong, nonatomic) IBOutlet UILabel *datelbl;
@property(strong,nonatomic) IBOutlet UILabel *eventlbl;
@property (strong, nonatomic) IBOutlet UILabel *halllbl;
@property (strong, nonatomic) IBOutlet UILabel *loclbl;
@property(nonatomic)double hallCost;
@property(nonatomic)double hallValue;
@end
