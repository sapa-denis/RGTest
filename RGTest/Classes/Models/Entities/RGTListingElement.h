//
//  RGTListingElement.h
//  RGTest
//
//  Created by Sapa Denys on 23.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGTProductInfoProtocol.h"

@interface RGTListingElement : NSObject <RGTProductInfoProtocol>

@property (nullable, nonatomic, strong) NSString *fullDescription;
@property (nullable, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSString *price;
@property (nullable, nonatomic, strong) NSNumber *productID;

@property (nullable, nonatomic, strong, readonly) NSString *currencyCode;

@property (nullable, nonatomic, strong) NSString *image75URL;
@property (nullable, nonatomic, strong) NSString *image570URL;

@end
