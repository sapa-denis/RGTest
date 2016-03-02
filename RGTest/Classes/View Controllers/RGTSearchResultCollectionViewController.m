//
//  RGTSearchResultCollectionViewController.m
//  RGTest
//
//  Created by Sapa Denys on 18.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTSearchResultCollectionViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "RGTProductCollectionViewCell.h"
#import "RGTProductDetailTableViewController.h"
#import "RGTAPIController.h"

#import "RGTCategory.h"
#import "RGTListingElement.h"

#import "RGTProduct.h"

const NSUInteger kRGTPSearchDefaultPageSize = 25;

@interface RGTSearchResultCollectionViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSArray *results;

@property (nonatomic) NSUInteger searchResultsCount;

@end

@implementation RGTSearchResultCollectionViewController

static NSString *const reuseIdentifier = @"RGTProductCollectionViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Register cell classes
	[self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier
													bundle:[NSBundle mainBundle]]
		  forCellWithReuseIdentifier:reuseIdentifier];

	self.collectionView.accessibilityIdentifier = @"Search Collection View";
	
	_refreshControl = [[UIRefreshControl alloc] init];
	[_refreshControl addTarget:self
						action:@selector(startRefresh:)
			  forControlEvents:UIControlEventValueChanged];
	
	[self.collectionView addSubview:_refreshControl];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[_refreshControl beginRefreshing];
	[self startRefresh:nil];
	

}

#pragma mark - User Actions 

- (void)startRefresh:(id)sender
{
	__weak __block typeof(self) weakSelf = self;
	[[RGTAPIController sharedController] getSearchResultWithRequest:self.seatchRequest
														andCategory:self.category.categoryName
															 offset:0
														   pageSize:kRGTPSearchDefaultPageSize
															success:^(id responseObject, NSUInteger count) {
																
																weakSelf.searchResultsCount = count;
																
																weakSelf.results = responseObject;
																
																[weakSelf.collectionView reloadData];
																[weakSelf.refreshControl endRefreshing];
															} failure:^(NSError *error) {
																[weakSelf.refreshControl endRefreshing];
															}];
}

#pragma mark - Private

- (void)fetchNextPage
{
	__weak __block typeof(self) weakSelf = self;
	
	NSUInteger currentCount = self.results.count;
	
	if (currentCount < self.searchResultsCount) {
		[[RGTAPIController sharedController] getSearchResultWithRequest:self.seatchRequest
															andCategory:self.category.categoryName
																 offset:currentCount
															   pageSize:kRGTPSearchDefaultPageSize
																success:^(NSArray *responseObject, NSUInteger count) {
																	
																	NSIndexSet *insertIndex = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(weakSelf.results.count, responseObject.count)];
																	
																	NSMutableArray *insertItemsArray=[NSMutableArray array];
																	[insertIndex enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
																		[insertItemsArray addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
																	}];
																	
																	weakSelf.results = [weakSelf.results arrayByAddingObjectsFromArray:responseObject];
																	

																	
																	[weakSelf.collectionView insertItemsAtIndexPaths:insertItemsArray];
																	
																} failure:^(NSError *error) {
																	
																}];
	}

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"RGTOpenSearchDetailSegue"]) {
		RGTListingElement *listingElement = sender;
		RGTProductDetailTableViewController *destinationViewController = (RGTProductDetailTableViewController *)[segue destinationViewController];
		
		destinationViewController.productInfo = listingElement;
	}
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.results count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGTProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
																				   forIndexPath:indexPath];
	RGTListingElement *listingElement = [self.results objectAtIndex:indexPath.item];
	
	cell.productName.text = listingElement.name;
	
	if (listingElement.image75URL == nil) {
		[[RGTAPIController sharedController] getImageURLsForProduct:[listingElement.productID stringValue]
															success:^(NSString *imageSmallURL, NSString *imageLargeURL) {
																listingElement.image75URL = imageSmallURL;
																listingElement.image570URL = imageLargeURL;
																[cell.productImage sd_setImageWithURL:[NSURL URLWithString:imageSmallURL]];
															}
															failure:^(NSError *error) {
																
															}];
	} else {
		[cell.productImage sd_setImageWithURL:[NSURL URLWithString:listingElement.image75URL]];
	}
	
	if (indexPath.item == self.results.count - 1){
		[self fetchNextPage];
	}
    return cell;
}

#pragma mark - UICollectionViewDelegate Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
	return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	CGSize resSize = (CGSize){self.collectionView.bounds.size.width, 80.f};
	return resSize;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:@"RGTOpenSearchDetailSegue" sender:[self.results objectAtIndex:indexPath.row]];
}

@end
