//
//  WebService.h
//  JobApplicationForm
//
//  Created by Apple on 12/03/16.
//  Copyright © 2016 cts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WebService;

@protocol WebServiceDelegate <NSObject>

-(void)getWebServiceResult:(NSDictionary *)jsonResults;

@end

@interface WebService : NSObject

@property (nonatomic,retain) id <WebServiceDelegate> delegate;

-(void)getResponseFromServer:(NSString *)url withParam:(NSDictionary *)params;
@end
