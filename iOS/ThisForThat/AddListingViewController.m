//
//  AddListingViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-14.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "AddListingViewController.h"

@interface AddListingViewController ()

@end

@implementation AddListingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createListing:(id)sender {
    
    
    
    
}
- (IBAction)cancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
