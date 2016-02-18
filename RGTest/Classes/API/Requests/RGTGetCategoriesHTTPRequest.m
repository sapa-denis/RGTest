//
//  RGTGetCategoriesHTTPRequest.m
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTGetCategoriesHTTPRequest.h"

@implementation RGTGetCategoriesHTTPRequest

@synthesize parameters;

- (instancetype)init
{
	self = [super init];
	if (self) {
		parameters = @{};
	}
	return self;
}

- (NSString *)path
{
	return @"taxonomy/categories";
}

@end
