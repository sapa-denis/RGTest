//
//  APIController.m
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTAPIController.h"
#import "RGTAPIManager.h"
#import "RGTMapping.h"

#import "RGTGetCategoriesHTTPRequest.h"
#import "RGTGetSearchResultHTTPRequest.h"

static NSString *const kRGTAPIBaseURL	= @"https://openapi.etsy.com/v2/";
static NSString *const kRGTAPIToken		= @"l6pdqjuf7hdf97h1yvzadfce";

@interface RGTAPIController ()

@property (nonatomic, strong) RGTAPIManager *apiManager;

@end

@implementation RGTAPIController

+ (RGTAPIController *)sharedController
{
	static RGTAPIController *sharedController;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedController = [[RGTAPIController alloc] init];
		sharedController.apiManager = [[RGTAPIManager alloc] initWithBaseURL:kRGTAPIBaseURL
																	APIToken:kRGTAPIToken];
	});
	return sharedController;
}

- (void)getCategoriesWithSuccess:(void (^)(id responseObject))success
						 failure:(void (^)(NSError *error))failure
{
	RGTGetCategoriesHTTPRequest *getCategories = [[RGTGetCategoriesHTTPRequest alloc] init];
	[self.apiManager makeGETRequest:getCategories
							success:^(id responseObject) {
								[MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
									[FEMDeserializer collectionFromRepresentation:responseObject[@"results"]
																		  mapping:[RGTCategory defaultMapping]
																		  context:localContext];
									
									
								} completion:^(BOOL contextDidSave, NSError * _Nullable error) {
									if (success) {
										dispatch_async(dispatch_get_main_queue(), ^{
											success(nil);
										});
									}
								}];
							}
							failure:failure];
}

- (void)getSearchResultWithRequest:(NSString *)searchRequest
					   andCategory:(NSString *)category
							offset:(NSUInteger)offset
						  pageSize:(NSUInteger)pageSize
						   success:(void (^)(id responseObject, NSUInteger count))success
						   failure:(void (^)(NSError *error))failure
{
	RGTGetSearchResultHTTPRequest *getSearchResult =
		[[RGTGetSearchResultHTTPRequest alloc] initWithCategory:category
											   andSearchRequest:searchRequest
													   pageSize:pageSize
														 offset:offset];
	
	dispatch_queue_t parseQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	[self.apiManager makeGETRequest:getSearchResult
							success:^(id responseObject) {
								dispatch_async(parseQueue, ^{
									NSArray *listings = [FEMDeserializer collectionFromRepresentation:responseObject[@"results"] mapping:[RGTListingElement defaultMapping]];
									NSUInteger count = [[responseObject objectForKey:@"count"] unsignedIntegerValue];
									if (success) {
										dispatch_async(dispatch_get_main_queue(), ^{
											success(listings, count);
										});
									}
								});
							}
							failure:failure];
}

@end
