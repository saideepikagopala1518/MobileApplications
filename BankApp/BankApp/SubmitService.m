//
//  SubmitService.m
//  BankApp
//
//  Created by Apple on 09/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "SubmitService.h"
#import <UIKit/UIKit.h>


@interface SubmitService()

@property(nonatomic,strong) NSDictionary *jsonDataCheque;

@end

@implementation SubmitService

-(void)AccountNumber:(NSString *)acnumber LeafCount:(NSString *)leafcnt Date:(NSString *)date1
{
    
    
    NSDictionary *acc = @{@"account_number":acnumber,@"leaf_count":leafcnt ,@"request_date":date1};
    
    NSLog(@"%@",acc);
    NSError *errorjs;
    NSData *jsonInputDataSummary = [NSJSONSerialization dataWithJSONObject:acc options:NSJSONWritingPrettyPrinted error:&errorjs];
    
    NSURL *url=[NSURL URLWithString:@"http://10.251.163.5:8088/MFRPServices/bank_cheque_add"];
    
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    [request1 setURL:url];
    [request1 setHTTPMethod:@"POST"];
    
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request1 setHTTPBody:jsonInputDataSummary];
    
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *urlData, NSError *connectionError)
     {
         NSLog(@"%@",connectionError);
         if(!connectionError)
         {
             if ([(NSHTTPURLResponse *) response statusCode] == 200)
             {
                 NSLog(@"dsfsdfsdfsdf");
                 
                 NSString *responseDataSummary = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"%@", responseDataSummary);
                 
                 NSError *error = nil;
                 
                 self.jsonDataCheque = [NSJSONSerialization
                                        JSONObjectWithData:urlData
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
                 
                 NSLog(@"JSON DATA CHEQUE IS ======= %@",self.jsonDataCheque);
                 
                 
                 
                 
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"msg" object:self userInfo:@{@"msg":[self.jsonDataCheque objectForKey:@"message"]}];
                 
                 
                 
                 
             }
             else
             {
                 UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Connection Error" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                 [alert show];
             }
             
         }
         
     }];
    
    
    
    
}

@end
