//
//  FundTransferService.h
//  BankApp
//
//  Created by Apple on 09/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FundTransferService : NSObject
-(void)AccountNumber:(NSString *)acnumber Beneficiary:(NSString *)Benf Password:(NSString *)passwd Amount:(NSString *)amt Date:(NSString *)date1;

@end
