//
//  RGTAPIManager.m
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTAPIManager.h"
#import <AFNetworking/AFNetworking.h>

@interface RGTAPIManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSString *token;

@property (nonatomic) dispatch_queue_t backgroundQueue;

@end

@implementation RGTAPIManager

- (instancetype)initWithBaseURL:(NSString *)baseURL APIToken:(NSString *)token
{
	self = [super init];
	if (self) {
		_sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
		_token = token;
		
		_backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
	}
	return self;
}

- (void)makeGETRequest:(id<RGTBaseHTTPRequest>)request
			   success:(void (^)(NSDictionary *responseObject))success
			   failure:(void (^)(NSError *error))failure
{
	NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:request.parameters];
	[parameters setObject:self.token forKey:@"api_key"];
	
	
	
	__weak __block typeof(self) weakSelf = self;
	dispatch_async(self.backgroundQueue, ^{
		[weakSelf GETRequest:[request path] parameters:parameters success:success failure:failure];
	});
}

- (void)GETRequest:(NSString *)path
		parameters:(NSDictionary *)parameters
		   success:(void (^)(NSDictionary *responseObject))success
		   failure:(void (^)(NSError *error))failure
{
	[self.sessionManager GET:path
				  parameters:parameters
					progress:nil
					 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
						 NSLog(@"(%@) ✅ %@", path, responseObject);
						 success(responseObject);
					 }
					 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
						 NSLog(@"(%@) ❌ %@", path, error.localizedDescription);
						 failure(error);
					 }];
}

@end
