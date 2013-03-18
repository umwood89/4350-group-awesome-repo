//
//  AddListingViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-14.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "AddListingViewController.h"
#import "ASIHTTPRequest.h"

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
    NSString *title = self.addListingTitleTextBox.text;
    NSString *description = self.addListingDescriptionTextBox.text;
    NSInteger user = 3;
    NSString *photo = @"photopath";
    
    NSURL *url = [NSURL URLWithString:@"http://hackshack.ca/api/listings/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    
    //NSString *dataContent = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    
    NSString *dataContent = [NSString stringWithFormat:@"{\"title\": \"%@\", \"description\": \"%@\", \"user\": %d, \"photo\": \"%@\" }", title, description, user, photo];
    
    NSLog(@"dataContent: %@", dataContent);
    [request appendPostData:[dataContent dataUsingEncoding:NSUTF8StringEncoding]];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
    NSString *response = [request responseString];
    NSLog(@"JSONAddListing response: %@", response);

    
}
- (IBAction)cancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
