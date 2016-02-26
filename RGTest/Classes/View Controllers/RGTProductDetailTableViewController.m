//
//  RGTProductDetailTableViewController.m
//  RGTest
//
//  Created by Sapa Denys on 22.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTProductDetailTableViewController.h"

#import "RGTListingElement.h"
#import "RGTProduct.h"

@interface RGTProductDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (nonatomic, strong) UITextView *templateDescriptionTextView;

@end

@implementation RGTProductDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
	_templateDescriptionTextView = [[UITextView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.titleLabel.text = self.productInfo.name;
	self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", self.productInfo.price, self.productInfo.currencyCode];
	
	self.descriptionText.text = self.productInfo.fullDescription;
	
	RGTProduct *existingProduct = [RGTProduct MR_findFirstByAttribute:@"productID"
															withValue:self.productInfo.productID];
	
	if (existingProduct) {
		self.navigationItem.rightBarButtonItems = @[];
	} else {
		self.navigationItem.rightBarButtonItem = self.saveButton;
	}
}

#pragma mark - User Actions

- (IBAction)seveButtonTouchUp:(id)sender
{
	__weak __block typeof(self) weakSelf = self;
	[MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
		RGTProduct *product = [RGTProduct MR_createEntityInContext:localContext];
		
		product.name = weakSelf.productInfo.name;
		product.fullDescription = weakSelf.productInfo.fullDescription;
		product.price = weakSelf.productInfo.price;
		product.productID = weakSelf.productInfo.productID;
		
		product.currencyCode = weakSelf.productInfo.currencyCode;
	}];
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		return 145.f;
	} else if (indexPath.row == 1) {
		
		CGRect templateMaxFrame = CGRectMake(0, 0, _descriptionText.frame.size.width, MAXFLOAT);
		_templateDescriptionTextView.frame = templateMaxFrame;
		_templateDescriptionTextView.text = self.productInfo.fullDescription;
		
		CGFloat height = [self.templateDescriptionTextView sizeThatFits:templateMaxFrame.size].height;
		height = height < 60 ? 60 : height;
		return height;
	}
	return 0.f;
}

@end
