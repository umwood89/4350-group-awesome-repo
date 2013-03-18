//
//  OffersTableViewController.h
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-10.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersTableViewController : UITableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (IBAction)logoutButton:(id)sender;

@end
