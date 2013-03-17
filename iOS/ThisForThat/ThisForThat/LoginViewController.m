//
//  LoginViewController.m
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-09.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "LoginViewController.h"
#import "SecondViewController.h"
#import "ASIHTTPRequest.h"

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
    
    //Background Image
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
    NSString *username = self.usernameBox.text;
    NSString *password = self.passwordBox.text;
    
    NSURL *url = [NSURL URLWithString:@"http://hackshack.ca/JSONcheckpassword/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
     
    NSString *dataContent = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    NSLog(@"dataContent: %@", dataContent);\
    [request appendPostData:[dataContent dataUsingEncoding:NSUTF8StringEncoding]];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    
    NSLog(@"JSONLogin response: %@", response);
    
    [self performSegueWithIdentifier:@"tabBarController" sender:self];

}

- (IBAction)registerButton:(id)sender {
}

- (IBAction)guestButton:(id)sender {

    [self performSegueWithIdentifier:@"tabBarController" sender:self];
}
@end
