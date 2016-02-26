//
//  RGTProduct+CoreDataProperties.h
//  
//
//  Created by Sapa Denys on 23.02.16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RGTProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface RGTProduct (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *fullDescription;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSNumber *productID;
@property (nullable, nonatomic, retain) NSNumber *saved;

@property (nullable, nonatomic, retain) NSString *currencyCode;

@end

NS_ASSUME_NONNULL_END
