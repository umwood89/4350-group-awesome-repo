//
//  LoginViewController.h
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-09.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameBox;
@property (weak, nonatomic) IBOutlet UITextField *passwordBox;
@property (weak, nonatomic) IBOutlet UILabel *loginStatus;

- (IBAction)loginButton:(id)sender;
- (IBAction)registerButton:(id)sender;
- (IBAction)guestButton:(id)sender;


@end
