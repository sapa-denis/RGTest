//
//  RGTProduct.h
//  
//
//  Created by Sapa Denys on 21.02.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "RGTProductInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RGTProduct : NSManagedObject <RGTProductInfoProtocol>

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "RGTProduct+CoreDataProperties.h"
