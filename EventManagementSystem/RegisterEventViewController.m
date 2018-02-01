//
//  RegisterEventViewController.m
//  EventVer2
//
//  Created by apple on 09/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "RegisterEventViewController.h"
#import "GalleryCollectionViewController.h"

#import "DisplayViewController.h"

@interface RegisterEventViewController ()
- (IBAction)RegisterAction:(id)sender;
- (IBAction)selectHallAction:(id)sender;

@property(nonatomic,strong)NSMutableArray *hallListArray;
@property(nonatomic,strong)NSDictionary *saveDetails;

@end

@implementation RegisterEventViewController
@synthesize saveDetails;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


self.eventNameField.delegate=self;
self.locationField.delegate=self;
self.hallView.delegate=self;
self.hallView.dataSource=self;

self.hallArray=[NSMutableArray array];

NSDateFormatter *format = [[NSDateFormatter alloc]init];
format.dateFormat = @"yyyy-MM-dd";
self.datePic.datePickerMode=UIDatePickerModeDate;

[self.datePic addTarget:self action:@selector(displayDate:) forControlEvents:UIControlEventValueChanged];
//self.hallView.hidden=YES;

self.hallCost=0;

}



-(void)displayDate:(UIDatePicker *)pic
{
    NSDateFormatter *theDateSet=[[NSDateFormatter alloc]init];
    theDateSet.dateFormat = @"yyyy-MM-dd";
    self.dateString=[theDateSet stringFromDate:self.datePic.date];
    NSLog(@"the date is%@",self.dateString);
    self.datefield.text=[NSString stringWithFormat:@"%@",self.dateString];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)RegisterAction:(id)sender {
    if([self.eventNameField.text isEqualToString:@""] || [self.locationField.text isEqualToString:@""] || [self.hallField.text isEqualToString:@""] || [self.dateString isEqualToString:@""])
    {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Empty fields" message:@"Enter all  fields" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        self.saveDetails=@{@"date":self.dateString,@"hallname":self.hallField.text,@"eventname":self.eventNameField.text,@"location":self.locationField.text};
        NSLog(@"Event Details are as follows:");
        NSLog(@"%@",self.saveDetails);
        [self performSegueWithIdentifier:@"ToTable" sender:nil];
    }
    
}

- (IBAction)selectHallAction:(id)sender {
    if([self.datefield.text isEqualToString:@""])
    {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Date Not Selected" message:@"Select a date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else if([self.eventNameField.text isEqualToString:@""] || [self.locationField.text isEqualToString:@""])
    {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Empty Fields" message:@"Event name or location field is empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        NSDictionary *dict=@{@"date":self.dateString};
        NSError *errobj;
        NSURL *url=[NSURL URLWithString:@"http://10.251.163.5:8080/MFRPServices/gethall"];
        NSData *jsonInputData=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&errobj];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonInputData];
        
        NSLog(@"%@",request);
        
        NSURLSessionDataTask *Logindata=[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary  *Data =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            NSLog(@"%@",Data);
            
            if(!error)
            {
                
                if([[Data objectForKey:@"statusMessage"] isEqualToString:@"Successfully retrieved Halls details....."])
                {
                    self.hallListArray=[Data objectForKey:@"hallList"];
                    NSLog(@"%@",self.hallListArray);
                    if(self.hallListArray==nil)
                    {
                        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Empty Fields" message:@"Event name or location field is empty" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [controller addAction:okAction];
                        [self presentViewController:controller animated:YES completion:nil];
                    }
                    else{
                        for (NSDictionary *item in self.hallListArray)
                        {
                            
                            [self.hallArray addObject:[item valueForKey:@"name"]];
                            self.hallView.hidden=NO;
                            [self.hallView reloadData];
                        }
                        for(NSString *item1 in self.hallArray)
                        {
                            NSLog(@"%@",item1);
                        }
                    }
                    
                }
                
                
            }
            else
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"Network Error" message:@"Cannot connect to the internet" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //
                    }];
                    [controller addAction:okAction];
                    [self presentViewController:controller animated:YES completion:nil];
                });
                
            }
            
        }];
        [Logindata resume];
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hallArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.hallView dequeueReusableCellWithIdentifier:@"hallCell" forIndexPath:indexPath];
    cell.textLabel.text=[self.hallArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hallField.text=[self.hallArray objectAtIndex:indexPath.row];
    if(indexPath.row==0)
    {
        self.hallCost=self.hallCost+1000;
    }
    else if(indexPath.row==1)
    {
        self.hallCost=self.hallCost+2000;
    }
    else if(indexPath.row==2)
    {
        self.hallCost=self.hallCost+3000;
    }
     NSLog(@"%f",self.hallCost);
    
    self.hallView.hidden=YES;
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  // if ([[segue identifier] isEqualToString:@"ToThird"])
   //{
     //  GalleryCollectionViewController *galleryController=(GalleryCollectionViewController *)segue.destinationViewController;
   // galleryController.hallValue=self.hallCost;
        
 //   }
    if ([[segue identifier] isEqualToString:@"ToTable"])
    {
        DisplayViewController *finalCtrl= (DisplayViewController *)segue.destinationViewController;
        finalCtrl.date1=[saveDetails objectForKey:@"date"];
        finalCtrl.event1=[saveDetails objectForKey:@"eventname"];
        finalCtrl.loc1=[saveDetails objectForKey:@"hallname"];
        finalCtrl.hall1=[saveDetails objectForKey:@"location"];
        finalCtrl.hallCost=self.hallCost;
        
    }
  
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
