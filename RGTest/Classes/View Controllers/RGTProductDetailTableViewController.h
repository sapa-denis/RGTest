//
//  RGTProductDetailTableViewController.h
//  RGTest
//
//  Created by Sapa Denys on 22.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGTProductInfoProtocol.h"

@class RGTListingElement;

@interface RGTProductDetailTableViewController : UITableViewController

@property (nonatomic, strong) id<RGTProductInfoProtocol> productInfo;



@end
