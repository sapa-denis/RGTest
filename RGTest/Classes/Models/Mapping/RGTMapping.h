//
//  RGTMapping.h
//  RGTest
//
//  Created by Sapa Denys on 18.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FastEasyMapping/FastEasyMapping.h>

#import "RGTCategory.h"
#import "RGTProduct.h"
#import "RGTListingElement.h"

@interface RGTCategory (Mapping)
+ (FEMMapping *)defaultMapping;
@end

@interface RGTProduct (Mapping)
+ (FEMMapping *)defaultMapping;
@end

@interface RGTListingElement (Mapping)
+ (FEMMapping *)defaultMapping;
@end