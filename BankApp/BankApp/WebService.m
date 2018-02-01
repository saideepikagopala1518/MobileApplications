//
//  WebService.m
//  BankApp
//
//  Created by Apple on 09/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import "WebService.h"
#import <UIKit/UIKit.h>
@implementation WebService
@synthesize webDelegate;
-(void)callWebServiceURL:(NSString *)webUrl withPayLoad:(NSDictionary *)payLoad withType:(NSString *)type{
   // NSLog(@"inside webservice call");
    NSURL *url = [NSURL URLWithString:webUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:240];
    
    [request setHTTPMethod:@"POST"];
    
    
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *errorjs;
     NSData *jsonInputData = [NSJSONSerialization dataWithJSONObject:payLoad options:NSJSONWritingPrettyPrinted error:&errorjs];
    [request setHTTPBody:jsonInputData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(!error)
        {
        NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)response;
        
        if ([httpUrlResponse statusCode] == 200){
            //Valid response
            NSLog(@"login Success");
            NSError *rError;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&rError];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                [webDelegate getResponseFromWeb:result by:type];
                
            });
            
            
        }else{
           
            NSLog(@"response status is not 200");
        
            UIAlertView *MyV=[[UIAlertView alloc] initWithTitle:@"Invalid Response" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [MyV show];

        }
        }
        else
        {
            UIAlertView *MyV=[[UIAlertView alloc] initWithTitle:@"Netwotk Connection Error" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [MyV show];
        }
        
    }];
    
    [task resume];
    
    
    
}

@end
