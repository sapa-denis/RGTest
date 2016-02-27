//
//  RGTBaseHTTPRequest.h
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RGTBaseHTTPRequest <NSObject>

@property (nonatomic, strong, readonly) NSDictionary *parameters;
@property (nonatomic, strong, readonly) NSString *path;

@end
