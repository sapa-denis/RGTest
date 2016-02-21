//
//  RGTSearchResultCollectionViewController.m
//  RGTest
//
//  Created by Sapa Denys on 18.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTSearchResultCollectionViewController.h"
#import "RGTProductCollectionViewCell.h"
#import "RGTAPIController.h"

#import "RGTCategory.h"

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
																
																[weakSelf.collectionView reloadData];
																
																[weakSelf.refreshControl endRefreshing];
															} failure:^(NSError *error) {
																[weakSelf.refreshControl endRefreshing];
															}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
	
//	cell.productName.text = @"test";
	
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

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
