//
//  RGTSearchTest.m
//  RGTest
//
//  Created by Sapa Denys on 29.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTSearchTest.h"

@implementation RGTSearchTest

- (void)beforeEach
{

}

- (void)afterEach
{

}

- (void)testSuccessfulSearch
{
	[tester enterText:@"pic" intoViewWithAccessibilityLabel:@"Search Text Field"];
//	[tester enterText:@"thisismypassword" intoViewWithAccessibilityLabel:@"Login Password"];
	
	[tester selectPickerViewRowWithTitle:@"Art"];
	[tester tapViewWithAccessibilityLabel:@"Search"];
	
//	 Verify that the login succeeded
//	[tester waitForCellAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] inCollectionViewWithAccessibilityIdentifier:@"Search Collection View"];
}

@end
