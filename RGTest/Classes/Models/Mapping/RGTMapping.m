//
//  RGTMapping.m
//  RGTest
//
//  Created by Sapa Denys on 18.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTMapping.h"

@implementation RGTCategory (Mapping)

+ (FEMMapping *)defaultMapping
{
	FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"RGTCategory"];
	[mapping addAttributesFromDictionary:@{ @"categoryID" : @"category_id",
											@"fullName" : @"long_name",
											@"categoryName" : @"category_name"
											}];
	
	mapping.primaryKey = @"categoryID";
	
	return mapping;
}

@end

@implementation RGTProduct (Mapping)

+ (FEMMapping *)defaultMapping
{
	FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"RGTProduct"];
	[mapping addAttributesFromDictionary:@{ @"price" : @"price",
											@"name" : @"title",
											@"fullDescription" : @"description",
											@"productID" : @"listing_id",
											@"currencyCode" : @"currency_code"
											}];
	
	mapping.primaryKey = @"productID";
	
	return mapping;
}

@end

@implementation RGTListingElement (Mapping)

+ (FEMMapping *)defaultMapping
{
	FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[RGTListingElement class]];
	[mapping addAttributesFromDictionary:@{ @"price" : @"price",
											@"name" : @"title",
											@"fullDescription" : @"description",
											@"productID" : @"listing_id",
											@"currencyCode" : @"currency_code"
											}];
	
	return mapping;
}

@end
