//
//  RGTGetImageURLsHTTPRequest.m
//  RGTest
//
//  Created by Sapa Denys on 27.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTGetImageURLsHTTPRequest.h"

@interface RGTGetImageURLsHTTPRequest ()

@property (nonatomic, copy) NSString *productID;

@end

@implementation RGTGetImageURLsHTTPRequest

@synthesize parameters;

-(instancetype)initWithProduct:(NSString *)productID
{
	self = [super init];
	if (self) {
		parameters = @{};
		_productID = productID;
	}
	return self;
}

- (NSString *)path
{
	return [NSString stringWithFormat:@"listings/%@/images", self.productID];
}

@end
