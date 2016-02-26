//
//  RGTGetSearchResultHTTPRequest.m
//  RGTest
//
//  Created by Sapa Denys on 19.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTGetSearchResultHTTPRequest.h"

@implementation RGTGetSearchResultHTTPRequest

@synthesize parameters;

- (instancetype)initWithCategory:(NSString *)category
				andSearchRequest:(NSString *)keywords
						pageSize:(NSUInteger)pageSize
						  offset:(NSUInteger)offset
{
	self = [super init];
	if (self) {
		parameters = @{ @"category" : category,
						@"keywords" : keywords,
						@"limit" : @(pageSize),
						@"offset": @(offset)
						};
	}
	return self;
}

- (NSString *)path
{
	return @"listings/active";
}

@end
