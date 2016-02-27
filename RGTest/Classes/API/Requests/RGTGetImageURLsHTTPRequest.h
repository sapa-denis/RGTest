//
//  RGTGetImageURLsHTTPRequest.h
//  RGTest
//
//  Created by Sapa Denys on 27.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGTBaseHTTPRequest.h"

@interface RGTGetImageURLsHTTPRequest : NSObject <RGTBaseHTTPRequest>

-(instancetype)initWithProduct:(NSString *)productID;

@end
