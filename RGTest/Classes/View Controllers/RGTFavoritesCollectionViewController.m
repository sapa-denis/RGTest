//
//  RGTFavoritesCollectionViewController.m
//  RGTest
//
//  Created by Sapa Denys on 23.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTFavoritesCollectionViewController.h"
#import "RGTProductCollectionViewCell.h"

#import "RGTProductDetailTableViewController.h"

#import "RGTProduct.h"

@interface RGTFavoritesCollectionViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) BOOL shouldReloadCollectionView;
@property (nonatomic, strong) NSBlockOperation *blockOperation;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation RGTFavoritesCollectionViewController

static NSString * const reuseIdentifier = @"RGTProductCollectionViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier
													bundle:[NSBundle mainBundle]]
		  forCellWithReuseIdentifier:reuseIdentifier];
	
	_fetchedResultsController = [RGTProduct MR_fetchAllSortedBy:@"name"
													  ascending:YES
												  withPredicate:nil
														groupBy:nil
													   delegate:self];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	NSArray *arr = [RGTProduct MR_findAll];
	NSLog(@"%lu", (unsigned long)arr.count);
	

	[_fetchedResultsController performFetch:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"RGTFavoritDetailSegue"]) {
		RGTProduct *product = sender;
		RGTProductDetailTableViewController *destinationViewController = (RGTProductDetailTableViewController *)[segue destinationViewController];
		
		destinationViewController.productInfo = product;
	}
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	NSInteger numberOfRows = 0;
	if ([[self.fetchedResultsController sections] count] > section) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
		numberOfRows = [sectionInfo numberOfObjects];
	}
	return numberOfRows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RGTProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	
	RGTProduct *product = [_fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.productName.text = product.name;

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
	[self performSegueWithIdentifier:@"RGTFavoritDetailSegue"
							  sender:[_fetchedResultsController objectAtIndexPath:indexPath]];
}


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

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	self.shouldReloadCollectionView = NO;
	self.blockOperation = [[NSBlockOperation alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
	__weak UICollectionView *collectionView = self.collectionView;
	switch (type) {
		case NSFetchedResultsChangeInsert: {
			[self.blockOperation addExecutionBlock:^{
				[collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
			}];
			break;
		}
			
		case NSFetchedResultsChangeDelete: {
			[self.blockOperation addExecutionBlock:^{
				[collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
			}];
			break;
		}
			
		case NSFetchedResultsChangeUpdate: {
			[self.blockOperation addExecutionBlock:^{
				[collectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
			}];
			break;
		}
			
		default:
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
	__weak UICollectionView *collectionView = self.collectionView;
	switch (type) {
		case NSFetchedResultsChangeInsert: {
			if ([self.collectionView numberOfSections] > 0) {
				if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
					self.shouldReloadCollectionView = YES;
				} else {
					[self.blockOperation addExecutionBlock:^{
						[collectionView insertItemsAtIndexPaths:@[newIndexPath]];
					}];
				}
			} else {
				self.shouldReloadCollectionView = YES;
			}
			break;
		}
			
		case NSFetchedResultsChangeDelete: {
			if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
				self.shouldReloadCollectionView = YES;
			} else {
				[self.blockOperation addExecutionBlock:^{
					[collectionView deleteItemsAtIndexPaths:@[indexPath]];
				}];
			}
			break;
		}
			
		case NSFetchedResultsChangeUpdate: {
			[self.blockOperation addExecutionBlock:^{
				[collectionView reloadItemsAtIndexPaths:@[indexPath]];
			}];
			break;
		}
			
		case NSFetchedResultsChangeMove: {
			[self.blockOperation addExecutionBlock:^{
				[collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
			}];
			break;
		}
			
		default:
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	if (self.shouldReloadCollectionView) {
		[self.collectionView reloadData];
	} else {
		[self.collectionView performBatchUpdates:^{
			[self.blockOperation start];
		} completion:nil];
	}
}

@end
