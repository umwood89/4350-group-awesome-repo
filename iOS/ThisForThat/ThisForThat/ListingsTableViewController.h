//
//  ListingsTableViewController.h
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-10.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingsTableViewController : UITableViewController

// RS: Testing button and textview
@property (weak, nonatomic) IBOutlet UITextView *testtextbox;
@property (copy, nonatomic) NSString *test;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addListing;


// RS: Listings array used to populate the tableview
@property (strong) NSMutableArray *listings;
- (IBAction)logoutButton:(id)sender;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
