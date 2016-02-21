//
//  RGTSearchResultCollectionViewController.h
//  RGTest
//
//  Created by Sapa Denys on 18.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGTCategory;

@interface RGTSearchResultCollectionViewController : UICollectionViewController

@property (nonatomic, strong) RGTCategory *category;
@property (nonatomic, copy) NSString *seatchRequest;

@end
