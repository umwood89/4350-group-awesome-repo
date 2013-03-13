//
//  ListingsTableViewController.h
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-10.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingsTableViewController : UITableViewController
//- (IBAction)makeItHappen:(id)sender;
//@property (weak, nonatomic) IBOutlet UITextView *textboxtest;
- (IBAction)makeItHappen:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *testtextbox;
@property (copy, nonatomic) NSString *test;
@end
