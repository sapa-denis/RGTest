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

- (void)getSearchResultWithRequest:(NSString *)searchRequest
					   andCategory:(NSString *)category
							offset:(NSUInteger)offset
						  pageSize:(NSUInteger)pageSize
						   success:(void (^)(id responseObject, NSUInteger count))success
						   failure:(void (^)(NSError *error))failure;

- (void)getImageURLsForProduct:(NSString *)productID
					   success:(void (^)(NSString *imageSmallURL, NSString *imageLargeURL))success
					   failure:(void (^)(NSError *error))failure;

@end
