//
//  listingsViewController.m
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-08.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "listingsViewController.h"

@interface listingsViewController ()

@end

@implementation listingsViewController

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
    
    //background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
