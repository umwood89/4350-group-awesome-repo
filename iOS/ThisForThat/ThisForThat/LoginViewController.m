//
//  LoginViewController.m
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-09.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "LoginViewController.h"
#import "SecondViewController.h"

@interface LoginViewController ()
- (IBAction)login:(id)sender;

@end

@implementation LoginViewController

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
    
    //Background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    
    //[self.childViewControllers.];
    //[self.childViewControllers.load];
    //[self.navigationController popViewControllerAnimated:YES];
     [self performSegueWithIdentifier:@"tabBarController" sender:self];
    
}
@end
