//
//  APIController.h
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGTAPIController : NSObject

+ (RGTAPIController *)sharedController;

- (void)getCategoriesWithSuccess:(void (^)(id responseObject))success
						 failure:(void (^)(NSError *error))failure;

@end
