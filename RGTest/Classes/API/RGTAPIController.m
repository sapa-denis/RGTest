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
							success:^(id responseObject){
								[MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
									NSArray *categories = [FEMDeserializer collectionFromRepresentation:responseObject[@"results"] mapping:[RGTCategory defaultMapping] context:localContext];
									
									if (success) {
										dispatch_async(dispatch_get_main_queue(), ^{
											success(categories);
										});
									}
								}];
							}
							failure:failure];
}

@end
