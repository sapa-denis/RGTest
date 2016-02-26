//
//  RGTSearchResultCollectionViewController.m
//  RGTest
//
//  Created by Sapa Denys on 18.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTSearchResultCollectionViewController.h"
#import "RGTProductCollectionViewCell.h"
#import "RGTProductDetailTableViewController.h"
#import "RGTAPIController.h"

#import "RGTCategory.h"
#import "RGTListingElement.h"

#import "RGTProduct.h"

@interface RGTSearchResultCollectionViewController ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSArray *results;

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
															success:^(id responseObject) {
																weakSelf.results = responseObject;
																
																[weakSelf.collectionView reloadData];
																[weakSelf.refreshControl endRefreshing];
															} failure:^(NSError *error) {
																[weakSelf.refreshControl endRefreshing];
															}];
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
	RGTListingElement *listingElement = [self.results objectAtIndex:indexPath.row];
	
	cell.productName.text = listingElement.name;
	
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
