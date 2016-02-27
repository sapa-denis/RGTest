//
//  RGTProductInfoProtocol.h
//  RGTest
//
//  Created by Sapa Denys on 23.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RGTProductInfoProtocol <NSObject>

@property (nullable, nonatomic, strong, readonly) NSString *fullDescription;
@property (nullable, nonatomic, strong, readonly) NSString *name;
@property (nullable, nonatomic, strong, readonly) NSString *price;
@property (nullable, nonatomic, strong, readonly) NSNumber *productID;

@property (nullable, nonatomic, strong, readonly) NSString *currencyCode;

@property (nullable, nonatomic, strong, readonly) NSString *image75URL;
@property (nullable, nonatomic, strong, readonly) NSString *image570URL;

@end
