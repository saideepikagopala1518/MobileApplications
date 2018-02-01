//
//  RegisterEventViewController.h
//  EventVer2
//
//  Created by apple on 09/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RegisterEventViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *eventNameField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *datefield;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePic;
@property (weak, nonatomic) IBOutlet UITextField *hallField;
@property (weak, nonatomic) IBOutlet UITableView *hallView;

@property(nonatomic,strong)NSString *dateString;
@property(nonatomic,strong)NSMutableArray *hallArray;
@property(nonatomic)double hallCost;


@end
