//
//  WebService.h
//  BankApp
//
//  Created by Apple on 09/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WebService;
@protocol WebServiceDelegate <NSObject>

-(void)getResponseFromWeb:(NSDictionary *)result by:(NSString *)type;
@end
@interface WebService : NSObject
@property(nonatomic,retain) id <WebServiceDelegate> webDelegate;
-(void)callWebServiceURL:(NSString *)webUrl withPayLoad:(NSDictionary *)payLoad withType:(NSString *)type;
@end
