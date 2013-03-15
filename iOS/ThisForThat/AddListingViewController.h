//
//  AddListingViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-14.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddListingViewController : UIViewController
- (IBAction)createListing:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *addListingTitleTextBox;
@property (weak, nonatomic) IBOutlet UITextView *addListingDescriptionTextBox;



@end
