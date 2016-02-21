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
