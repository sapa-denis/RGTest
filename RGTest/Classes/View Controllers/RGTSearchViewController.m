//
//  RGTSearchViewController.m
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTSearchViewController.h"

#import "RGTSearchResultCollectionViewController.h"

#import "RGTAPIController.h"

#import "RGTCategory.h"

@interface RGTSearchViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;

@property (nonatomic, strong) NSArray<RGTCategory *> *categories;

@end

@implementation RGTSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	__weak __block typeof(self) weakSelf = self;
	[[RGTAPIController sharedController] getCategoriesWithSuccess:^(NSArray * categories) {
		
		weakSelf.categories = [RGTCategory MR_findAllSortedBy:@"fullName" ascending:YES];
		[weakSelf.categoryPicker reloadAllComponents];
	} failure:^(NSError *error) {
		[[[UIAlertView alloc] initWithTitle:@"Failure" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	}];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

#pragma mark - User Actions

- (IBAction)searchButtonTouchUp:(id)sender
{
	NSString *searchRequest = self.searchTextField.text;
	if ([searchRequest isEqualToString:@""]) {
		[[[UIAlertView alloc] initWithTitle:@"Search field cannot be empty" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
	} else {
		[self performSegueWithIdentifier:@"RGTOpenSearchResultSegue" sender:sender];
	}
	
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.categories count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	RGTCategory *category = [self.categories objectAtIndex:row];
	return category.fullName;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.searchTextField resignFirstResponder];
	return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"RGTOpenSearchResultSegue"]) {
		RGTSearchResultCollectionViewController *destinationViewController = (RGTSearchResultCollectionViewController *)segue.destinationViewController;
		
		NSInteger selectedIndex = [self.categoryPicker selectedRowInComponent:0];
		
		destinationViewController.category = [self.categories objectAtIndex:selectedIndex];
		destinationViewController.seatchRequest = self.searchTextField.text;
	}

}


@end
