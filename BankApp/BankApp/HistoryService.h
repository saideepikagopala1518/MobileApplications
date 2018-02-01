//
//  HistoryService.h
//  BankApp
//
//  Created by Apple on 10/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryService : NSObject
-(void)AccountNumber:(NSString *)acnumber;
@property(nonatomic,strong) NSDictionary *jsonDataChequeHistory;
@end
