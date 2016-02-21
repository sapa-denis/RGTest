//
//  RGTCategory+CoreDataProperties.h
//  
//
//  Created by Sapa Denys on 18.02.16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RGTCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface RGTCategory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *categoryID;
@property (nullable, nonatomic, retain) NSString *categoryName;
@property (nullable, nonatomic, retain) NSString *fullName;

@end

NS_ASSUME_NONNULL_END
