//
//  DetailedService.m
//  BankApp
//
//  Created by Apple on 10/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "DetailedService.h"
#import <UIKit/UIKit.h>
#import "DetailedViewController.h"

@interface DetailedService()
{
    NSMutableArray *DateArray;
    NSMutableArray *AmmountArray;
    NSMutableArray *TypeArray;
}

@property(nonatomic,strong) NSDictionary *jsonDataDetailStatement;

@end

@implementation DetailedService

-(void)AccNumber:(NSString *)acnuber Type:(NSString *)type FromDate:(NSString *)frmdate Todate:(NSString *)todate
{
    NSDictionary *acc = @{@"account_number":acnuber,@"type":type,@"from_date":frmdate,@"to_date":todate};
    NSLog(@"===== : %@",acc);
    NSError *errorjs;
    NSData *jsonInputDataSummary = [NSJSONSerialization dataWithJSONObject:acc options:NSJSONWritingPrettyPrinted error:&errorjs];
    NSLog(@"%@",errorjs);
    NSURL *url=[NSURL URLWithString:@"http://10.251.163.5:8088/MFRPServices/bank_get_transaction"];
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url];
    [request1 setHTTPMethod:@"POST"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request1 setHTTPBody:jsonInputDataSummary];
    
   
   
    
    
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *connectionError)
     {
         NSLog(@"error-%@",connectionError);
         if(!connectionError)
         {
             if ([(NSHTTPURLResponse *) response statusCode] == 200)
             {
                 NSString *responseDataSummary = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"%@", responseDataSummary);
                 
                 NSError *error = nil;
                 
                 self.jsonDataDetailStatement = [NSJSONSerialization
                                                 JSONObjectWithData:urlData
                                                 options:NSJSONReadingMutableContainers
                                                 error:&error];
                 
                 NSLog(@"%@",self.jsonDataDetailStatement);
                 
                 AmmountArray=[[NSMutableArray alloc] init];
                 DateArray=[[NSMutableArray alloc] init];
                 TypeArray=[[NSMutableArray alloc] init];
                 
                 
                 for(NSDictionary *MyStatementDetail in [self.jsonDataDetailStatement objectForKey:@"account_transactions"])
                 {
                     [AmmountArray addObject:[MyStatementDetail objectForKey:@"amount"]];
                     
                     [DateArray addObject:[MyStatementDetail objectForKey:@"date"]];
                     
                     [TypeArray addObject:[MyStatementDetail objectForKey:@"transaction_type"]];
                     
                 }
                 
                 DetailedViewController *dvc=[[DetailedViewController alloc]init];
                 [[dvc detailedTablevView]reloadData];
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"DetailStatementDetail" object:self userInfo:@{@"amount":AmmountArray,@"date":DateArray,@"type":TypeArray}];
                 
                 
             }
             else
             {
                 UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid Response" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [alert show];
             }
             
         }
         else
         {
             UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Connection Error" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
             [alert show];
         }
         
     }];
  
  
    
    
}

@end
