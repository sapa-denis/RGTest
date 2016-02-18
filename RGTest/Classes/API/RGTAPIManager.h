//
//  RGTAPIManager.h
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGTBaseHTTPRequest.h"

@interface RGTAPIManager : NSObject

- (instancetype)initWithBaseURL:(NSString *)baseURL APIToken:(NSString *)token;

- (void)makeGETRequest:(id<RGTBaseHTTPRequest>)request
			   success:(void (^)(NSDictionary *responseObject))success
			   failure:(void (^)(NSError *error))failure;

@end
