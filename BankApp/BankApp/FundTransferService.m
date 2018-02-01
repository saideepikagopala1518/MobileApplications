//
//  FundTransferService.m
//  BankApp
//
//  Created by Apple on 09/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "FundTransferService.h"
#import <UIKit/UIKit.h>

@interface FundTransferService()
@property(nonatomic,strong) NSDictionary *jsonDataTransfer;

@end

@implementation FundTransferService

-(void)AccountNumber:(NSString *)acnumber Beneficiary:(NSString *)Benf Password:(NSString *)passwd Amount:(NSString *)amt Date:(NSString *)date1
{
    
    NSDictionary *acc = @{@"account_number":acnumber,@"payee_account_number":Benf ,@"transaction_password":passwd,@"amount":amt ,@"date":date1};
    
    NSLog(@"===== : %@",acc);
    NSError *errorjs;
    NSData *jsonInputDataSummary = [NSJSONSerialization dataWithJSONObject:acc options:NSJSONWritingPrettyPrinted error:&errorjs];
    NSLog(@"%@",errorjs);
    NSURL *url=[NSURL URLWithString:@"http://10.251.163.5:8088/MFRPServices/bank_fund_transfer"];
    
    
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
                 NSLog(@"---------------");
                 
                 NSString *responseDataSummary = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"Response ==> %@", responseDataSummary);
                 
                 NSError *error = nil;
                 
                 self.jsonDataTransfer = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                 
                 NSLog(@"JSON DATA CHEQUE IS ======= %@",self.jsonDataTransfer);
                 
                 
                 
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"msg" object:self userInfo:@{@"msg":[self.jsonDataTransfer objectForKey:@"status"]}];
                 
                 
                 
                 
                 
             }
             else
             {
                 UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid Account Number or Password" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [alert show];
             }
             
         }
         
     }];
    
    
    
    
}


@end
