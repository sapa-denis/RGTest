//
//  RGTSearchViewController.m
//  RGTest
//
//  Created by Sapa Denys on 17.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "RGTSearchViewController.h"

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
		
		weakSelf.categories = [RGTCategory MR_findAllSortedBy:@"name" ascending:YES];
//		weakSelf.categories = categories;
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
	return category.name;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.searchTextField resignFirstResponder];
	return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
