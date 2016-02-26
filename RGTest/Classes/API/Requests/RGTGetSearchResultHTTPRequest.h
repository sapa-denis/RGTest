//
//  RGTGetSearchResultHTTPRequest.h
//  RGTest
//
//  Created by Sapa Denys on 19.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGTBaseHTTPRequest.h"

@interface RGTGetSearchResultHTTPRequest : NSObject <RGTBaseHTTPRequest>

- (instancetype)initWithCategory:(NSString *)category
				andSearchRequest:(NSString *)keywords
						pageSize:(NSUInteger)pageSize
						  offset:(NSUInteger)offset;

@end
