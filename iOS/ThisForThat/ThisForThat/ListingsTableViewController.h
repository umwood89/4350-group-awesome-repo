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
- (IBAction)makeItHappen:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *testtextbox;
@property (copy, nonatomic) NSString *test;


// RS: Listings array used to populate the tableview
@property (strong) NSMutableArray *listings;
- (IBAction)logoutButton:(id)sender;

@end
