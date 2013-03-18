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
    @try {
    NSString *username = self.usernameBox.text;
    NSString *password = self.passwordBox.text;
    
    // Check to see if password is correct
    self.loginStatus.text = @"Checking username and password...";
    NSURL *url = [NSURL URLWithString:@"http://hackshack.ca/JSONcheckpassword/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    //[request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
     
    NSString *dataContent = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    NSLog(@"dataContent: %@", dataContent);\
    [request appendPostData:[dataContent dataUsingEncoding:NSUTF8StringEncoding]];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    NSLog(@"JSONLogin response: %@", response);
    
    if([response isEqualToString:@"{\"result\": \"success\"}"] ) {
        
        url = [NSURL URLWithString:@"http://hackshack.ca/login/"];
        request = [ASIHTTPRequest requestWithURL:url];
        [request appendPostData:[dataContent dataUsingEncoding:NSUTF8StringEncoding]];
        [request setRequestMethod:@"POST"];
        [request startSynchronous];
        
        // Password was correct
        self.loginStatus.text = @"";
        
        [self performSegueWithIdentifier:@"tabBarController" sender:self];
    }
    else {
        // Incorrect Password
        self.loginStatus.text = @"Invalid username or password";
        
    }
    }@catch (NSException *e) {
      NSLog(@"Exception: %@", e);   
    }    

}

- (IBAction)registerButton:(id)sender {
    self.loginStatus.text = @"lol";
}

- (IBAction)guestButton:(id)sender {
    self.loginStatus.text = @"";
    [self performSegueWithIdentifier:@"tabBarController" sender:self];
}
@end
