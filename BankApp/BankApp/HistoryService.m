//
//  HistoryService.m
//  BankApp
//
//  Created by Apple on 10/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "HistoryService.h"
#import <UIKit/UIKit.h>

@interface HistoryService()
{
    NSMutableArray *LeafCnt;
    NSMutableArray *ReqDate;
    
}

@end

@implementation HistoryService

-(void)AccountNumber:(NSString *)acnumber
{
    NSDictionary *acc = @{@"account_number":acnumber};
    
    NSLog(@"===== : %@",acc);
    NSError *errorjs;
    NSData *jsonInputDataSummary = [NSJSONSerialization dataWithJSONObject:acc options:NSJSONWritingPrettyPrinted error:&errorjs];
    NSLog(@"%@",errorjs);
    NSURL *url=[NSURL URLWithString:@"http://10.251.163.5:8088/MFRPServices/bank_cheque_detail"];
    
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url];
    [request1 setHTTPMethod:@"POST"];
    
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request1 setHTTPBody:jsonInputDataSummary];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request1 completionHandler:^(NSData *urlData, NSURLResponse *response, NSError *connectionError)

     {
         NSLog(@"error-%@",connectionError);
         if(!connectionError)
         {
             if ([(NSHTTPURLResponse *) response statusCode] == 200)
             {
                 NSLog(@"---------------");
                 
                 NSString *responseDataSummary = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"Response ==> %@", responseDataSummary);
                 
                 NSError *error = nil;
                 
                 self.jsonDataChequeHistory = [NSJSONSerialization
                                               JSONObjectWithData:urlData
                                               options:NSJSONReadingMutableContainers
                                               error:&error];
                 
                 NSLog(@"JSON DATA CHEQUE DETAIL ======= %@",self.jsonDataChequeHistory);
                 
                 LeafCnt=[[NSMutableArray alloc] init];
                 ReqDate=[[NSMutableArray alloc ] init];
                 
                 for(NSDictionary *Che in [self.jsonDataChequeHistory objectForKey:@"results"])
                 {
                     [LeafCnt addObject:[Che objectForKey:@"leaf_count"]];
                     [ReqDate addObject:[Che objectForKey:@"requested_date"]];
                     
                 }
                 
                 
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"Historydetails" object:self userInfo:@{@"leafcnt":LeafCnt,@"reqdate":ReqDate,@"acnumber":[[[self.jsonDataChequeHistory objectForKey:@"results"] objectAtIndex:1] objectForKey:@"account_number"]}];
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:self];
             }
             else
             {
                 UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid Account Number or Password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [alert show];
             }
             
         }
         
     }];
    
    
    [task resume];
    
}

@end
